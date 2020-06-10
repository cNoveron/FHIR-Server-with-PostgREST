#!/bin/sh
set -e

# Inits the fhirbase data

echo "#### Initialize fhir_db.0.0 database in Postgres instance -> Creating teeb user... ####"
psql -h localhost -p 5435 -U postgres -d fhir_db  < /fhirbase/sql/01_create_database.sql

echo "#### Fhirbase init... ####"
fhirbase --fhir=4.0.0 init

echo "#### Updating tables... ####"
psql -h localhost -p 5435 -U postgres -d fhir_db  < /fhirbase/sql/02_alter_fhir_tables.sql

echo "#### Updating postgrest data... ####"
psql -h localhost -p 5435 -U postgres -d fhir_db  < /fhirbase/sql/03_create_postgrest_data.sql

echo "#### Updating permissions... ####"
psql -h localhost -p 5435 -U postgres -d fhir_db  < /fhirbase/sql/04_update_permissions.sql
