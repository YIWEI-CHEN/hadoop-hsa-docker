#!/bin/bash

if [[ "$DEVICE_TYPE" == "HSA" ]]; then
    sed -i "35s/[0-9][0-9]*/1/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
else
    sed -i "35s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
fi
if [[ "$DEVICE_TYPE" == "GPU" ]]; then
    sed -i "30s/[0-9][0-9]*/1/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
else
    sed -i "30s/[0-9][0-9]*/0/" /usr/local/hadoop/etc/hadoop/yarn-site.xml
fi

/usr/bin/svscan /etc/service/ &
sleep 4
if [ "$NODE_TYPE" = "m" ]; then
   su yiwei -c "$HADOOP_INSTALL/sbin/start-dfs.sh"
   su yiwei -c "$HADOOP_INSTALL/sbin/start-yarn.sh"
fi
#tail -f $HADOOP_INSTALL/logs/*
