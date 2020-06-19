drop function if exists r_practitioners;

create or replace function r_practitioners()
returns table(
    practitioner_id text,
    practitioner_name jsonb,
    practitioner_specialty text
)
as $$
	select
		resource ->> 'id',
		resource #> '{name,0}',
		resource #>> '{specialty,0,coding,0,display}'
	from practitioner
    where (
        practitioner.resource ->> 'id' in(
            select
                resource #>> '{generalPractitioner,0,id}'
            from patient
        )
    );
$$ language sql;