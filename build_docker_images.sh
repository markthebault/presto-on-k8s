#!/bin/bash

set -e

REPONAME=markthebault
PRESTOVER=337

# Build hive metastore server
docker build -t $REPONAME/hivemetastore ./docker/hive_metastore
docker push $REPONAME/hivemetastore


## Build Presto-server
docker build --build-arg PRESTO_VER=$PRESTOVER -t $REPONAME/fb-presto ./docker/presto/
docker push $REPONAME/fb-presto


## Build Presto-CLI
docker build --build-arg PRESTO_VER=$PRESTOVER -t $REPONAME/presto-cli ./docker/presto-cli/
docker push $REPONAME/presto-cli
