{{
    config(
        materialized='table'
    )
}}

with fhv_trips_data as(
    select
        *
    from {{ ref('stg_fhv_tripdata') }}
),
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select
    fhv_trips_data.* except (pulocationid, dolocationid),
    pulocationid as pickup_locationid,
    dolocationid as dropoff_locationid,
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,
    extract(month from pickup_datetime) as month_pickup,
    extract(year from pickup_datetime) as year_pickup,
from fhv_trips_data
inner join dim_zones as pickup_zone
on fhv_trips_data.pulocationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_trips_data.dolocationid = dropoff_zone.locationid