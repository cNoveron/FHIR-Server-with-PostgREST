drop function if exists r_practitioners;

create or replace function r_practitioners(patient_id varchar)
	returns table(
		practitioner_id jsonb,
		practitioner_name jsonb,
		practitioner_specialty jsonb
	)
as $$
	select
		resource -> 'id',
		resource -> 'name',
		resource -> 'specialty' -> 0 -> 'coding' -> 0 -> 'display'
	from practitioner
    where (
        resource ->> 'id' in (
            select
                resource ->> 'generalPractitioner'
            from patient
            where(
                resource ->> 'id' = patient_id
            )
        )
    );
$$ language sql;