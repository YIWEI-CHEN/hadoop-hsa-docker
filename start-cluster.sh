#!/bin/bash
dnImage="yiwei1012/hadoop-hsa-dn:1.2"
nnImage="yiwei1012/hadoop-hsa-nn-dn:1.2"
domain="mycorp.kom"
HSAOPTS="--privileged --device /dev/kfd -e DEVICE_TYPE=HSA"
GPUOPTS="--privileged -e DISPLAY=unix:0.0 -v=/tmp/.X11-unix:/tmp/.X11-unix:rw -e DEVICE_TYPE=GPU"
CPUOPTS="-e DEVICE_TYPE=CPU"

SLAVEOPTS="-d -t --dns 127.0.0.1 -e NODE_TYPE=s"
index=1

# first slave
docker run ${SLAVEOPTS} ${HSAOPTS} --name slave${index} -h slave${index}.${domain} ${dnImage}
FIRST_IP=$( docker inspect --format="{{.NetworkSettings.IPAddress}}" slave1 )
# update SLAVEOPTS
SLAVEOPTS="$SLAVEOPTS -e JOIN_IP=$FIRST_IP"
MASTEROPTS="-i -t --dns 127.0.0.1 -e NODE_TYPE=m -e JOIN_IP=$FIRST_IP -v /home/yiwei/hadoop_input:/mnt"

#for (( i = 1; i < 3; i++ )); do
#    if [[ $i == 4 ]] || [[ $i == 5 ]]; then
#        continue;   
#    fi
#    index=$(( $index+1 ));
#    ssh pasH${i} "docker run ${SLAVEOPTS} ${HSAOPTS} --name slave${index} -h slave${index}.${domain} ${dnImage}" &
#    index=$(( $index+1 ));
#    ssh pasH${i} "docker run ${SLAVEOPTS} ${CPUOPTS} --name slave${index} -h slave${index}.${domain} ${dnImage}" &
#done
#
ssh pasH1 "docker run ${SLAVEOPTS} ${HSAOPTS} --name slave2 -h slave2.${domain} ${dnImage}" 
ssh pasH1 "docker run ${SLAVEOPTS} ${CPUOPTS} --name slave3 -h slave3.${domain} ${dnImage}" 
ssh pasH2 "docker run ${SLAVEOPTS} ${HSAOPTS} --name slave4 -h slave4.${domain} ${dnImage}" 
ssh pasH2 "docker run ${SLAVEOPTS} ${HSAOPTS} --name slave6 -h slave6.${domain} ${dnImage}" 
ssh pasH3 "docker run ${SLAVEOPTS} ${HSAOPTS} --name slave7 -h slave7.${domain} ${dnImage}" 
ssh pasH6 "docker run ${SLAVEOPTS} ${HSAOPTS} --name slave8 -h slave8.${domain} ${dnImage}" 
ssh pasH7 "docker run ${SLAVEOPTS} ${HSAOPTS} --name slave9 -h slave9.${domain} ${dnImage}" 
ssh pasH6 "docker run ${SLAVEOPTS} ${HSAOPTS} --name slave10 -h slave10.${domain} ${dnImage}" 
ssh pasH7 "docker run ${SLAVEOPTS} ${HSAOPTS} --name slave11 -h slave11.${domain} ${dnImage}" 
dnImage="yiwei1012/hadoop-gpu-dn:1.2"
ssh pasH8 "docker run ${SLAVEOPTS} ${GPUOPTS} --name slave5 -h slave5.${domain} ${dnImage}" 
docker run ${MASTEROPTS} ${CPUOPTS} --name master -h master.${domain} ${nnImage}
