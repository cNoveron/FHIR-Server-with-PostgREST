drop function if exists r_slots_by_schedule;

create or replace function r_slots_by_schedule(
	schedule_id text
)
returns table(
	slot_id text,
	slot_start text,
	slot_end text,
	slot_status text
)
as $$
	select
		resource ->> 'id',
		resource ->> 'start',
		resource ->> 'end',
		resource ->> 'status'
	from slot
	where(
		slot.resource #>> '{schedule,id}' in(
			select
				resource ->> 'id'
			from schedule
			where(
				schedule.resource ->> id = schedule_id
			)
		)
	);
$$ language sql;