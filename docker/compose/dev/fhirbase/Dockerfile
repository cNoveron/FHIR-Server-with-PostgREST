FROM postgres:10.5

WORKDIR /fhirbase

COPY ./compose/dev/fhirbase/bin/fhirbase /usr/local/bin/fhirbase

COPY ./compose/dev/fhirbase/maintenance/fhirbase-entrypoint.sh /usr/local/bin/
COPY ./compose/dev/fhirbase/synthea/ ./synthea/output/fhir/
COPY ./compose/dev/fhirbase/teeb/ ./data

RUN chmod +x /usr/local/bin/fhirbase && \
    chmod +x /usr/local/bin/fhirbase-entrypoint.sh && \
    ln -s /usr/local/bin/fhirbase-entrypoint.sh .

ENTRYPOINT ["fhirbase-entrypoint.sh"]

# RUN psql -h $POSTGRES_HOST -U $POSTGRES_USER -c 'create database $POSTGRES_DB;' && \
#     fhirbase --host $POSTGRES_HOST -p $POSTGRES_PORT -d $POSTGRES_DB -U $POSTGRES_USER -W $POSTGRES_PASSWORD --fhir=4.0.0 init

CMD exec fhirbase --host ${POSTGRES_HOST} -p ${POSTGRES_PORT} -d ${POSTGRES_DB} -U ${POSTGRES_USER} -W ${POSTGRES_PASSWORD}  web
