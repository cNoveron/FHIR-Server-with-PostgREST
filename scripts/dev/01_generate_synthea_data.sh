#!/bin/sh
set -e

echo "####      Running synthea build...        ####"
cd synthea && ./gradlew build -x test && cd ..

chmod +x ./synthea/run_synthea

echo "####      Generating 50 patients...       ####"
cd ./synthea && ./run_synthea -p 50 && cd ..
