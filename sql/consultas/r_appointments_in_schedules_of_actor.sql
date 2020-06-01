drop function if exists r_appointments_of_schedules_of_actor;

create or replace function r_appointments_of_schedules_of_actor(
	schedule_actor_id varchar
)
returns table(
	appointment_id text,
	appointment_start text,
	appointment_end text,
	appointment_specialty text,
	appointment_participant jsonb
)
as $$
	select
		resource ->> 'id',
		resource -> 'requestedPeriod' -> 0 ->> 'start',
		resource -> 'requestedPeriod' -> 0 ->> 'end',
		resource -> 'specialty' -> 0 -> 'coding' -> 0 ->> 'display',
		jsonb_array_elements(resource -> 'participant')
	from appointment,
		jsonb_array_elements(resource -> 'slot') slot
	where(
		slot ->> 'id' in(
			select
				resource ->> 'id'
			from slot
			where(
				resource -> 'schedule' ->> 'id' in(
					select
						resource ->> 'id'
					from schedule,
						jsonb_array_elements(resource -> 'actor') actor
					where(
						actor ->> 'id' = schedule_actor_id
					)
				)
			)
		)
	);
$$ language sql;