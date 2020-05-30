drop function if exists r_appointments;

create or replace function r_appointments(actor_id varchar)
	returns table(
		appointment_id jsonb,
		appointment_start jsonb,
		appointment_end jsonb,
		appointment_specialty jsonb
	)
as $$
	select
		resource -> 'id',
		resource -> 'requestedPeriod' -> 0 -> 'start',
		resource -> 'requestedPeriod' -> 0 -> 'end',
		resource -> 'specialty' -> 0 -> 'coding' -> 0 -> 'display'
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
						actor ->> 'id' = actor_id
					)
				)
			)
		)
	);
$$ language sql;