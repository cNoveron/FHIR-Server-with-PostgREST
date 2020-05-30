FROM fhirbase/fhirbase:v0.1.1

ENV POSTGRES_USER='teeb' \
    POSTGRES_PASSWORD='d3s4rr0ll0'

USER root

WORKDIR /app

# Copy the scripts
RUN mkdir ./sql
RUN mkdir ./scripts
RUN mkdir -p ./synthea/output/fhir/
RUN mkdir ./data


COPY ./sql ./sql
COPY ./scripts ./scripts

COPY ./synthea/output/fhir/ ./synthea/output/fhir/
COPY ./data/ ./data

# Initialize database
RUN ./scripts/dev/01_initialize_database.sh

# Inits the fhirbase data
RUN -n localhost fhirbase -d fhirbase_v4 --fhir=4.0.0 init

# Loads FHIR Data

RUN fhirbase -n localhsot -d fhirbase_v4 -U $POSTGRES_USER -W $POSTGRES_PASSWORD load ./synthea/output/fhir/*
RUN fhirbase -n localhost -d fhirbase_v4 -U $POSTGRES_USER -W $POSTGRES_PASSWORD load ./data/*

# Load Functions 
RUN ./scripts/dev/02_load_functions.sh

# curl 'http://localhost:3001/appointment?resource->participant->0->actor->>id=eq.example&select=resource->start'

EXPOSE 3000 5432
