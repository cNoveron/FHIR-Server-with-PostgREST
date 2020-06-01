drop function if exists r_generalPractitioners_of;

create or replace function r_generalPractitioners_of(
    patient_id text
)
returns table(
    practitioner_id text,
    practitioner_name text,
    practitioner_specialty text
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