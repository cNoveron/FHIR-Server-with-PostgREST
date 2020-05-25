#!/bin/sh
echo "#### Creating Fhirbase_v4.0.0 database in Postgres instance... ####"
docker exec -i fhirbase psql -d fhirbase_v4 < ./sql/create_database.sql

echo "#### Initializing database with FHIR schema... ####"
fhirbase -d fhirbase_v4 --fhir=4.0.0 init