#!/bin/bash
GPU=30
HSA=35
sed -i "2s/###/$JOIN_IP/g" /usr/local/hadoop/sbin/start-node.sh
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

/usr/bin/svscan /etc/service/ &
sleep 4
if [ "$NODE_TYPE" = "m" ]; then
   su yiwei -c "$HADOOP_INSTALL/sbin/start-dfs.sh"
   su yiwei -c "$HADOOP_INSTALL/sbin/start-yarn.sh"
fi
#tail -f $HADOOP_INSTALL/logs/*
