FROM fhirbase/fhirbase:v0.1.1

# Creates de fhirbase database 
RUN psql 

RUN CREATE DABATASE fhirbase_v4;

RUN DROP DATABASE fhirbase;

RUN \q;

# inits the fhuirbase data

RUN fhirbase -d fhirbase_v4 --fhir=4.0.0 init

# Loads FHIR Data
RUN fhirbase -d FHIRBASE_v4 --fhir=4.0.0 load /bundle.ndjson.gzip

EXPOSE 3000 5432
