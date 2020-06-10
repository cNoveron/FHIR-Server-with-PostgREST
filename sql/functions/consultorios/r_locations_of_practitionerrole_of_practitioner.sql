drop function if exists r_locations;

create or replace function r_locations(
	practitioner_id text
)
	returns table(
		location_id text,
		location_name text,
		location_address text,
		location_city text,
		location_state text,
		location_country text
	)
as $$
	select
		resource ->> 'id',
		resource ->> 'name',
		resource #>> '{address,line,0}',
		resource #>> '{address,city}',
		resource #>> '{address,state}',
		resource #>> '{address,country}',
	from location
	where(
		location.resource ->> 'id' in(
			select
				resource #>> '{location,0,id}'
			from practitionerrole
			where(
				practitionerrole.resource #>> '{practitioner,id}' = practitioner_id
			)
		)
	);
$$ language sql;