drop function if exists r_appointments_in_schedules_of_specialty;

create or replace function r_appointments_in_schedules_of_specialty(
	schedule_specialty_code text
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
		resource #>> '{requestedPeriod,0,start}',
		resource #>> '{requestedPeriod,0,end}',
		resource #>> '{specialty,0,coding,0,display}',
		resource #>> 'participant'
	from appointment
	where(
		appointment.resource #>> '{slot,0,id}' in(
			select
				resource ->> 'id'
			from slot
			where(
				slot.resource #>> '{schedule,id}' in(
					select
						resource ->> 'id'
					from schedule
					where(
						schedule.resource #>> '{specialty,0,coding,0,code}' = schedule_specialty_code
					)
				)
			)
		)
	);
$$ language sql;