drop function if exists todays_slots_for_actor;

create or replace function todays_slots_for_actor(
	actor_id text
)
returns table(
	slot_id text,
	slot_start text,
	slot_end text,
	slot_status text
)
as $$
	select
		slot.resource ->> 'id',
		slot.resource ->> 'start',
		slot.resource ->> 'end',
		slot.resource ->> 'status'
	from slot
	where(
		slot.resource #>> '{schedule,id}' in(
			select
				resource ->> 'id'
			from schedule
			where(
				schedule.resource #>> '{actor}' = actor_id
				and
				to_timestamp(slot.resource #>> '{start}', 'YYYY-MM-DD HH24:MI:SS') > CURRENT_TIMESTAMP
				and
				to_date(slot.resource #>> '{start}', 'YYYY-MM-DD HH24:MI:SS') < CURRENT_DATE + '1 day'::interval
			)
		)
	);
$$ language sql;