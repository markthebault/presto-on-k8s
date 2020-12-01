#!/bin/bash

set -e

cat /opt/hive-metastore/conf/metastore-site.xml.tmpl | envsubst > /opt/hive-metastore/conf/metastore-site.xml
cat /opt/hadoop/etc/hadoop/core-site.xml.tmpl | envsubst > /opt/hadoop/etc/hadoop/core-site.xml

/opt/hive-metastore/bin/start-metastore -v -p 9093