#!/bin/sh
set -e

# Inits the fhirbase data

echo "#### Creating fhir_db.0.0 database in Postgres instance... ####"

psql -d fhir_db -U postgres -p 5432 < /fhirbase/sql/01_create_database.sql

echo "#### Fhirbase init... ####"

fhirbase -d fhir_db --fhir=4.0.0 init

echo "#### Updating tables... ####"
psql -d fhir_db -U postgres -p 5432 < /fhirbase/sql/02_alter_fhir_tables.sql

echo "#### Updating postgrest data... ####"
psql -d fhir_db -U postgres -p 5432 < /fhirbase/sql/03_create_postgrest_data.sql

echo "#### Updating anon_web permissions... ####"
psql -d fhir_db -U postgres -p 5432 < /fhirbase/sql/04_update_permissions_to_web_anon.sql

echo "#### Updating authenticator permissions... ####"
psql -d fhir_db -U postgres -p 5432 < /fhirbase/sql/05_update_permissions_to_authenticator.sql
