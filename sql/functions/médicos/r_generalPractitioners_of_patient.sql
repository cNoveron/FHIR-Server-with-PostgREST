drop function if exists r_generalPractitioners_of_patient;

create or replace function r_generalPractitioners_of_patient(
    patient_id text
)
returns table(
    practitioner_id text,
    practitioner_name jsonb,
    practitioner_specialty text,
    practitioner_telecom jsonb
)
as $$
	select
		resource ->> 'id',
		resource #> '{name,0}',
		resource #>> '{specialty,0,coding,0,display}',
		resource #> '{telecom}'
	from practitioner
    where (
        practitioner.resource->>'id' in(
            select
                resource #>> '{generalPractitioner,0,id}'
            from patient
        )
    );
$$ language sql;