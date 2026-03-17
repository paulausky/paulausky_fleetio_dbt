

with leads_base as (
    select *
    from "fleetio_test"."public"."seed_leads"
),


final as (
    select
        id                                              as lead_id,
        case
            when converted_at is not null then 1
            else 0
        end                                             as lead_converted_flag,
        converted_at                                    as lead_converted_timestamp,
        date_trunc('day', converted_at)                 as lead_convert_date_cont,      -- continuous dates for plotting bar charts
        date_trunc('week', converted_at)                as lead_convert_week_cont,      -- continuous dates for plotting bar charts
        date_trunc('month', converted_at)               as lead_convert_month_cont,     -- continuous dates for plotting bar charts
        date(converted_at)                              as lead_convert_date,           -- for tooltips
        date(date_trunc('week', converted_at))          as lead_convert_week,           -- for tooltips
        date(date_trunc('month', converted_at))         as lead_convert_month,          -- for tooltips
        to_char(converted_at, 'IYYY-IW')                as lead_convert_year_week,      -- for axis labels
        to_char(converted_at, 'YYYY-MM')                as lead_convert_year_month,     -- for axis labels
        extract(year from converted_at)                 as lead_convert_year,
        source                                          as lead_source,
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

              as fleet_size_min,
        created_at                                      as lead_created_timestamp, 
        date_trunc('day', created_at)                   as lead_create_date_cont,       -- continuous dates for plotting bar charts
        date_trunc('week', created_at)                  as lead_create_week_cont,       -- continuous dates for plotting bar charts
        date_trunc('month', created_at)                 as lead_create_month_cont,      -- continuous dates for plotting bar charts
        date(created_at)                                as lead_create_date,            -- for tooltips
        date(date_trunc('week', created_at))            as lead_create_week,            -- for tooltips
        date(date_trunc('month', created_at))           as lead_create_month,           -- for tooltips
        to_char(created_at, 'IYYY-IW')                  as lead_create_year_week,       -- for axis labels
        to_char(created_at, 'YYYY-MM')                  as lead_create_year_month,      -- for axis labels
        extract(year from created_at)                   as lead_create_year,
        converted_at - created_at                       as time_to_convert_lead
    from leads_base
)


select *
from final