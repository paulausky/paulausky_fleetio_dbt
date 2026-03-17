{{ config(materialized='table') }}

with contacts_base as (
    select *
    from {{ source('fleetio', 'seed_contacts') }}
),


final as (
select 
	id               as contact_id,
	first_name,
	last_name,
	job_title,
	email,
	account_id,
	lead_id,
	created_at       as contact_created_timestamp
from contacts_base
)


select * 
from final 