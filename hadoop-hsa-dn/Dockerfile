FROM yiwei1012/hadoop-hsa-base:1.2

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

#RUN chown -R yiwei:hadoop /home/yiwei/.ssh/config

# SSH and SERF ports 22 7373 7946 
# HDFS ports 9000 50010 50020 50070 50075 50090
# YARN ports 8030 8031 8032 8033 8040 8042 8088
#jobhisotry ports 10020 19888 10033
EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 8030 8031 8032 8033 8040 8042 8088 10020 19888 10033

ADD config/service-start.sh $HADOOP_INSTALL/bin/service-start.sh
RUN chmod 755 $HADOOP_INSTALL/bin/service-start.sh

RUN chown -R yiwei:hadoop /usr/local/hadoop-2.6.0 

RUN mkdir -p /home/yiwei/mr-log/KMeans/
#RUN mkdir -p /home/yiwei/mr-log/grep/
#RUN mkdir -p /home/yiwei/mr-log/WordCount/
#RUN mkdir -p /home/yiwei/mr-log/BFS/
#RUN mkdir -p /home/yiwei/mr-log/RayTrace/
RUN chown -R yiwei:hadoop /home/yiwei/mr-log
ENTRYPOINT ["/bin/bash", "/usr/local/hadoop/bin/service-start.sh"]
#ENTRYPOINT ["/usr/bin/svscan", "/etc/service/"]
