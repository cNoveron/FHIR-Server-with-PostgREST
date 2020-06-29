drop function if exists practitioner_name_by_chargeitem_note;

create or replace function practitioner_name_by_chargeitem_note(
    chargeitem_note text
)
returns table(
    practitioner_name text
)
as $$
	select
		resource #>> '{name}'
	from practitioner
	where(
		practitioner.resource ->> 'id' in(
			select
				resource #>> '{practitioner,id}'
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
			)
		)
	);
$$ language sql;