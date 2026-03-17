{{ config(materialized='table') }}

with opportunities_base as (
    select *
    from {{ source('fleetio', 'seed_opportunities') }}
),


final as (
    select
        id                                              as opportunities_id,
        account_id, 
        created_at                                      as opportunity_created_timestamp,
        date_trunc('day', created_at)                   as opportunity_create_date_cont,       -- continuous dates for plotting bar charts
        date_trunc('week', created_at)                  as opportunity_create_week_cont,       -- continuous dates for plotting bar charts
        date_trunc('month', created_at)                 as opportunity_create_month_cont,      -- continuous dates for plotting bar charts
        date(created_at)                                as opportunity_create_date,            -- for tooltips
        date(date_trunc('week', created_at))            as opportunity_create_week,            -- for tooltips
        date(date_trunc('month', created_at))           as opportunity_create_month,           -- for tooltips
        to_char(created_at, 'IYYY-IW')                  as opportunity_create_year_week,       -- for axis labels
        to_char(created_at, 'YYYY-MM')                  as opportunity_create_year_month,      -- for axis labels
        extract(year from created_at)                   as opportunity_create_year,
        closed_at                                       as opportunity_closed_timestamp,
        date_trunc('day', closed_at)                    as opportunity_close_date_cont,      -- continuous dates for plotting bar charts
        date_trunc('week', closed_at)                   as opportunity_close_week_cont,      -- continuous dates for plotting bar charts
        date_trunc('month', closed_at)                  as opportunity_close_month_cont,     -- continuous dates for plotting bar charts
        date(closed_at)                                 as opportunity_close_date,           -- for tooltips
        date(date_trunc('week', closed_at))             as opportunity_close_week,           -- for tooltips
        date(date_trunc('month', closed_at))            as opportunity_close_month,          -- for tooltips
        to_char(closed_at, 'IYYY-IW')                   as opportunity_close_year_week,      -- for axis labels
        to_char(closed_at, 'YYYY-MM')                   as opportunity_close_year_month,     -- for axis labels
        extract(year from closed_at)                    as opportunity_close_year,
        is_closed                                       as opportunity_closed_flag,
        is_won                                          as opportunity_won_flag,
        closed_at - created_at                          as time_to_close_opportunity,        -- null if not closed yet
        case
            when is_won then closed_at - created_at
            else null 
        end                                             as time_to_win_opportunity,          -- null is lost or not closed yet
        city,
        state,
        country
    from opportunities_base 
)


select *
from final