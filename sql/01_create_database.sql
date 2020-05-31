create user teeb;
drop database fhirbase;
grant all privileges on database fhirbase_v4 to teeb;

create extension if not exists "uuid-ossp";
