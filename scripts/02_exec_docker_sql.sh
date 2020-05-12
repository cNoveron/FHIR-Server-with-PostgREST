#!/bin/sh
docker exec -i teeb \
    psql -h localhost \
        -U postgres \
        -p 5432 \
        -a \
< ./sql/create_tables.sql

docker exec -i teeb \
    psql -h localhost \
        -U postgres \
        -p 5432 \
        -a \
< ./sql/insert_if_not_exists.sql

docker exec -i teeb \
    psql -h localhost \
        -U postgres \
        -p 5432 \
        -a \
< ./sql/function_public.check_user.sql