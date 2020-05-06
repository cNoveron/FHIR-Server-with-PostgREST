docker exec -i tutorial \
    psql -h localhost \
        -U postgres \
        -p 5432 \
        -a \
< ../sql/Patient_Bio.sql