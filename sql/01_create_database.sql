create user teeb;
grant all privileges on database fhir_db to teeb;
drop database if exists fhirbase;
create extension if not exists "uuid-ossp";
