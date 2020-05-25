#!/bin/sh
echo "#### Pulling Fhirbase... ####"
docker pull fhirbase/fhirbase:v0.1.1 &

echo "#### Downloading PostgREST... ####"
wget https://github.com/PostgREST/postgrest/releases/download/v7.0.0/postgrest-v7.0.0-ubuntu.tar.xz
echo "#### PostgREST successfully downloaded. Extracting... ####"
tar -Jxvf postgrest-v7.0.0-ubuntu.tar.xz
echo "#### PostgREST successfully extracted ####"
ls -l