FROM fhirbase/fhirbase:v0.1.1

USER root

WORKDIR /fhirbase

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
RUN chown -R postgres:postgres  ./sql/*
RUN chown -R postgres:postgres  ./scripts/*
RUN chown -R postgres:postgres  ./scripts-postgrest/*
RUN chown -R postgres:postgres  ./synthea/output/fhir/*
RUN chown -R postgres:postgres  ./data/*

USER postgres

RUN PGDATA=/pgdata /docker-entrypoint.sh postgres  & \
    until psql -U postgres -c '\q'; do \
        >&2 echo "Postgres is starting up..."; \
        sleep 5; \
    done && \
    psql -U postgres -c 'create database fhirbase_v4;' && \
    sh /fhirbase/scripts/dev/00_init.sh \
    pg_ctl -D /pgdata stop

EXPOSE 3000 5432

CMD pg_ctl -D /pgdata start && until psql -U postgres -c '\q'; do \
        >&2 echo "Postgres is starting up..."; \
        sleep 5; \
    done && \
    exec fhirbase -d fhirbase_v4 -U postgres -d postgres web
