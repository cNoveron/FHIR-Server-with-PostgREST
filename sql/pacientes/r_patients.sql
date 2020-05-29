drop function if exists r_patients;

create or replace function r_patients()
	returns table(
		patient_id jsonb,
		patient_name jsonb
	)
as $$
	select
		resource -> 'id',
		resource -> 'name'
	from patient;
$$ language sql;