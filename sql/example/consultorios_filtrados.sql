drop function if exists consultorios_filtrados;

create or replace function consultorios_filtrados(
    chargeitem_note text,
	organization_id text,
	specialty_code text,
	practitioner_name_string text,
	location_name_string text
)
returns table(
    practitionerrole_id text,
    practitioner_name text,
    practitionerrole_availableTime jsonb,
    practitionerrole_location text,
	practitionerrole_telecom jsonb,
	chargeitem_code jsonb,
	chargeitem_base_appointment_price jsonb,
	healthcareservice_type jsonb
)
as $$
begin
	return query select
		consultorios.practitionerrole_id,
		consultorios.practitioner_name,
		consultorios.practitionerrole_availableTime,
		consultorios.practitionerrole_location,
		consultorios.practitionerrole_telecom,
		consultorios.chargeitem_code,
		consultorios.chargeitem_base_appointment_price,
		healthcareservice.resource #> '{type}'
	from consultorios(
			chargeitem_note,
			organization_id,
			specialty_code,
			practitioner_name_string,
			location_name_string
		) as consultorios
		inner join healthcareservice
	on healthcareservice.resource #>> '{location,0,id}' = consultorios.practitionerrole_location;
end;
$$ language 'plpgsql';