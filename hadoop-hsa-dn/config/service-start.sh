#!/bin/bash

slave_name=`hostname | cut -d'.' -f1`
GPU=30
HSA=35
sed -i "14s/slave1/$slave_name/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
#sed -i "2a 10.2.0.254   pasX" /etc/hosts
#sed -i "2a 10.2.0.10   pasH0" /etc/hosts
#sed -i "2a 10.2.0.11   pasH1" /etc/hosts
#sed -i "2a 10.2.0.12   pasH2" /etc/hosts
#sed -i "2a 10.2.0.13   pasH3" /etc/hosts
#sed -i "2a 10.2.0.14   pasH4" /etc/hosts
#sed -i "2a 10.2.0.15   pasH5" /etc/hosts
#sed -i "2a 10.2.0.16   pasH6" /etc/hosts
#sed -i "2a 10.2.0.17   pasH7" /etc/hosts
#sed -i "2a 10.2.0.18   pasH8" /etc/hosts
if [[ "$DEVICE_TYPE" == "HSA" ]]; then
    sed -i "${GPU}s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
    sed -i "${HSA}s/[0-9][0-9]*/1/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
else
    sed -i "${GPU}s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
    sed -i "${HSA}s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
fi
#if [[ "$DEVICE_TYPE" == "GPU" ]]; then
#    sed -i "30s/[0-9][0-9]*/1/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
#else
#    sed -i "30s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
#fi
if [[ ${slave_name} != "slave1" ]]; then
   exec /usr/bin/svscan /etc/service/ &
   sleep 5
   su yiwei -c "$HADOOP_INSTALL/bin/yarn nodemanager" &
   su yiwei -c "$HADOOP_INSTALL/bin/hdfs datanode" 
else
   exec /usr/bin/svscan /etc/service/ 
fi
exec "$@"
