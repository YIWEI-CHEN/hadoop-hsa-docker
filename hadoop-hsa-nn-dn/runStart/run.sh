#!/bin/sh
CURRENT_DIR=.
#for f in $files ; do
##    java -cp ${CURRENT_DIR}/classes AppProfiler "${CURRENT_DIR}/${INPUT}/$f" "${CURRENT_DIR}/${INPUT}/result/proc_$f"
#    java -cp ${CURRENT_DIR}/classes AppProfiler "${INPUT}/$f" "$result_dir/proc_$f"
#done
host="10.2.0.11"
slaveId="slave3"
deviceType="HSA"
java -cp ${CURRENT_DIR}/classes runstart ${host} ${slaveId} ${deviceType}
slaveId="slave2"
deviceType="GPU"
java -cp ${CURRENT_DIR}/classes runstart ${host} ${slaveId} ${deviceType}
slaveId="slave4"
deviceType="CPU"
java -cp ${CURRENT_DIR}/classes runstart ${host} ${slaveId} ${deviceType}
