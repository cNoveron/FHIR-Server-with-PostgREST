drop function if exists r_practitionerroles_by_specialty;

create or replace function r_practitionerroles_by_specialty(
    specialty_code text
)
returns table(
    practitionerrole_id text,
    practitionerrole_availableTime jsonb,
    practitionerrole_location text,
	practitionerrole_telecom jsonb
)
as $$
$$ language sql;