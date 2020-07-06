drop function if exists practicionerrole_inner_join_healthcareservice;

create or replace function practicionerrole_inner_join_healthcareservice(
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
		joined_once.practitionerrole_id,
		joined_once.practitioner_name,
		joined_once.practitionerrole_availableTime,
		joined_once.practitionerrole_location,
		joined_once.practitionerrole_telecom,
		joined_once.chargeitem_code,
		joined_once.chargeitem_base_appointment_price,
		joined_twice.
	from practicionerrole_inner_join_chargeitem(
			chargeitem_note,
			organization_id,
			specialty_code,
			practitioner_name_string,
			location_name_string
		) as joined_twice
		inner join healthcareservice
	on healthcareservice.resource #>> '{location,0,id}' = joined_once.practitionerrole_location;
end;
$$ language 'plpgsql';