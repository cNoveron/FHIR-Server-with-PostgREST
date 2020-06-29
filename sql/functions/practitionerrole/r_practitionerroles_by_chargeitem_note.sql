drop function if exists r_practitionerroles_by_chargeitem_note;

create or replace function r_practitionerroles_by_chargeitem_note(
    chargeitem_note text
)
returns table(
    practitionerrole_id text,
    practitionerrole_availableTime jsonb,
    practitionerrole_location text,
	practitionerrole_telecom jsonb
)
as $$
$$ language sql;