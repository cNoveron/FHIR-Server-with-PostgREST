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
	select
		resource ->> 'id',
		resource #> '{availableTime}',
		resource #>> '{location,0,display}',
		resource #> '{telecom}'
	from practitionerrole
	where(
		practitionerrole.resource ->> 'id' in(
			select
				resource #>> '{performer,0,actor,id}'
			from chargeitem
			where(
				chargeitem.resource @> ('{"note":[{"text":"'||chargeitem_note||'"}]}')::jsonb
			)
		)
	);
$$ language sql;