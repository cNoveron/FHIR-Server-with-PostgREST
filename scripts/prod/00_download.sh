#!/bin/sh
echo "#### Pulling Fhirbase... ####"
docker pull fhirbase/fhirbase:v0.1.1 &

# echo "#### Downloading Fhirbase... ####"
# wget https://github.com/fhirbase/fhirbase/archive/v0.1.1.tar.gz
# echo "#### Extracting tar file... ####"
# tar -xvf fhirbase-linux-amd64
# echo "#### Changing permissions for the binary... ####"
# chmod a+x fhirbase-linux-amd64
# echo "#### Moving binary to /usr/bin/ as 'fhirbase'... ####"
# mv fhirbase-linux-amd64 /usr/bin/fhirbase


echo "#### Downloading PostgREST... ####"
wget https://github.com/PostgREST/postgrest/releases/download/v7.0.0/postgrest-v7.0.0-ubuntu.tar.xz
echo "#### PostgREST successfully downloaded. Extracting... ####"
tar -Jxvf postgrest-v7.0.0-ubuntu.tar.xz
echo "#### PostgREST successfully extracted ####"
ls -l