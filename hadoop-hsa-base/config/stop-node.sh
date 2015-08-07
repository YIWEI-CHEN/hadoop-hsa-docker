#!/bin/bash
fileName=$1
while read LINE
do
    HOST=`echo $LINE | cut -d' ' -f1`
    SLAVEID=`echo $LINE | cut -d' ' -f2`
    DEVICETYPE=`echo $LINE | cut -d' ' -f3`
    echo "ssh ${HOST} docker stop -t 1 ${SLAVEID} && docker rm ${SLAVEID}" $DEVICETYPE
    # ssh ${HOST} "docker stop -t 1 ${SLAVEID} && docker rm ${SLAVEID}"
done < $fileName
