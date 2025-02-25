{{ config(materialized='view') }}
 
with tripdata as 
(
  select *
  from {{ source('staging_fhv','fhv_2019_table') }}
  where dispatching_base_num is not null
)
select
    *
from tripdata

-- dbt build --select <model.sql> --vars '{'is_test_run: false}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}