drop function if exists r_practitionerroles_by_practitioner_name;

create or replace function r_practitionerroles_by_practitioner_name(
    practitioner_name text
)
returns table(
    practitionerrole_id text,
    practitionerrole_availableTime jsonb,
    practitionerrole_location text,
	practitionerrole_telecom jsonb
)
as $$
$$ language sql;