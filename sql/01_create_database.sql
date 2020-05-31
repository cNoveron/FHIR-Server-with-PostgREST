create user ${POSTGRES_USER} with password '${POSTGRES_PASSWORD}';
grant all privileges on database fhirbase_v4 to ${POSTGRES_USER};

create extension if not exists "uuid-ossp";
