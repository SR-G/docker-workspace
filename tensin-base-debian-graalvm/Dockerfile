FROM 	tensin-base-debian

RUN 	apt-get update && apt-get -y install gcc build-essential zlib1g zlib1g-dev && \
	apt-clean

WORKDIR	/opt/

ENV	GRAALVM_VERSION 1.0.0-rc6
ENV	GRAALVM_HOME /opt/graalvm/
ENV	JAVA_HOME ${GRAALVM_HOME}
ENV	PATH ${PATH}:${JAVA_HOME}/bin

ADD 	https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz /opt/

RUN	tar xzvf graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz && rm -f *.tar.gz && \
	ln -s /opt/graalvm-ce-${GRAALVM_VERSION}/ /opt/graalvm 
