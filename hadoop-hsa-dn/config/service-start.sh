#!/bin/bash

slave_name=`hostname | cut -d'.' -f1`
GPU=30
HSA=35
sed -i "14s/slave1/$slave_name/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
if [[ "$DEVICE_TYPE" == "HSA" ]]; then
    sed -i "${GPU}s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
    sed -i "${HSA}s/[0-9][0-9]*/1/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
elif [[ "$DEVICE_TYPE" == "GPU" ]]; then
    sed -i "${GPU}s/[0-9][0-9]*/1/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
    sed -i "${HSA}s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
else
    sed -i "${GPU}s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
    sed -i "${HSA}s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
fi

exec /usr/bin/svscan /etc/service/ 
#slave_list=( "slave1", "slave2", "slave3", "slave4", "slave5" )
#if [[ ${slave_list[*]} =~ ${slave_name} ]]; then
#    exec /usr/bin/svscan /etc/service/ 
#    #echo "${slave_name} is in the list"
#else
#    exec /usr/bin/svscan /etc/service/ &
#    sleep 5
#    su yiwei -c "$HADOOP_INSTALL/bin/yarn nodemanager" &
#    su yiwei -c "$HADOOP_INSTALL/bin/hdfs datanode" 
#    #echo ${slave_name} "is not in the list"
#fi
exec "$@"
