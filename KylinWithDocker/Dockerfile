FROM sequenceiq/ambari:1.7.0
MAINTAINER SequenceIQ

RUN curl -sL https://dist.apache.org/repos/dist/release/kylin/apache-kylin-1.5.2.1/apache-kylin-1.5.2.1-bin.tar.gz | tar -xz -C /usr/local
RUN cd /usr/local && ln -s ./apache-kylin-1.5.2.1-bin kylin
ENV KYLIN_HOME=/usr/local/kylin

RUN yum install -y pig hbase tez hadoop snappy snappy-devel hadoop-libhdfs ambari-log4j hive hive-hcatalog hive-webhcat webhcat-tar-hive webhcat-tar-pig mysql-connector-java mysql-server

ADD serf /usr/local/serf

ADD install-cluster.sh /tmp/
ADD kylin-singlenode.json /tmp/
ADD kylin-multinode.json /tmp/
ADD wait-for-kylin.sh /tmp/
ADD deploy.sh /usr/local/kylin/deploy.sh

EXPOSE 7070 16010 50070	19888 8080
