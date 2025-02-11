Welcome to Module 3 of the Data Engineering Zoomcamp!

## The queries to the homework
### Question1

    select
      count(*)
    from `wk3_hw.wk3_hw_table`


## Question2
### external

    select
      count(distinct PULocationID)
    from `wk3_hw.wk3_hw_table`


### reg

    select
      count(distinct PULocationID)
    from `wk3_hw.wk3_hw_mat`


## Question3

    select distinct PULocationID
    from `wk3_hw.wk3_hw_mat`

    select distinct PULocationID, DOLocationID
    from `wk3_hw.wk3_hw_mat`


## Question4

    select 
      count(*)
    from `wk3_hw.wk3_hw_mat`
    where fare_amount = 0


## Question5: 
### Partition by tpep_dropoff_datetime and Cluster on VendorID

    CREATE OR REPLACE TABLE `wk3_hw.wk3_hw_yellow_taxi_partitioned_clustered`
    PARTITION BY DATE(tpep_dropoff_datetime)
    CLUSTER BY VendorID AS (
      SELECT * FROM `wk3_hw.wk3_hw_mat`
    );


## Question 6:

    select distinct VendorID
    from `wk3_hw.wk3_hw_mat`
    where tpep_dropoff_datetime between'2024-03-01' and '2024-03-15'


    select distinct VendorID
    from `wk3_hw.wk3_hw_yellow_taxi_partitioned_clustered`
    where tpep_dropoff_datetime between'2024-03-01' and '2024-03-15'