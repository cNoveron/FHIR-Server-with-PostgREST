#!/bin/sh
set -e

echo "#### Running /fhirbase/scripts/dev/02_initialize_database.sh... ####"
sh /fhirbase/scripts/dev/02_initialize_database.sh

echo "#### Running /fhirbase/scripts/dev/03_load_data.sh... ####"
sh /fhirbase/scripts/dev/03_load_data.sh

echo "#### Running /fhirbase/scripts/dev/04_load_functions.sh... ####"
sh /fhirbase/scripts/dev/04_load_functions.sh
