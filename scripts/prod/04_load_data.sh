#!/bin/sh
echo "####    Loading data into DB using Fhirbase...    ####"
fhirbase -n 119.8.11.33 -d fhirbase_v4 -U teeb -W $1 load synthea/output/fhir/*
fhirbase -n 119.8.11.33 -d fhirbase_v4 -U teeb -W $1 load data/*