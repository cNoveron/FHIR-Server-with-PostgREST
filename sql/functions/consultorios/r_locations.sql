drop function if exists r_locations;

create or replace function r_locations()
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
		resource #>> '{address,postalCode}',
		resource #>> '{address,state}',
		resource #>> '{address,country}'
	from location;
$$ language sql;