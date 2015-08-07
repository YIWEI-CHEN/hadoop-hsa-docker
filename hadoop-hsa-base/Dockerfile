FROM yiwei1012/hsa-java-serf:1.0
MAINTAINER YIWEI CHEN <feberium@gmail.com>

# Update Ubuntu
RUN apt-get install -y ctags cscope
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

ADD hadoop-2.6.0.tar.gz /usr/local/
RUN ln -s /usr/local/hadoop-2.6.0 /usr/local/hadoop  

ADD config/bashrc /home/yiwei/.bashrc
RUN chown yiwei:hadoop /home/yiwei/.bashrc

# add vim plugin
ADD config/vimrc /home/yiwei/.vimrc
RUN chown yiwei:hadoop /home/yiwei/.vimrc
ADD config/vimrc.color /home/yiwei/.vimrc.color
RUN chown yiwei:hadoop /home/yiwei/.vimrc.color
ADD vim.tar.gz /home/yiwei/
RUN chown -R yiwei:hadoop /home/yiwei/.vim

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
# native library
RUN mv /usr/local/hadoop-required/csie-aparapi/libaparapi_x86_64.so /usr/local/hadoop/lib/native
RUN mv /usr/local/hadoop-required/aparapi-lambda/libaparapi_agent_x86_64.so /usr/local/hadoop/lib/native
RUN mv /usr/local/hadoop-required/aparapi-lambda/libaparapi_opencl_x86_64.so /usr/local/hadoop/lib/native
RUN cp /usr/local/hadoop-required/aparapi-lambda/okra/dist/bin/libokra_x86_64.so /usr/local/hadoop/lib/native
RUN mv /usr/local/hadoop-required/aparapi-lambda/okra/dist/bin/libokra_x86_64.so /opt/hsa/lib

RUN rm -f /usr/local/hadoop/etc/hadoop/hadoop-env.sh 
ADD config/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh 
ADD config/start-node.sh /usr/local/hadoop/sbin/start-node.sh 
ADD config/stop-node.sh /usr/local/hadoop/sbin/stop-node.sh 
RUN chown -R yiwei:hadoop /usr/local/hadoop-2.6.0

EXPOSE 22
