FROM yiwei1012/hadoop-hsa-base:1.0

MAINTAINER YIWEI CHEN <feberium@gmail.com>

RUN apt-get install -y iputils-ping daemontools

ENV HADOOP_INSTALL /usr/local/hadoop

RUN mkdir $HADOOP_INSTALL/logs

RUN mkdir -p /etc/service/serf
RUN mkdir -p /etc/service/sshd

ADD config/service /etc/service

RUN chmod +x /etc/service/serf/run 
RUN chmod +x /etc/service/sshd/run 

ADD config/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml 
ADD config/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml 
ADD config/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml 
ADD config/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml 

RUN chown -R yiwei:hadoop /usr/local/hadoop-2.6.0 
RUN chown -R yiwei:hadoop /home/yiwei/.ssh/config

# SSH and SERF ports
EXPOSE 22 7373 7946 

# HDFS ports
EXPOSE 9000 50010 50020 50070 50075 50090

# YARN ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088 

#jobhisotry ports
EXPOSE 10020 19888 10033

ADD config/service-start.sh $HADOOP_INSTALL/bin/service-start.sh
RUN chmod 755 $HADOOP_INSTALL/bin/service-start.sh

ENTRYPOINT ["/bin/bash", "/usr/local/hadoop/bin/service-start.sh"]
#ENTRYPOINT ["/usr/bin/svscan", "/etc/service/"]
