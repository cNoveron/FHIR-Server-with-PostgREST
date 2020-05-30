#!/bin/sh
echo "#### Initializing database with FHIR schema... ####"
fhirbase -d fhirbase_v4 load

curl 'http://localhost:3001/appointment?resource->participant->0->actor->>id=eq.example&select=resource->start'