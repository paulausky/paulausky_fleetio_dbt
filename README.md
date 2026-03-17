# Fleetio Senior Analytics Engineer - Technical Assessment
### Patricia Paulausky

---

## Overview
This repo contains dbt models and supporting documentation built to answer 
a series of stakeholder questions about lead conversion and opportunity performance 
using Fleetio's sample sales data.

---

## Approach
I took the following steps when designing this dbt project:

1. **Reviewed available data** — assessed the quality and structure of the available CSV sources (leads, contacts, accounts, opportunities)
2. **Reviewed stakeholder questions** — identified what needed to be answered and which data sources were relevant
3. **Designed reporting outputs first** — took a top-down approach, starting with how stakeholders would consume the information before writing any SQL
4. **Designed dbt models to support reporting** — built staging and fact models to clean, structure, and join the data in a way that efficiently supports the proposed visualizations

---

## Stakeholder Questions & Proposed Visualizations

### Question 1: How many leads were converted by different time grains (day, week, and month)?
- **Bar chart** — converted lead counts by day, week, and month with a time grain toggle
- **KPI cards** — max converted count by day, week, and month for period comparison
- **Period over period comparisons** — YoY, MoM, and WoW trend analysis

### Question 2: Which lead sources generated the most converted leads at different time grains?
- **Stacked bar chart** — converted lead counts by time grain with bars broken out by lead source
- **KPI cards** — max converted count by source and time grain
- **Period over period comparisons** — YoY, MoM, and WoW trend analysis by source

### Questions 3 & 4: What are possible drivers of lead conversion and closed/won opportunities?
Both questions will be answered using a consistent framework of converted vs non-converted 
and won vs lost comparisons across the following dimensions:

- **Time metrics** — average and median time from lead creation to conversion, and from lead creation to closed/won opportunity
- **Lead source** — top 5 sources for converted vs non-converted and won vs lost
- **Industry** — top 5 industries for converted vs non-converted and won vs lost
- **Fleet size** — top 5 fleet size categories for converted vs non-converted and won vs lost
- **Job title** — top 5 job titles for converted vs non-converted and won vs lost
- **Geographic location** — top 5 cities, states, or countries for converted vs non-converted and won vs lost

---

## Project Structure
```
models/
  staging/
    stg_fleetio__leads.sql
    stg_fleetio__contacts.sql
    stg_fleetio__accounts.sql
    stg_fleetio__opportunities.sql
    stg_fleetio.yml
    src_fleetio.yml
  marts/
    core/
      fct_funnel_conversion.sql
      core.yml
macros/
  fleet_size_sort.sql
  fleet_size_min.sql
seeds/
  seed_leads.csv
  seed_contacts.csv
  seed_accounts.csv
  seed_opportunities.csv
```

---

## Models
| Model | Layer | Description |
|---|---|---|
| `stg_fleetio__leads` | Staging | Cleans and prepares raw leads data with conversion flags and date fields at multiple time grains |
| `stg_fleetio__contacts` | Staging | Cleans and prepares raw contacts data |
| `stg_fleetio__accounts` | Staging | Cleans and prepares raw accounts data with fleet size sort and min fields |
| `stg_fleetio__opportunities` | Staging | Cleans and prepares raw opportunities data with closed/won flags and date fields at multiple time grains |
| `fct_funnel_conversion` | Marts | Joins leads, contacts, and opportunities to provide a full view of the lead to opportunity lifecycle |

---

## Macros
| Macro | Description |
|---|---|
| `fleet_size_sort` | Maps fleet size text ranges to a numeric sort order for correct ordering in BI tools |
| `fleet_size_min` | Maps fleet size text ranges to the minimum numeric value of each range for analysis |