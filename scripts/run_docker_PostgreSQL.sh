#!/bin/sh
sudo docker run --name teeb \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=1234 \
    -d postgres