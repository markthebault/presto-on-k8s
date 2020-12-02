CREATE SCHEMA hive.samples WITH (location = 'abfss://raw@fsmthdlk.dfs.core.windows.net/warehouse/samples/');

CREATE TABLE hive.samples.tlc_yellow_trips_2018 ( 
  vendorid VARCHAR,
  tpep_pickup_datetime VARCHAR,
  tpep_dropoff_datetime VARCHAR,
  passenger_count VARCHAR, 
  trip_distance VARCHAR,
  ratecodeid VARCHAR, 
  store_and_fwd_flag VARCHAR,
  pulocationid VARCHAR, 
  dolocationid VARCHAR, 
  payment_type VARCHAR, 
  fare_amount VARCHAR,
  extra VARCHAR,
  mta_tax VARCHAR,
  tip_amount VARCHAR, 
  tolls_amount VARCHAR, 
  improvement_surcharge VARCHAR, 
  total_amount VARCHAR
)
WITH (
  FORMAT = 'CSV', 
  skip_header_line_count = 1, 
  EXTERNAL_LOCATION = 'abfss://raw@fsmthdlk.dfs.core.windows.net/nyc_yello_taxi'
) ;

SELECT * FROM hive.samples.tlc_yellow_trips_2018 LIMIT 10;

-- Convert dataset to parquet
CREATE SCHEMA hive.samples_parq WITH (location = 'abfss://raw@fsmthdlk.dfs.core.windows.net/warehouse/samples_parq/');

CREATE TABLE hive.samples_parq.tlc_yellow_trips_2018 COMMENT '2018 Newyork City taxi data'
WITH (FORMAT = 'PARQUET')
AS
SELECT
  cast(vendorid as INTEGER) as vendorid, 
  date_parse(tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s') as tpep_pickup_datetime,
  date_parse(tpep_dropoff_datetime, '%Y-%m-%d %H:%i:%s') as tpep_dropoff_datetime,
  cast(passenger_count as SMALLINT) as passenger_count, 
  cast(trip_distance as DECIMAL(8, 2)) as trip_distance, 
  cast(ratecodeid as INTEGER) as ratecodeid, 
  cast(store_and_fwd_flag as CHAR(1)) as store_and_fwd_flag, 
  cast(pulocationid as INTEGER) as pulocationid, 
  cast(dolocationid as INTEGER) as dolocationid, 
  cast(payment_type as SMALLINT) as payment_type, 
  cast(fare_amount as DECIMAL(8, 2)) as fare_amount, 
  cast(extra as DECIMAL(8, 2)) as extra,
  cast(mta_tax as DECIMAL(8, 2)) as mta_tax, 
  cast(tip_amount as DECIMAL(8, 2)) as tip_amount, 
  cast(tolls_amount as DECIMAL(8, 2)) as tolls_amount, 
  cast(improvement_surcharge as DECIMAL(8, 2)) as improvement_surcharge,
  cast(total_amount as DECIMAL(8, 2)) as total_amount
FROM hive.samples.tlc_yellow_trips_2018 ;

-- Run some sample query
SELECT * FROM hive.samples_parq.tlc_yellow_trips_2018 LIMIT 10;


-- Select the amount of cash generated per day and save it to a table
CREATE TABLE hive.samples_parq.money_per_day COMMENT 'Total money spent per day on taxi rides in 2018'
WITH (FORMAT = 'PARQUET')
AS SELECT day_of_year(tpep_pickup_datetime) as d_day, SUM(total_amount) as money_spend
  FROM hive.samples_parq.tlc_yellow_trips_2018 
  GROUP BY day_of_year(tpep_pickup_datetime);

-- Select the amount of cash generated per day of week and save it to a table
CREATE TABLE hive.samples_parq.money_per_day_of_week COMMENT 'Total money spent per day on taxi rides in 2018'
WITH (FORMAT = 'PARQUET')
AS SELECT day_of_week(tpep_pickup_datetime) as d_day, SUM(total_amount) as money_spend
  FROM hive.samples_parq.tlc_yellow_trips_2018 
  GROUP BY day_of_week(tpep_pickup_datetime);

-- Select the amount of cash generated per day of month and save it to a table
CREATE TABLE hive.samples_parq.money_per_day_of_month COMMENT 'Total money spent per day on taxi rides in 2018'
WITH (FORMAT = 'PARQUET')
AS SELECT day_of_month(tpep_pickup_datetime) as d_day, SUM(total_amount) as money_spend
  FROM hive.samples_parq.tlc_yellow_trips_2018 
  GROUP BY day_of_month(tpep_pickup_datetime);