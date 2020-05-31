
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/pacientes/r_patients.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/médicos/r_practitioners.sql

psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/horarios/r_schedules.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/agenda/r_slots.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/consultas/r_appointments.sql

psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/estudios_laboratorio/hemograma/r_diagnosticreport_blood_count.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/estudios_laboratorio/urinalisis/r_diagnosticreport_urinalysis.sql
psql "postgres://teeb:$1@119.8.11.33:5432/fhirbase_v4" \
< ./sql/estudios_laboratorio/tomografía/r_diagnosticreport_imaging.sql