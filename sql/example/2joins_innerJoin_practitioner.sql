drop function if exists 2joins_innerJoin_practitioner;

create or replace function 2joins_innerJoin_practitioner(
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
		joined_twice.practitionerrole_id,
		joined_twice.practitioner_name,
		joined_twice.practitionerrole_availableTime,
		joined_twice.practitionerrole_location,
		joined_twice.practitionerrole_telecom,
		joined_twice.chargeitem_code,
		joined_twice.chargeitem_base_appointment_price,
		joined_twice.healthcareservice_type,
		practitioner.resource #>> '{qualification,issuer}'
	from practicionerrole_inner_join_chargeitem(
			chargeitem_note,
			organization_id,
			specialty_code,
			practitioner_name_string,
			location_name_string
		) as joined_twice
		inner join practitioner
	on practitioner.resource #>> '{id}' = joined_twice.practitioner_id;
end;
$$ language 'plpgsql';