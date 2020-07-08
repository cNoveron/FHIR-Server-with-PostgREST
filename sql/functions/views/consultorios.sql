drop function if exists consultorios;

create or replace function consultorios(
    chargeitem_note text,
    chargeitem_code_display text,
	organization_id text,
	specialty_code text,
	search_text text
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
		chargeitem.resource @> ('{"code":{"coding":[{"display":"'||chargeitem_code_display||'"}]}}')::jsonb
		and
		practitionerrole.resource @> ('{"organization":{"id":"'||organization_id||'"}}')::jsonb
		and
		practitionerrole.resource @> ('{"specialty":[{"coding":[{"code":"'||specialty_code||'"}]}]}')::jsonb
		and(
			practitionerrole.resource #>> '{practitioner,display}' @@ search_text
			or
			practitionerrole.resource #>> '{practitioner,display}' ilike search_text||'%'
			or
			practitionerrole.resource #>> '{location,0,display}' @@ search_text
			or
			practitionerrole.resource #>> '{location,0,display}' ilike search_text||'%'
		)
	);
end;
$$ language 'plpgsql';