docker exec -i teeb \
    psql -h localhost \
        -U postgres \
        -p 5432 \
        -a \
< ../sql/create_tables.sql