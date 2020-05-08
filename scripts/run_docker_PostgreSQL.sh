#!/bin/sh
docker rm /teeb
sudo docker run --name teeb \
    -p 4321:4321 \
    -e POSTGRES_PASSWORD=1234 \
    -d postgres