#!/bin/sh
set -e

psql -U postgres -d fhirbase_v4 < /fhirbase/sql/pacientes/r_patients.sql
psql -U postgres -d fhirbase_v4 < /fhirbase/sql/médicos/r_practitioners.sql

psql -U postgres -d fhirbase_v4 < /fhirbase/sql/agenda/r_slots.sql
psql -U postgres -d fhirbase_v4 < /fhirbase/sql/consultas/r_appointments.sql

psql -U postgres -d fhirbase_v4 < /fhirbase/sql/estudios_laboratorio/hemograma/r_diagnosticreport_blood_count.sql
psql -U postgres -d fhirbase_v4 < /fhirbase/sql/estudios_laboratorio/urinalisis/r_diagnosticreport_urinalysis.sql
psql -U postgres -d fhirbase_v4 < /fhirbase/sql/estudios_laboratorio/tomografía/r_diagnosticreport_imaging.sql