FROM fhirbase/fhirbase:v0.1.1

USER root

WORKDIR /fhirbase

COPY sql/ ./sql
COPY scripts/ ./scripts
COPY scripts-postgrest/ ./scripts-postgrest
COPY synthea/output/fhir/ ./synthea/output/fhir/
COPY data/ ./data
COPY libraries/postgrest /usr/local/bin

RUN mkdir /etc/postgrest && \ 
    cp ./scripts-postgrest/scripts/postgrest.config /etc/postgrest/config && \
    cp ./scripts-postgrest/scripts/postgrest.service /etc/systemd/system/postgrest.service && \
    systemctl enable postgrest && systemctl start postgrest

# Set the permissions
RUN chown -R postgres:postgres  ./sql/* && \
    chown -R postgres:postgres  ./scripts/* && \
    chown -R postgres:postgres  ./scripts-postgrest/* && \
    chown -R postgres:postgres  ./synthea/output/fhir/* && \
    chown -R postgres:postgres  /usr/local/bin/postgrest && \
    chown -R postgres:postgres  ./data/*

USER postgres

RUN PGDATA=/pgdata /docker-entrypoint.sh postgres  & \
    until psql -U postgres -c '\q'; do \
        >&2 echo "Postgres is starting up..."; \
        sleep 5; \
    done && \
    psql -U postgres -c 'create database fhirbase_v4;' && \
    sh /fhirbase/scripts/dev/00_init.sh \
    pg_ctl -D /pgdata stop

EXPOSE 3000 5432 4000

CMD pg_ctl -D /pgdata start && until psql -U postgres -c '\q'; do \
        >&2 echo "Postgres is starting up..."; \
        sleep 5; \
    done && \
    exec fhirbase -d fhirbase_v4 -n localhost -U postgres web
