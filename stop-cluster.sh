
#hadoop_cluster_names=( `docker ps|grep -i hadoop|sed "s/ \{3,\}/#/g"|cut -d '#' -f 7|sed "s/#/\t/g"` )
for (( i = 0; i < 8; i++ )); do
    if [[ $i == 4 ]] || [[ $i == 5 ]]; then
        continue;
    fi
    cluster_name=( `ssh pasH${i} docker ps -a |grep -i hadoop|sed "s/ \{3,\}/#/g"|cut -d '#' -f 7|sed "s/#/\t/g"` )
    for name in ${cluster_name[@]}; do
        #echo $name
        ssh pasH${i} "docker stop -t 1 ${name}"
        ssh pasH${i} "docker rm ${name}"
    done
done
#for name in ${hadoop_cluster_names[@]}; do
#    docker stop -t 1 ${name} && docker rm ${name}
#done
