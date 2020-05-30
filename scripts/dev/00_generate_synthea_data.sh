#!/bin/sh

echo "#### Running synthea build... ####"
cd synthea && ./gradlew build -x test && cd ..

chmod +x ./synthea/run_synthea

echo "#### Running Docker container from Fhirbase image... ####"
cd ./synthea && ./run_synthea -p 50 && cd ..

