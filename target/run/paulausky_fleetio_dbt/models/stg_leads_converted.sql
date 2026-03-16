
  
    

  create  table "fleetio_test"."public"."stg_leads_converted__dbt_tmp"
  
  
    as
  
  (
    

with leads_base as (
select * 
from "fleetio_test"."public"."seed_leads"
),

final as (
select
	id as leads_id,
	case when converted_at is not null then 1 else 0 end as lead_converted_flag,
	converted_at as converted_timestamp,
	DATE_TRUNC('day', converted_at) as lead_convert_date_cont, -- continuous dates for plotting bar charts
	DATE_TRUNC('week', converted_at) as lead_convert_week_cont, -- continuous dates for plotting bar charts
    DATE_TRUNC('month', converted_at) as lead_convert_month_cont, -- continuous dates for plotting bar charts
    date(converted_at) as lead_convert_date, -- for tool tips
    date(DATE_TRUNC('week', converted_at)) as lead_convert_week, -- for tool tips
    date(DATE_TRUNC('month', converted_at)) as lead_convert_month, -- for tool tips
    TO_CHAR(converted_at, 'IYYY-IW') as lead_convert_year_week, -- for axis labels
    TO_CHAR(converted_at, 'YYYY-MM') AS lead_convert_year_month, -- for axis labels
    EXTRACT(year from converted_at) as lead_convert_year,
	source,
	first_name,
	last_name,
	job_title, 
	email,
	company,
	city,
	state,
	country,
	industry,
	fleet_size,
	created_at,
	DATE_TRUNC('day', created_at) as lead_create_date_cont, -- continuous dates for plotting bar charts
	DATE_TRUNC('week', created_at) as lead_create_week_cont, -- continuous dates for plotting bar charts
    DATE_TRUNC('month', created_at) as lead_create_month_cont, -- continuous dates for plotting bar charts
    date(created_at) as lead_create_date, -- for tool tips
    date(DATE_TRUNC('week', created_at)) as lead_create_week, -- for tool tips
    date(DATE_TRUNC('month', created_at)) as lead_create_month, -- for tool tips
    TO_CHAR(created_at, 'IYYY-IW') as lead_create_year_week, -- for axis labels
    TO_CHAR(created_at, 'YYYY-MM') AS lead_create_year_month, -- for axis labels
    EXTRACT(year from created_at) as lead_create_year,
	converted_at - created_at as time_to_convert
from leads_base
)

select *
from final
  );
  