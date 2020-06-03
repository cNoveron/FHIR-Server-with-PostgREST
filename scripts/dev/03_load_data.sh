#!/bin/sh
set -e

echo "####    Loading data into DB using Fhirbase...    ####"

fhirbase -d fhir_db load --mode=insert /fhirbase/synthea/output/fhir/*
fhirbase -d fhir_db load --mode=insert /fhirbase/data/*
