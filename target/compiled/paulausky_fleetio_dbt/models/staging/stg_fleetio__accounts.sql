

with accounts_base as (
    select *
    from "fleetio_test"."public"."seed_accounts"
),


final as (
select 
	id                                              as account_id,
	company,
	primary_contact_id                              as contact_id,
	city, 
	state, 
	country, 
	industry,
	fleet_size,
    

case
    when fleet_size = '<15'     then 1
    when fleet_size = '15-99'   then 2
    when fleet_size = '100-499' then 3
    when fleet_size = '500-999' then 4
    when fleet_size = '>1000'   then 5
end

             as fleet_size_sort,
    

case
    when fleet_size = '<15'     then 1
    when fleet_size = '15-99'   then 15
    when fleet_size = '100-499' then 100
    when fleet_size = '500-999' then 500
    when fleet_size = '>1000'   then 1000
end

              as fleet_size_min
from accounts_base
)


select * 
from final