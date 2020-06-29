drop function if exists r_practitionerroles_by_organization;

create or replace function r_practitionerroles_by_organization(
    location_id text
)
returns table(
    practitionerrole_id text,
    practitionerrole_availableTime jsonb,
    practitionerrole_location text,
	practitionerrole_telecom jsonb
)
as $$
$$ language sql;