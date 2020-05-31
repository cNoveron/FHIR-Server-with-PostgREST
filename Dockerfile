FROM golang:1.13.11-alpine AS fhirbase-builder

WORKDIR /fhirbase

COPY fhirbase/ ./fhirbase

# Generates Fhirbase binary

WORKDIR /fhirbase/fhirbase

RUN go build 

FROM postgres:10.5

WORKDIR /fhirbase

COPY --from=fhirbase-builder /fhirbase/fhirbase /fhirbase/fhirbase/

RUN mv /fhirbase/fhirbase/fhirbase /usr/bin/fhirbase

# Copy the files
RUN mkdir ./sql
RUN mkdir ./scripts
RUN mkdir -p ./synthea/output/fhir/
RUN mkdir ./data

COPY sql/ ./sql
COPY scripts/ ./scripts
COPY scripts-postgrest/ ./scripts-postgrest
COPY synthea/output/fhir/ ./synthea/output/fhir/
COPY data/ ./data

# Set the permissions
RUN ["chmod", "-R", "+x", "./sql"]
RUN ["chmod", "-R", "+x", "./scripts"]
RUN ["chmod", "-R", "+x", "./scripts-postgrest"]
RUN ["chmod", "-R", "+x", "./synthea/output/fhir"]
RUN ["chmod", "-R", "+x", "./data"]

RUN chmod +x /usr/bin/fhirbase

RUN mkdir /pgdata && chown postgres:postgres /pgdata

USER postgres

RUN PGDATA=/pgdata /docker-entrypoint.sh postgres  & \
    until psql -U postgres -c '\q'; do \
        >&2 echo "Postgres is starting up..."; \
        sleep 5; \
    done && \
    psql -U postgres -c 'create database fhirbase_v4;' && \
    /fhirbase/scripts/dev/00_init.sh; \
    pg_ctl -D /pgdata stop

EXPOSE 3000 5432

CMD pg_ctl -D /pgdata start && until psql -U postgres -c '\q'; do \
        >&2 echo "Postgres is starting up..."; \
        sleep 5; \
    done && \ 
    which fhirbase && \
    exec fhirbase -d fhirbase_v4 web
