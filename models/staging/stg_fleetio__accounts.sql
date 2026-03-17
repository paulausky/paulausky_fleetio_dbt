{{ config(materialized='table') }}

with accounts_base as (
    select *
    from {{ source('fleetio', 'seed_accounts') }}
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
    {{ fleet_size_sort('fleet_size') }}             as fleet_size_sort,
    {{ fleet_size_min('fleet_size') }}              as fleet_size_min
from accounts_base
)


select * 
from final 