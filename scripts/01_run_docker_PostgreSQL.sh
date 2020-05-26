#!/bin/sh
docker rm /teeb
sudo docker run --name teeb \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=n0m3l0 \
    -d postgres