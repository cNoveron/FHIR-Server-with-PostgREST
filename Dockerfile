FROM postgres:10.5

WORKDIR /fhirbase

COPY bin/fhirbase /usr/bin/fhirbase

RUN chmod +x /usr/bin/fhirbase

RUN mkdir /pgdata && chown postgres:postgres /pgdata

# Copy the scripts
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

USER postgres

RUN PGDATA=/pgdata /docker-entrypoint.sh postgres  & \
    until psql -U postgres -c '\q'; do \
        >&2 echo "Postgres is starting up..."; \
        sleep 5; \
    done && \
    psql -U postgres -c 'create database fhirbase_v4;' && \
    /fhirbase/scripts/dev/00_init.sh \
    pg_ctl -D /pgdata stop

EXPOSE 3000 5432

CMD pg_ctl -D /pgdata start && until psql -U postgres -c '\q'; do \
        >&2 echo "Postgres is starting up..."; \
        sleep 5; \
    done && \
    exec fhirbase -d fhirbase web
