FROM fhirbase/fhirbase:v0.1.1

WORKDIR /app

# Copy the scripts
COPY ./sql ./sql
COPY ./scripts ./scripts

# Build synthea and generate data
RUN ./synthea/run_synthea -p 5

# Initialize database
RUN ./scripts/dev/01_initialize_database.sh

# Inits the fhirbase data
RUN fhirbase -d fhirbase_v4 --fhir=4.0.0 init

# Loads FHIR Data
RUN fhirbase -d fhirbase_v4 --fhir=4.0.0 load /bundle.ndjson.gzip

# Load Functions 
RUN ./scripts/dev/02_load_functions.sh

# curl 'http://localhost:3001/appointment?resource->participant->0->actor->>id=eq.example&select=resource->start'

EXPOSE 3000 5432
