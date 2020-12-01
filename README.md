# presto-on-k8s development test
**FORK** from: [joshuarobinson/presto-on-k8s](https://github.com/joshuarobinson/presto-on-k8s)

Blog post create by Joshua that explains the conceptscan be found [here](https://medium.com/@joshua_robinson/presto-powered-s3-data-warehouse-on-kubernetes-aea89d2f40e8).

# How to Use

- Build Docker images for Hive Metastore and Presto `make build`
- Update the file `./kubernetes/02-metastore/s3-secret-yaml.secret` (you can use the example) to add your s3 credentials
- Change the bucket name in the property `metastore.warehouse.dir` in `./kubernetes/02-metastore/metastore-cm.yaml`
- Deploy the containers into kubernetes `make deploy`
- Run some tests `make test`


# Examples to run
According to the blog post those are the commends you can run to test your cluster:
```SQL
SHOW SCHEMAS FROM tpcds;
SHOW TABLES FROM tpcds.sf1;

#create a s3 bucket and set the name there:
CREATE SCHEMA hive.tpcds WITH (location = 's3a://MY_BUCKET_NAME/warehouse/tpcds/');

CREATE TABLE tpcds.store_sales AS SELECT * FROM tpcds.sf1.store_sales;

SELECT COUNT(*) FROM tpcds.store_sales;
```

# Credits
Thanks for **Joshua Robinson** to have provided such good information regarding hive configuration related to s3!