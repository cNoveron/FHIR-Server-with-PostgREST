#!/bin/sh
echo "#### Creating Fhirbase_v4.0.0 database in Postgres instance... ####"
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/01_create_database.sql

echo "#### Initializing database with FHIR schema... ####"
fhirbase -n 119.8.11.33 -d fhirbase_v4 -U teeb --fhir=4.0.0 init

echo "#### Updating tables... ####"
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/02_alter_fhir_tables.sql

echo "#### Updating postgrest data... ####"
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/03_create_postgrest_data.sql

echo "#### Updating anon_web permissions... ####"
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/04_update_permissions_to_web_anon.sql

echo "#### Updating authenticator permissions... ####"
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/05_update_permissions_to_authenticator.sql

