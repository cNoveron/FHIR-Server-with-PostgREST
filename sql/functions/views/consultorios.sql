drop function if exists consultorios;

create or replace function consultorios(
    chargeitem_note text,
    chargeitem_code_display text,
	organization_display text,
	specialty_code_display text,
	practitioner_name_string text,
	location_name_string text
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
		practitionerrole.resource #>> '{specialty,0,coding,0,display}' @@ specialty_code_display
		and
		practitionerrole.resource #>> '{specialty,1,coding,0,display}' @@ specialty_code_display
		and
		practitionerrole.resource #>> '{specialty,2,coding,0,display}' @@ specialty_code_display
		and
		practitionerrole.resource #>> '{organization,display}' @@ organization_display
		and
		practitionerrole.resource #>> '{practitioner,display}' @@ practitioner_name_string
		and
		practitionerrole.resource #>> '{location,0,display}' @@ location_name_string
	);
end;
$$ language 'plpgsql';