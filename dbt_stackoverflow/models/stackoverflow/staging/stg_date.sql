WITH date_spine as (
  {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2010-01-01' as date)",
        end_date="date_add(current_date, interval 1 day)"
     )
  }}

), calculated as (

SELECT  
date(date_day) actual_date
,FORMAT_DATE('%A', date_day) actual_day_name
,EXTRACT(Month from date_day) month_actual
,EXTRACT(Quarter from date_day) quarter_actual
,EXTRACT(Year from date_day) year_actual
,EXTRACT(dayofweek from date_day) iso_day_of_week
,EXTRACT(WEEK(MONDAY) from date_day) week_number
,MOD(EXTRACT(DAYOFWEEK FROM date_day) + 5, 7) + 1 as day_of_week
,DATE_TRUNC(date(date_day),WEEK(MONDAY)) week_start
,LAST_DAY(date_day,WEEK(MONDAY)) week_end
,DATE_TRUNC(date(date_day),Month) month_start
,LAST_DAY(date_day,Month) month_end
,DATE_TRUNC(date(date_day),Quarter) quarter_start
,LAST_DAY(date_day,Quarter) quarter_end
from date_spine

)
-- , current_date_information AS (
  
--     SELECT 
--       fiscal_year AS current_fiscal_year,
--       first_day_of_fiscal_year AS current_first_day_of_fiscal_year,
--       fiscal_quarter_name_fy AS current_fiscal_quarter_name_fy,
--       first_day_of_month AS current_first_day_of_month
--     FROM calculated
--     WHERE CURRENT_DATE = date_actual

-- )
SELECT * from calculated
-- SELECT
--   calculated.date_day,
--   calculated.date_actual,
--   calculated.day_name,
--   calculated.month_actual,
--   calculated.year_actual,
--   calculated.quarter_actual,
--   calculated.day_of_week,
--   calculated.first_day_of_week,
--   calculated.week_of_year,
--   calculated.day_of_month,
--   calculated.day_of_quarter,
--   calculated.day_of_year,
--   calculated.fiscal_year,
--   calculated.fiscal_quarter,
--   calculated.day_of_fiscal_quarter,
--   calculated.day_of_fiscal_year,
--   calculated.month_name,
--   calculated.first_day_of_month,
--   calculated.last_day_of_month,
--   calculated.first_day_of_year,
--   calculated.last_day_of_year,
--   calculated.first_day_of_quarter,
--   calculated.last_day_of_quarter,
--   calculated.first_day_of_fiscal_quarter,
--   calculated.last_day_of_fiscal_quarter,
--   calculated.first_day_of_fiscal_year,
--   calculated.last_day_of_fiscal_year,
--   calculated.week_of_fiscal_year,
--   calculated.month_of_fiscal_year,
--   calculated.last_day_of_week,
--   calculated.quarter_name,
--   calculated.fiscal_quarter_name,
--   calculated.fiscal_quarter_name_fy,
--   calculated.fiscal_quarter_number_absolute,
--   calculated.fiscal_month_name,
--   calculated.fiscal_month_name_fy,
--   calculated.holiday_desc,
--   calculated.is_holiday,
--   calculated.last_month_of_fiscal_quarter,
--   calculated.is_first_day_of_last_month_of_fiscal_quarter,
--   calculated.last_month_of_fiscal_year,
--   calculated.is_first_day_of_last_month_of_fiscal_year,
--   calculated.snapshot_date_fpa,
--   calculated.snapshot_date_billings,
--   calculated.days_in_month_count,
--   calculated.week_of_month_normalised,
--   calculated.day_of_fiscal_quarter_normalised,
--   calculated.week_of_fiscal_quarter_normalised,
--   calculated.day_of_fiscal_year_normalised,
--   calculated.is_first_day_of_fiscal_quarter_week,
--   current_date_information.current_fiscal_year,
--   current_date_information.current_first_day_of_fiscal_year,
--   current_date_information.current_fiscal_quarter_name_fy,
--   current_date_information.current_first_day_of_month
-- FROM calculated
-- CROSS JOIN current_date_information

