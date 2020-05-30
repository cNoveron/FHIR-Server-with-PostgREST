FROM fhirbase/fhirbase:v0.1.1

RUN psql 

EXPOSE 3000 5432
