sudo docker run --name teeb \
    -p 5432 \
    -e POSTGRES_HOST_AUTH_METHOD=trust \
    -d postgres
