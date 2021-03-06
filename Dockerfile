FROM python:3.8.10-buster

ARG spark_version=3.1.2
ARG hadoop_version=3.2

RUN apt-get update -y && \
    apt-get install -y curl openjdk-11-jre-headless && \
    apt-get clean;

RUN curl https://dlcdn.apache.org/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -o spark.tgz && \
    tar -xxvf spark.tgz && \
    mv spark-${spark_version}-bin-hadoop${hadoop_version} /usr/local/spark && \
    mkdir /usr/local/spark/logs && \
    rm spark.tgz

ENV PYSPARK_PYTHON=python3

ENV SPARK_HOME=/usr/local/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

ENV SPARK_MASTER_HOST=spark-master
ENV SPARK_MASTER_PORT=7077

ADD start-spark.sh /

ENTRYPOINT [ "/start-spark.sh" ]
