drop function if exists r_schedule;

create or replace function r_schedule(actor_id varchar)
	returns table(
		id text,
		planning_horizon text
	)
as $$
	select
		resource -> 'id',
		resource->'planningHorizon'
	from schedule
	where(
		to_timestamp(
			resource->'planningHorizon'->>'start',
			'YYYY-MM-DD HH:MI:SS'
		) > CURRENT_TIMESTAMP
		and
		resource -> 'actor'-> 0 ->> 'id' = actor_id
	);
$$ language sql;

-- select * from r_schedule('1');