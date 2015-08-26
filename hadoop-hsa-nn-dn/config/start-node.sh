#ssh pash4 /usr/local/hadoop/bin/hdfs datanode &
JOIN_IP=10.2.10.1
#JOIN_IP=`ifconfig br0 | grep "inet addr" | sed 's/^.*inet addr://g' | cut -d ' ' -f1`
#JOIN_IP=`ifconfig eth0 | grep "inet addr" | sed 's/^.*inet addr://g' | cut -d ' ' -f1`
#echo $JOIN_IP
#fileName="container_list.txt"
fileName=$1
while read LINE
do
    HOST=`echo $LINE | cut -d' ' -f1`
    SLAVEID=`echo $LINE | cut -d' ' -f2 | cut -d'.' -f1`
    DEVICE_TYPE=`echo $LINE | cut -d' ' -f3`
    if [[ "$DEVICE_TYPE" == "HSA" ]]; then
        ssh yiwei@${SLAVEID}.mycorp.kom "sed -i '30s/[0-9][0-9]*/0/' /usr/local/hadoop/etc/hadoop/yarn-site.xml" &
        ssh yiwei@${SLAVEID}.mycorp.kom "sed -i '35s/[0-9][0-9]*/1/' /usr/local/hadoop/etc/hadoop/yarn-site.xml" &
    elif [[ '$DEVICE_TYPE' == "GPU" ]]; then
        ssh yiwei@${SLAVEID}.mycorp.kom "sed -i '30s/[0-9][0-9]*/1/' /usr/local/hadoop/etc/hadoop/yarn-site.xml" &
        ssh yiwei@${SLAVEID}.mycorp.kom "sed -i '35s/[0-9][0-9]*/0/' /usr/local/hadoop/etc/hadoop/yarn-site.xml" &
    else
        ssh yiwei@${SLAVEID}.mycorp.kom "sed -i '30s/[0-9][0-9]*/0/' /usr/local/hadoop/etc/hadoop/yarn-site.xml" &
        ssh yiwei@${SLAVEID}.mycorp.kom "sed -i '35s/[0-9][0-9]*/0/' /usr/local/hadoop/etc/hadoop/yarn-site.xml" &
    fi
    ssh yiwei@${SLAVEID}.mycorp.kom "$HADOOP_INSTALL/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script $HADOOP_INSTALL/bin/hdfs start datanode" &
    ssh yiwei@${SLAVEID}.mycorp.kom "$HADOOP_INSTALL/sbin/yarn-daemon.sh --config $YARN_CONF_DIR start nodemanager" &
#    echo $HOST $SLAVEID $DEVICETYPE
#    if [[ ${DEVICETYPE} == "HSA" ]]; then
#        echo "ssh ${HOST} docker run --privileged --device /dev/kfd -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=HSA -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-hsa-dn:1.0"
#        ssh ${HOST} "docker run --privileged --device /dev/kfd -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=HSA -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-hsa-dn:1.0"
#    # have not prepared gpu container yet
#    elif [[ ${DEVICETYPE} == "GPU" ]]; then
#        echo "ssh ${HOST} docker run -e DISPLAY=unix:0.0 -v=/tmp/.X11-unix:/tmp/.X11-unix:rw --privileged -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=GPU -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-gpu-dn:1.0"
#        ssh ${HOST} "docker run -e DISPLAY=unix:0.0 -v=/tmp/.X11-unix:/tmp/.X11-unix:rw --privileged -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=GPU -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-gpu-dn:1.0"
#    else
#        echo "ssh ${HOST} docker run -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=CPU -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-hsa-dn:1.0"
#        ssh ${HOST} "docker run -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=CPU -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-hsa-dn:1.0"
#    fi
done < $fileName
