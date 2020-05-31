drop function if exists r_patients;

create or replace function r_patients()
	returns table(
		patient_id text,
		patient_name text,
		patient_surname text
	)
as $$
	select
		resource ->> 'id',
		resource -> 'name' -> 0 #> '{given}' ->> 0,
		resource -> 'name' -> 0 #>> '{family}'
	from patient;
$$ language sql;