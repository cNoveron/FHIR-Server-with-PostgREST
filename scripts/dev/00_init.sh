#!/bin/sh
set -e

echo "#### Running /fhirbase/scripts/dev/02_initialize_database.sh... ####"
sh ./scripts/dev/02_initial_db_update.sh

echo "#### Running /fhirbase/scripts/dev/04_load_functions.sh... ####"
sh ./scripts/dev/03_load_functions.sh
