drop function if exists r_schedule;
 
create or replace function r_schedule(
	planning_horizon_start timestamp,
	actor_id varchar
)
	returns table(id jsonb, planning_horizon jsonb) 
as $$ 
	select resource->'id',resource->'planningHorizon' from schedule 
		where to_timestamp(resource->'planningHorizon'->>'start','YYYY-MM-DD HH:MI:SS') > planning_horizon_start 
		and resource->'actor'->0->>'id'=actor_id;
$$ language sql;


--select * from r_schedule('2013-12-25 09:30:01', '1');
