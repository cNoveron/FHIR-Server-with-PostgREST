#!/bin/sh
set -e

psql -h localhost -U postgres -d fhirbase_v4 < sql/pacientes/r_patients.sql
psql -h localhost -U postgres -d fhirbase_v4 < sql/médicos/r_practitioners.sql

psql -h localhost -U postgres -d fhirbase_v4 < sql/agenda/r_slots.sql
psql -h localhost -U postgres -d fhirbase_v4 < sql/consultas/r_appointments.sql

psql -h localhost -U postgres -d fhirbase_v4 < sql/estudios_laboratorio/hemograma/r_diagnosticreport_blood_count.sql
psql -h localhost -U postgres -d fhirbase_v4 < sql/estudios_laboratorio/urinalisis/r_diagnosticreport_urinalysis.sql
psql -h localhost -U postgres -d fhirbase_v4 < sql/estudios_laboratorio/tomografía/r_diagnosticreport_imaging.sql