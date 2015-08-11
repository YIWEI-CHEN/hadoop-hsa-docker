FROM yiwei1012/hadoop-hsa-base:1.2

MAINTAINER YIWEI CHEN <feberium@gmail.com>

RUN apt-get install -y iputils-ping daemontools runit

ENV HADOOP_INSTALL /usr/local/hadoop

RUN mkdir -p /home/yiwei/hdfs/namenode  
RUN mkdir -p /home/yiwei/hdfs/datanode 
 
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
ADD config/slaves $HADOOP_INSTALL/etc/hadoop/slaves 
# add start-node, stop-node
ADD config/start-node.sh $HADOOP_INSTALL/sbin/start-node.sh 
ADD config/stop-node.sh $HADOOP_INSTALL/sbin/stop-node.sh 

RUN chown -R yiwei:hadoop /home/yiwei/hdfs
#RUN chown -R yiwei:hadoop /home/yiwei/hdfs
RUN chown -R yiwei:hadoop /usr/local/hadoop-2.6.0
RUN chmod 1777 /tmp
#RUN chown -R yiwei:hadoop /home/yiwei/.ssh/config

# Format namenode
RUN su yiwei -c "/usr/local/hadoop/bin/hdfs namenode -format"

ADD config/start-hadoop.sh $HADOOP_INSTALL/bin/start-hadoop.sh
RUN chmod 755 $HADOOP_INSTALL/bin/start-hadoop.sh

# SSH and SERF ports 22 7373 7946 
# HDFS ports 9000 50010 50020 50070 50075 50090
# YARN ports 8030 8031 8032 8033 8040 8042 8088
#jobhisotry ports 10020 19888 10033
EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 8030 8031 8032 8033 8040 8042 8088 10020 19888 10033

RUN mkdir -p /home/yiwei/mr-log/KMeans
ADD config/mr-profile.log $HADOOP_INSTALL/logs/mr-profile.log
RUN chown -R yiwei:hadoop /home/yiwei/mr-log

#ENTRYPOINT ["/bin/bash", "/usr/local/hadoop/bin/start-hadoop.sh"]
CMD ["/bin/bash"]
