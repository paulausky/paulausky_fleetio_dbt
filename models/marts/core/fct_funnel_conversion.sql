{{ config(materialized='table') }}

with leads_base as (
    select *
    from {{ ref('stg_fleetio__leads') }}
),


contacts_base as (
    select *
    from {{ ref('stg_fleetio__contacts') }}
),


opportunities_base as (
    select *
    from {{ ref('stg_fleetio__opportunities') }}
),


base_joins as (
    select 
        l.lead_id,
        l.lead_converted_flag,
        l.lead_converted_timestamp,
        l.lead_convert_date_cont,            -- continuous dates for plotting bar charts
        l.lead_convert_week_cont,            -- continuous dates for plotting bar charts
        l.lead_convert_month_cont,           -- continuous dates for plotting bar charts
        l.lead_convert_date,                 -- for tooltips
        l.lead_convert_week,                 -- for tooltips
        l.lead_convert_month,                -- for tooltips
        l.lead_convert_year_week,            -- for axis labels
        l.lead_convert_year_month,           -- for axis labels
        l.lead_convert_year,
        l.lead_source,
        l.first_name,
        l.last_name,
        l.job_title,
        l.email,
        l.company,
        l.city,
        l.state,
        l.country,
        l.industry,
        l.fleet_size,
		l.fleet_size_sort,
		l.fleet_size_min,
        l.lead_created_timestamp, 
        l.lead_create_date_cont,             -- continuous dates for plotting bar charts
        l.lead_create_week_cont,             -- continuous dates for plotting bar charts
        l.lead_create_month_cont,            -- continuous dates for plotting bar charts
        l.lead_create_date,                  -- for tooltips
        l.lead_create_week,                  -- for tooltips
        l.lead_create_month,                 -- for tooltips
        l.lead_create_year_week,             -- for axis labels
        l.lead_create_year_month,            -- for axis labels
        l.lead_create_year,
        l.time_to_convert_lead,

        c.contact_id,
        c.account_id,
        c.contact_created_timestamp,

        o.opportunities_id,
        o.opportunity_created_timestamp,
        o.opportunity_create_date_cont,       -- continuous dates for plotting bar charts
        o.opportunity_create_week_cont,       -- continuous dates for plotting bar charts
        o.opportunity_create_month_cont,      -- continuous dates for plotting bar charts
        o.opportunity_create_date,            -- for tooltips
        o.opportunity_create_week,            -- for tooltips
        o.opportunity_create_month,           -- for tooltips
        o.opportunity_create_year_week,       -- for axis labels
        o.opportunity_create_year_month,      -- for axis labels
        o.opportunity_create_year,
        o.opportunity_closed_timestamp,
        o.opportunity_close_date_cont,        -- continuous dates for plotting bar charts
        o.opportunity_close_week_cont,        -- continuous dates for plotting bar charts
        o.opportunity_close_month_cont,       -- continuous dates for plotting bar charts
        o.opportunity_close_date,             -- for tooltips
        o.opportunity_close_week,             -- for tooltips
        o.opportunity_close_month,            -- for tooltips
        o.opportunity_close_year_week,        -- for axis labels
        o.opportunity_close_year_month,       -- for axis labels
        o.opportunity_close_year,
        o.opportunity_closed_flag,
        o.opportunity_won_flag,
        o.time_to_close_opportunity,          -- null if not closed yet
        o.time_to_win_opportunity             -- null is lost or not closed yet

    from leads_base l 
    left join contacts_base c on l.lead_id = c.lead_id
    left join opportunities_base o on c.account_id = o.account_id
),


final as (
    select 
        *,
        opportunity_closed_timestamp - lead_created_timestamp as time_lead_create_to_close      -- duration between lead created and opportunity closed
    from base_joins
)


select * 
from final