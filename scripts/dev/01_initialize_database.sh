#!/bin/sh

echo "#### Creating Fhirbase_v4.0.0 database in Postgres instance... ####"
psql -d fhirbase_v4 < ./sql/01_create_database.sql

echo "#### Updating tables... ####"
psql -d fhirbase_v4 < ./sql/02_alter_fhir_tables.sql

echo "#### Updating postgrest data... ####"
psql -d fhirbase_v4 < ./sql/03_create_postgrest_data.sql

echo "#### Updating anon_web permissions... ####"
psql -d fhirbase_v4 < ./sql/04_update_permissions_to_web_anon.sql

echo "#### Updating authenticator permissions... ####"
psql -d fhirbase_v4 < ./sql/05_update_permissions_to_authenticator.sql

echo "#### Loading postgrest functions... ####"
psql -d fhirbase_v4 < ./scripts-postgrest/001_r_consultations.sql
psql -d fhirbase_v4 < ./scripts-postgrest/002_get_id_from_diagnostic_report.sql
psql -d fhirbase_v4 < ./scripts-postgrest/003_r_schedule.sql
psql -d fhirbase_v4 < ./scripts-postgrest/004_r_slot.sql
psql -d fhirbase_v4 < ./scripts-postgrest/005_r_ece_lab_display_metadata_blood_count.sql
psql -d fhirbase_v4 < ./scripts-postgrest/006_r_ece_lab_display_metadata_urinalysis.sql
psql -d fhirbase_v4 < ./scripts-postgrest/007_r_ece_lab_display_metadata_tomography.sql

