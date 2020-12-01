#!/bin/bash

set -e

aws s3 cp ./data/titanic.csv s3://mth-dlk-metastore/data/titanic.csv

CREATE SCHEMA samples;

CREATE TABLE samples.titanic (
  passengerid int, -- unique id
  survived int, -- target label
  pclass int,
  name varchar,
  sex varchar,
  age int,
  sibsp int, -- Number of Siblings/Spouses Aboard
  parch int, -- Number of Parents/Children Aboard
  ticket varchar,
  fare double,
  cabin varchar,
  embarked varchar
) 
WITH (
  csv_escape = '\',
  csv_quote = '"',  
  csv_separator = ',',
  external_location = 's3a://mth-dlk-metastore/data/titanic.csv/',
  format = 'CSV'
);



#### Azure
CREATE SCHEMA hive.tpcds WITH (location = 'abfss://raw@fsmthdlk.dfs.core.windows.net/warehouse/tpcds');