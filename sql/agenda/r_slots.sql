drop function if exists r_agenda;

create or replace function r_slots(actor_id varchar)
	returns table(
		slot_id jsonb,
		slot_start jsonb,
		slot_end jsonb,
		slot_status jsonb
	)
as $$
	select
		resource -> 'id',
		resource -> 'start',
		resource -> 'end',
		resource -> 'status'
	from slot
	where(
		resource -> 'schedule' ->> 'id' in(
			select
				resource ->> 'id'
			from schedule,
				jsonb_array_elements(resource -> 'actor') actor
			where(
				actor ->> 'id' = actor_id
			)
		)
	);
$$ language sql;

-- select * from r_slot('1');