drop function if exists r_practitionerroles_by_practitioner_name;

create or replace function r_practitionerroles_by_practitioner_name(
    practitioner_name text
)
returns table(
    practitionerrole_id text,
    practitioner_name text,
    practitionerrole_availableTime jsonb,
    practitionerrole_location text,
	practitionerrole_telecom jsonb
)
as $$
	select
		resource ->> 'id',
		resource #>> '{practitioner,display}',
		resource #> '{availableTime}',
		resource #>> '{location,0,display}',
		resource #> '{telecom}'
	from practitionerrole
	where(
		practitionerrole.resource #>> '{practitioner,id}' in(
			select
				resource ->> 'id'
			from practitioner
			where(
				practitioner.resource @> ('{"name":"{"family":"'||practitioner_name||'"}}')::jsonb
			)
		)
	);
$$ language sql;