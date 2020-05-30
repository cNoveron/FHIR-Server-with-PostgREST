
docker exec -i fhirbase psql -h "$1" -U teeb -d fhirbase_v4 \
< ./sql/pacientes/r_patients.sql
docker exec -i fhirbase psql -h "$1" -U teeb -d fhirbase_v4 \
< ./sql/médicos/r_practitioners.sql

docker exec -i fhirbase psql -h "$1" -U teeb -d fhirbase_v4 \
< ./sql/agenda/r_appointments.sql
docker exec -i fhirbase psql -h "$1" -U teeb -d fhirbase_v4 \
< ./sql/consultas/r_appointments.sql

docker exec -i fhirbase psql -h "$1" -U teeb -d fhirbase_v4 \
< ./sql/estudios_laboratorio/hemograma/r_diagnosticreport_blood_count.sql
docker exec -i fhirbase psql -h "$1" -U teeb -d fhirbase_v4 \
< ./sql/estudios_laboratorio/urinalisis/r_diagnosticreport_urinalysis.sql
docker exec -i fhirbase psql -h "$1" -U teeb -d fhirbase_v4 \
< ./sql/estudios_laboratorio/tomografía/r_diagnosticreport_imaging.sql