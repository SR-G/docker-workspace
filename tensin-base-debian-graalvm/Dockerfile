FROM 	tensin-base-debian

RUN 	apt-get update && apt-get -y install gcc build-essential zlib1g zlib1g-dev && \
	apt-clean

WORKDIR	/opt/

ENV	GRAALVM_HOME 		/opt/graalvm/
ENV	JAVA_HOME 		${JAVA_HOME}:${GRAALVM_HOME}
ENV	PATH 			${PATH}:${JAVA_HOME}/bin
ENV	GRAALVM_JAVA_VERSION	java11
ENV	GRAALVM_VERSION 	21.0.0.2

#       https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.0.0.2/graalvm-ce-java11-linux-amd64-21.0.0.2.tar.gz
ADD 	https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_JAVA_VERSION}-linux-amd64-${GRAALVM_VERSION}.tar.gz /opt/

RUN	tar xzvf graalvm-ce-${GRAALVM_JAVA_VERSION}-linux-amd64-${GRAALVM_VERSION}.tar.gz && rm -f *.tar.gz && \
	ln -s /opt/graalvm-ce-${GRAALVM_JAVA_VERSION}-${GRAALVM_VERSION}/ /opt/graalvm 
