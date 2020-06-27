#!/bin/sh
set -e

# Inits the fhirbase data

echo "#### Updating tables... ####"
psql -h localhost -p 5435 -U teeb -d fhir_db  < ./sql/02_alter_fhir_tables.sql

echo "#### Updating permissions... ####"
psql -h localhost -p 5435 -U teeb -d fhir_db  < ./sql/04_update_permissions.sql
