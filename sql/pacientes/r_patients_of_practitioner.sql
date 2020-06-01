drop function if exists r_patients_of_practitioner;

create or replace function r_patients_of_practitioner(
	practitioner_id text
)
returns table(
	patient_id text,
	patient_name text,
	patient_surname text,
	patient_phone text
)
as $$
	select
		resource ->> 'id',
		resource -> 'name' -> 0 #> '{given}' ->> 0,
		resource -> 'name' -> 0 #>> '{family}',
		resource #>> '{telecom,0,value}'
	from patient
	where(
		resource ->> 'generalPractitioner' = practitioner_id
	);
$$ language sql;