#!/bin/sh
set -e

echo "####    Loading data into DB using Fhirbase...    ####"

fhirbase -d fhirbase_v4 load --mode=insert /fhirbase/synthea/output/fhir/*
fhirbase -d fhirbase_v4 load --mode=insert /fhirbase/data/*