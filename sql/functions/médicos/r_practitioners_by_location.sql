drop function if exists r_practitioners_by_location;

create or replace function r_practitioners_by_location(
    location_id text
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
	where(
		location.resource ->> 'id' in(
			select
				resource #>> '{practitioner,id}'
			from practitionerrole
			where(
				practitionerrole.resource #>> '{location,0,id}' = location_id
			)
		)
	);
$$ language sql;