#!/bin/sh
set -e

# Agenda
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/agenda/r_slots.sql

# Consultas
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/consultas/r_appointments_by_actor.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/consultas/r_appointments_by_serviceCategory.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/consultas/r_appointments_by_serviceType.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/consultas/r_appointments_by_specialty.sql

# Consultorios
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/consultorios/r_locations.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/consultorios/r_locations_by_practitioner.sql

# Estudios laboratorios
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/estudios_laboratorio/hemograma/r_diagnosticreport_blood_count.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/estudios_laboratorio/urinalisis/r_diagnosticreport_urinalysis.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/estudios_laboratorio/tomografía/r_diagnosticreport_imaging.sql

# Horarios
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/horarios/r_schedules_by_actor.sql

# Médicos
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/médicos/r_generalPractitioners_of_patient.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/médicos/r_practitioners.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/médicos/r_practitioners_by_location.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/médicos/r_practitioners_by_serviceType.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/médicos/r_practitioners_by_specialty.sql

# Pacientes
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/pacientes/r_patients.sql
psql -h localhost -p 5435 -U teeb -d fhir_db \
< ./sql/functions/pacientes/r_patients_of_practitioner.sql
