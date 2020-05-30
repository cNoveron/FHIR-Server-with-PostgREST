FROM fhirbase/fhirbase:v0.1.1


WORKDIR /app

# Copy the scripts
COPY ./sql ./sql
COPY ./scripts ./scripts

# Build synthea and generate data
RUN ./synthea/run_synthea -p 5

RUN ./scripts/dev/02_initialize_database.sh

# Creates de fhirbase database 
RUN ./scripts/dev/02_initialize_database.sh

# inits the fhuirbase data

RUN fhirbase -d fhirbase_v4 --fhir=4.0.0 init

# Loads FHIR Data
RUN fhirbase -d FHIRBASE_v4 --fhir=4.0.0 load /bundle.ndjson.gzip

EXPOSE 3000 5432
