drop function if exists r_appointments_in_schedules_of_service_category;

create or replace function r_appointments_in_schedules_of_service_category(
	schedule_service_category_code text
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
					from schedule
					where(
						resource #>> '{serviceCategory,0,coding,0,code}' = schedule_service_category_code
					)
				)
			)
		)
	);
$$ language sql;