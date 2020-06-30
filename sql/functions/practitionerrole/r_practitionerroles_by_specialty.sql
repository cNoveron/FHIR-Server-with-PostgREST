drop function if exists r_practitionerroles_by_specialty;

create or replace function r_practitionerroles_by_specialty(
    specialty_code text
)
returns table(
    practitionerrole_id text,
    practitioner_name text,
    practitionerrole_availableTime jsonb,
    practitionerrole_    text,
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
    where (
		resource @> ('{"specialty":[{"coding":[{"code":"'||specialty_code||'"}]}]}')::jsonb
    );
$$ language sql;