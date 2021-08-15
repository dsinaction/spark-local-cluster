#!/bin/bash

if [ "$SPARK_DEPLOY_ROLE" == "master" ]
then
    spark-class org.apache.spark.deploy.master.Master >> $SPARK_HOME/logs/spark-master.out 2>&1
else
    spark-class org.apache.spark.deploy.worker.Worker spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} >> $SPARK_HOME/logs/spark-worker.out 2>&1
fi