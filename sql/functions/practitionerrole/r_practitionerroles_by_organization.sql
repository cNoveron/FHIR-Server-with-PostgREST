drop function if exists r_practitionerroles_by_organization;

create or replace function r_practitionerroles_by_organization(
    organization_id text
)
returns table(
    practitionerrole_id text,
    practitionerrole_availableTime jsonb,
    practitionerrole_location text,
	practitionerrole_telecom jsonb
)
as $$
	select
		resource ->> 'id',
		resource #> '{availableTime}',
		resource #>> '{location,0,display}',
		resource #> '{telecom}'
	from practitionerrole
    where (
		resource @> ('{"organization":"[{"id":'||organization_id||'"}]}')::jsonb
    );
$$ language sql;