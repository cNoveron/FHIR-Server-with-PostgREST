#!/bin/sh
echo "#### Creating Fhirbase_v4.0.0 database in Postgres instance... ####"
docker exec -i fhirbase psql -d fhirbase_v4 < ./sql/01_create_database.sql

echo "#### Updating tables... ####"
docker exec -i fhirbase psql -d fhirbase_v4 < ./sql/02_alter_fhir_tables.sql

echo "#### Updating postgrest data... ####"
docker exec -i fhirbase psql -d fhirbase_v4 < ./sql/03_create_postgrest_data.sql

echo "#### Updating anon_web permissions... ####"
docker exec -i fhirbase psql -d fhirbase_v4 < ./sql/04_update_permissions_to_web_anon.sql

echo "#### Updating authenticator permissions... ####"
docker exec -i fhirbase psql -d fhirbase_v4 < ./sql/05_update_permissions_to_authenticator.sql


echo "#### Initializing database with FHIR schema... ####"
fhirbase -d fhirbase_v4 --fhir=4.0.0 init