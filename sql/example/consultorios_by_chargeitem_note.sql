drop function if exists consultorios_by_chargeitem_note;

create or replace function consultorios_by_chargeitem_note(
    chargeitem_note text,
	organization_id text,
	specialty_code text
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
		practitionerrole.resource ->> 'id',
		practitionerrole.resource #>> '{practitioner,display}',
		practitionerrole.resource #> '{availableTime}',
		practitionerrole.resource #>> '{location,0,id}',
		practitionerrole.resource #> '{telecom}',
		chargeitem.resource #> '{code,coding}',
		chargeitem.resource #> '{priceOverride}'
	from practitionerrole inner join chargeitem
	on practitionerrole.resource #>> '{id}' = chargeitem.resource #>> '{performer,0,actor,id}'
	where(
		chargeitem.resource @> ('{"note":[{"text":"'||chargeitem_note||'"}]}')::jsonb
		and
		practitionerrole.resource @> ('{"organization":{"id":"'||organization_id||'"}}')::jsonb
		and
		practitionerrole.resource @> ('{"specialty":[{"coding":[{"code":"'||specialty_code||'"}]}]}')::jsonb
	);
end;
$$ language 'plpgsql';