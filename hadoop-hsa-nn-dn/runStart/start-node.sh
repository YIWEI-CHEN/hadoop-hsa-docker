#ssh pash4 /usr/local/hadoop/bin/hdfs datanode &
JOIN_IP=`ifconfig br0 | grep "inet addr" | sed 's/^.*inet addr://g' | cut -d ' ' -f1`
HOST=$1
SLAVEID=$2
DEVICETYPE=$3
echo $JOIN_IP

if [[ ${DEVICETYPE} == "HSA" ]]; then
    echo "ssh ${HOST} docker run --privileged --device /dev/kfd -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=HSA -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-hsa-dn:1.0"
    ssh ${HOST} "docker run --privileged --device /dev/kfd -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=HSA -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-hsa-dn:1.0"
# have not prepared gpu container yet
elif [[ ${DEVICETYPE} == "GPU" ]]; then
    echo "ssh ${HOST} docker run --privileged --device /dev/ati/card0 -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=GPU -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-gpu-dn:1.0"
    ssh ${HOST} "docker run --privileged --device /dev/ati/card0 -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=GPU -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-gpu-dn:1.0"
else
    echo "ssh ${HOST} docker run -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=CPU -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-hsa-dn:1.0"
    ssh ${HOST} "docker run -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=CPU -e JOIN_IP=${JOIN_IP} -P --name ${SLAVEID} -h ${SLAVEID}.mycorp.kom yiwei1012/hadoop-hsa-dn:1.0"
fi