FROM	tensin-base-alpine-java-jdk8

WORKDIR /opt/
ENV	GROOVY_HOME /opt/groovy/
ENV	PATH ${PATH}:${GROOVY_HOME}/bin
ENV	GROOVY_VERSION 2.4.7

RUN	apk --update add curl unzip && \
	curl -sLo /opt/groovy.zip https://bintray.com/artifact/download/groovy/maven/apache-groovy-binary-${GROOVY_VERSION}.zip && \
	unzip /opt/groovy.zip && \
	rm -f /opt/groovy.zip && \
	ln -s /opt/groovy-${GROOVY_VERSION} /opt/groovy && \
	rm /bin/sh && ln -s /bin/bash /bin/sh
	#sed -ie '274,275d' /opt/groovy/bin/startGroovy
