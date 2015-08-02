CURRENT_DIR=`pwd`
BIN_DIR=`dirname "$0"`
BIN_DIR=`cd "$BIN_DIR"; pwd`
BASE_DIR=`cd "$BIN_DIR/../"; pwd`
sudo apt-get -y install build-essential libelf-dev
sudo cp ${BIN_DIR}/Okra-Interface-to-HSA-Device/okra/dist/bin/libokra_x86_64.so /opt/hsa/lib
sudo cp ${BIN_DIR}/Okra-Interface-to-HSA-Device/okra/dist/include/okra.h /opt/hsa/include
cd $CURRENT_DIR
