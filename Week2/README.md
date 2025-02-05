# Workflow Orchestration

Welcome to Module 2 of the Data Engineering Zoomcamp! This week, we’ll dive into workflow orchestration using [Kestra](https://go.kestra.io/de-zoomcamp/github). 

Kestra is an open-source, event-driven orchestration platform that simplifies building both scheduled and event-driven workflows. By adopting Infrastructure as Code practices for data and process orchestration, Kestra enables you to build reliable workflows with just a few lines of YAML.

--The queries to the homework
--Q3
```sql
select
  count(*)
from `zoomcamp.yellow_tripdata`
where extract(year from tpep_pickup_datetime)=2020
limit 10;
```

--Q4
```sql
select
  count(*)
from `zoomcamp.green_tripdata`
where extract(year from lpep_pickup_datetime)=2020
limit 10;
```


--Q5
```sql
select
  count(*)
from `zoomcamp.yellow_tripdata`
where extract(year from tpep_pickup_datetime)=2021
and extract(month from tpep_pickup_datetime) = 3
limit 10;
```