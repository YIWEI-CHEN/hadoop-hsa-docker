FROM yiwei1012/hsa-java-serf:1.0
MAINTAINER YIWEI CHEN <feberium@gmail.com>

# Update Ubuntu
#RUN apt-get update && apt-get upgrade -y
#
#RUN apt-get install -y maven llvm-gcc build-essential zlib1g-dev make cmake pkg-config libssl-dev automake autoconf 
#
## Add oracle java 8 repository
#RUN apt-get -y install software-properties-common
#RUN add-apt-repository ppa:webupd8team/java
#RUN apt-get -y update
#
## Accept the Oracle Java license
#RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
#
## Install Oracle Java
#RUN apt-get -y install oracle-java8-installer
#
#RUN update-alternatives --display java
#
#ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/ 
#ENV PATH $PATH:$JAVA_HOME/bin

RUN addgroup hadoop
RUN useradd -d /home/yiwei -m -s /bin/bash -G hadoop yiwei 

RUN apt-get install -y openssh-server vim
RUN mkdir /var/run/sshd
RUN su yiwei -c "ssh-keygen -t rsa -f ~/.ssh/id_rsa -P ''"
RUN su yiwei -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" 
# config
ADD config/ssh_config ./ssh_config
RUN mv ./ssh_config /home/yiwei/.ssh/config
# id_rsa
ADD config/id_rsa ./id_rsa
RUN mv ./id_rsa /home/yiwei/.ssh/id_rsa
# id_rsa.pub
ADD config/id_rsa.pub ./id_rsa.pub
RUN mv ./id_rsa.pub /home/yiwei/.ssh/id_rsa.pub
# authorized_keys
ADD config/authorized_keys ./authorized_keys
RUN mv ./authorized_keys /home/yiwei/.ssh/authorized_keys
# change ownership
RUN chown -R yiwei:hadoop /home/yiwei/.ssh/

#RUN wget http://apache.mirror.anlx.net/hadoop/core/hadoop-2.3.0/hadoop-2.3.0-src.tar.gz 
#RUN wget http://ftp.mirror.tw/pub/apache/hadoop/common/hadoop-2.6.0/hadoop-2.6.0-src.tar.gz
#RUN tar -xvf hadoop-2.6.0-src.tar.gz  


#RUN wget https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz  
#RUN tar -xvf protobuf-2.5.0.tar.gz  
#RUN cd protobuf-2.5.0 && ./configure  
#RUN cd protobuf-2.5.0 && make  
#RUN cd protobuf-2.5.0 && make check  
#RUN cd protobuf-2.5.0 && make install  
#RUN cd protobuf-2.5.0 && ldconfig  
#RUN protoc --version  
#ENV MAVEN_OPTS -Xms512m -XX:MaxPermSize=256 -Xmx512m
#RUN cd hadoop-2.6.0-src && mvn package -Pdist,native -DskipTests -Dtar  

#RUN  cd hadoop-2.6.0-src && tar -xvf hadoop-dist/target/hadoop-2.6.0.tar.gz -C /usr/local/  
# add modified hadoop
ADD hadoop-2.6.0.tar.gz /usr/local/
#RUN cd usr/local/src
#RUN tar -xvf hadoop-2.6.0.tar.gz -C /usr/local/  
RUN ln -s /usr/local/hadoop-2.6.0 /usr/local/hadoop  
ADD config/bashrc /home/yiwei/.bashrc
# add dependency jar and native lib
#ADD csie-aparapi/csie-aparapi.jar /usr/local/hadoop/share/hadoop/common/lib
#ADD csie-aparapi/libaparapi_x86_64.so /usr/local/hadoop/lib/native
# aparapi-lambda
#ADD aparapi-lambda/aparapi.jar /usr/local/hadoop/share/hadoop/common/lib
#ADD aparapi-lambda/okra/dist/okra.jar /usr/local/hadoop/share/hadoop/common/lib
#ADD aparapi-lambda/libaparapi_agent_x86_64.so /usr/local/hadoop/lib/native
#ADD aparapi-lambda/libaparapi_opencl_x86_64.so /usr/local/hadoop/lib/native
## okra 
#ADD aparapi-lambda/okra/dist/bin/libokra_x86_64.so /usr/local/hadoop/lib/native
#ADD aparapi-lambda/okra/dist/bin/libokra_x86_64.so /opt/hsa/lib
#ADD aparapi-lambda/okra/dist/include/okra.h /opt/hsa/include
# hsa runtime
RUN cp /opt/hsa/lib/libhsa-runtime-ext64.so /usr/local/hadoop/lib/native
RUN cp /opt/hsa/lib/libhsa-runtime-ext64.so.1 /usr/local/hadoop/lib/native
RUN cp /opt/hsa/lib/libhsa-runtime64.so /usr/local/hadoop/lib/native
RUN cp /opt/hsa/lib/libhsa-runtime64.so.1 /usr/local/hadoop/lib/native
RUN cp /opt/hsa/lib/libhsakmt.so.1 /usr/local/hadoop/lib/native
# jar
ADD hadoop-required.tar.gz /usr/local/
RUN mv /usr/local/hadoop-required/csie-aparapi/csie-aparapi.jar /usr/local/hadoop/share/hadoop/common/lib
RUN mv /usr/local/hadoop-required/aparapi-lambda/aparapi.jar /usr/local/hadoop/share/hadoop/common/lib
RUN mv /usr/local/hadoop-required/aparapi-lambda/okra/dist/okra.jar /usr/local/hadoop/share/hadoop/common/lib
RUN mv /usr/local/hadoop-required/csie-aparapi/libaparapi_x86_64.so /usr/local/hadoop/lib/native
# native library
RUN mv /usr/local/hadoop-required/aparapi-lambda/libaparapi_agent_x86_64.so /usr/local/hadoop/lib/native
RUN mv /usr/local/hadoop-required/aparapi-lambda/libaparapi_opencl_x86_64.so /usr/local/hadoop/lib/native
RUN cp /usr/local/hadoop-required/aparapi-lambda/okra/dist/bin/libokra_x86_64.so /usr/local/hadoop/lib/native
RUN mv /usr/local/hadoop-required/aparapi-lambda/okra/dist/bin/libokra_x86_64.so /opt/hsa/lib

RUN chown -R yiwei:hadoop /usr/local/hadoop-2.6.0
RUN rm -f /usr/local/hadoop/etc/hadoop/hadoop-env.sh 
ADD config/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh 

EXPOSE 22
