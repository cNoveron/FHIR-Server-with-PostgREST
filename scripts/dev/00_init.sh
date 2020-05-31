#!/bin/sh
set -e
/fhirbase/02_initialize_database.sh
/fhirbase/03_load_data.sh
/fhirbase/04_load_functions.sh