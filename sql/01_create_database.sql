create user teeb;
grant all privileges on database fhirbase_v4 to teeb;
drop database if exists fhirbase;
create extension if not exists "uuid-ossp";
