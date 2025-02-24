-- {{ config(materialized='table') }}

with trips_data as (
    select 
        * 
    from {{ ref('fact_trips') }}
    where fare_amount >0
    and trip_distance> 0
    and payment_type_description in ('Cash', 'Credit Card')
)
, month_year_fct_trips as(
    select 
        extract(month from pickup_datetime) as month_pickup,
        extract(year from pickup_datetime) as year_pickup,
        *
    from trips_data
)
select
    percentile_cont(
        fare_amount, 
        0.97)
        over (partition by service_type, month_pickup, year_pickup),
        percentile_cont(
        fare_amount, 
        0.95)
        over (partition by service_type, month_pickup, year_pickup) ,
        percentile_cont(
        fare_amount, 
        0.90)
        over (partition by service_type, month_pickup, year_pickup) 
from month_year_fct_trips
where service_type = 'Green'
and month_pickup = 4
and year_pickup = 2020
    