{{ config(materialized='table') }}

with dim_fhv_tripsdata as(
    select
        *,
        timestamp_diff(dropOff_datetime, pickup_datetime, Second) as trip_duration
    from {{ ref('dim_fhv_trips') }}
)
select
    year_pickup, 
    month_pickup,
    pickup_locationid,
    dropoff_locationid,
    PERCENTILE_CONT(trip_duration, 0.90) OVER 
    (PARTITION BY year_pickup, month_pickup, pickup_locationid, dropoff_locationid 
    ORDER BY trip_duration) as p90
from dim_fhv_tripsdata