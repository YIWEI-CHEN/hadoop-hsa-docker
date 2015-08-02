#!/bin/bash

#ssh yiwei@pasH1 docker run -d -t --dns 127.0.0.1 -e NODE_TYPE=s -P --name slave1 -h slave1.mycorp.kom yiwei1012/ubuntu-hadoop-dn:1.4
#docker run --privileged --device /dev/kfd -v /home/yiwei/hsa-install-files:/mnt --name hsa-java -h slave1 -i -t yiwei1012/hsa-java:1.0 /bin/bash
#FIRST_IP=$( ssh yiwei@pasH1 docker inspect --format="{{.NetworkSettings.IPAddress}}" slave1 )
docker run --privileged --device /dev/kfd -d -t --dns 127.0.0.1 -e NODE_TYPE=s -e DEVICE_TYPE=HSA -P --name slave1 -h slave1.mycorp.kom yiwei1012/hadoop-hsa-dn:1.0
FIRST_IP=$( docker inspect --format="{{.NetworkSettings.IPAddress}}" slave1 )
docker run -i -t --dns 127.0.0.1 -e NODE_TYPE=m -e JOIN_IP=$FIRST_IP -v /home/$( whoami )/hadoop_input:/mnt -P --name master -h master.mycorp.kom yiwei1012/hadoop-hsa-nn-dn:1.0
