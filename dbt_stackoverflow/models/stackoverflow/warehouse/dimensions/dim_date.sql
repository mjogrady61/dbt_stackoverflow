
{{ config(materialized="table") }}


SELECT

    actual_date,
    actual_day_name,
    month_actual,
    quarter_actual,
    year_actual,
    iso_day_of_week,
    week_number,
    day_of_week,
    week_start,
    week_end,
    month_start,
    month_end,
    quarter_start,
    quarter_end,

FROM {{ref('stg_date')}}