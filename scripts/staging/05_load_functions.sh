#!/bin/sh
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/agenda/r_slots.sql

psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/consultas/r_appointments_by_actor.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/consultas/r_appointments_by_serviceCategory.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/consultas/r_appointments_by_serviceType.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/consultas/r_appointments_by_specialty.sql

psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/consultorios/r_locations.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/consultorios/r_locations_by_practitioner.sql

psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/estudios_laboratorio/hemograma/r_diagnosticreport_blood_count.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/estudios_laboratorio/urinalisis/r_diagnosticreport_urinalysis.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/estudios_laboratorio/tomografía/r_diagnosticreport_imaging.sql

psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/horarios/r_schedules_by_actor.sql

psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/médicos/r_practitioners.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/médicos/r_generalPractitioners_of_patient.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/médicos/r_practitioners_by_location.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/médicos/r_practitioners_by_serviceType.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/médicos/r_practitioners_by_specialty.sql

psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/pacientes/r_patients.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/functions/pacientes/r_patients_of_practitioner.sql