#!/bin/sh
docker stop teeb_dev_postgres
docker rm teeb_dev_postgres
docker run --name teeb_dev_postgres \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD='1234' \
    -d postgres