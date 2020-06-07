#!/bin/sh
exec fhirbase -d fhir_db -n localhost -U postgres web
