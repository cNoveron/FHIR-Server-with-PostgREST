#!/bin/sh
echo "#### Running Docker container from Fhirbase image... ####"
docker run --name teeb_fhir_server \
    -p 3000:3000 \
    -p 5432:5432 \
    -d fhirbase/fhirbases &

echo "#### Building Synthea ####"
./synthea/gradlew build check test &
