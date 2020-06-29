drop function if exists r_practitionerroles_by_specialty;

create or replace function r_practitionerroles_by_specialty(
    specialty_code text
)
returns table(
    practitionerrole_id text,
    practitionerrole_availableTime jsonb,
    practitionerrole_    text,
	practitionerrole_telecom jsonb
)
as $$
	select
		resource ->> 'id',
		resource #> '{availableTime}',
		resource #>> '{location,0,display}',
		resource #> '{telecom}'
	from practitionerrole

$$ language sql;