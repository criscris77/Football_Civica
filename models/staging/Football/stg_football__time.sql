with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="'1800-01-01'",
        end_date="'2050-12-31'"
    ) }}
)

select
    CONVERT_TIMEZONE('UTC',TO_TIMESTAMP_TZ(date_day) )as date_timezone,
    TO_CHAR(date_timezone, 'DD/MM/YYYY') as date,
    {{ dbt_utils.generate_surrogate_key(['date']) }} as date_id,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,
from date_spine
