drop function if exists consultorios_filtrados_by_chargeitem_note;

create or replace function consultorios_filtrados_by_chargeitem_note(
    chargeitem_note text
)
returns table(
    practitionerrole_id text,
    practitioner_name text,
    practitionerrole_availableTime jsonb,
    practitionerrole_location text,
	practitionerrole_telecom jsonb,
	serviceType_code jsonb,
	practitionerrole_base_appointment_price jsonb
)
as $$
begin
	return query select
		*
	from consultorios_by_chargeitem_note(chargeitem_note) as consultorios inner join healthcareservice
	on healthcareservice.resource #>> '{location,0,id}' = consultorios.practitionerrole_location;
end;
$$ language 'plpgsql';