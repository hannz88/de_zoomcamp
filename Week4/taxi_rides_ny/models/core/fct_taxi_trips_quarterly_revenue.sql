{{ config(materialized='view') }}

with trips_data as (
    select * 
    from {{ ref('dm_monthly_zone_revenue') }}
),
month_and_year_trips as(
    select 
        *,
        extract(month from revenue_month) as month_pickup,
        extract(year from revenue_month) as year_pickup,
    from trips_data
),
quarter_trips as(
    select
        *,
        -- cast(year_pickup as string) as year_pickup_str,
        case 
            when month_pickup in (1,2,3) then '1'
            when month_pickup in (4,5,6) then '2'
            when month_pickup in (7,8,9) then '3'
            when month_pickup in (10,11,12) then '4'
        end as quarter_pickup
    from month_and_year_trips
    where year_pickup in (2019, 2020)
),
concat_quarter as(
    select
        *,
        concat(cast(year_pickup as string), '/Q', quarter_pickup) 
            as year_quarter
    from quarter_trips
)
, grouped_quarter_revenue as(
select 
    service_type,
    year_quarter,
    sum(revenue_monthly_total_amount) as quarterly_revenue
from concat_quarter
group by 1,2
order by 1,2
)
, diff_gbp as(
select
    *,
    (quarterly_revenue - 
    lag(quarterly_revenue,1) over(partition by service_type order by year_quarter)
    ) as revenue_diff_gbp
from grouped_quarter_revenue
)
select
    *,
    round((
    revenue_diff_gbp/(
       lag(quarterly_revenue,1) over(partition by service_type order by year_quarter) 
    )
    )*100,2) as pct_diff
from diff_gbp