FROM jedwards/ubuntu-hsa-v1.0
MAINTAINER YIWEI CHEN <feberium@gmail.com>

# Update Ubuntu
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y maven llvm-gcc build-essential zlib1g-dev make cmake pkg-config libssl-dev automake autoconf 

# Add oracle java 8 repository
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update

# Accept the Oracle Java license
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections

# Install Oracle Java
RUN apt-get -y install oracle-java8-installer

RUN update-alternatives --display java

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/ 
ENV PATH $PATH:$JAVA_HOME/bin

EXPOSE 22
