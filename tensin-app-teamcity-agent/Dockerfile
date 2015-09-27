FROM	tensin-base-alpine-java-jdk8
ADD	setup.sh /setup.sh
EXPOSE	9090
CMD	/bin/bash -c "TEAMCITY_SERVER=$TEAMCITY_SERVER AGENT_NAME=$AGENT_NAME bash /setup.sh run"

# Set Appropriate Environmental Variables
ENV     MAVEN_HOME /usr/share/maven
ENV	GRADLE_HOME /opt/gradle
ENV	PATH $PATH:$GRADLE_HOME/bin:$MAVEN_HOME/bin

# Gradle & maven version
ENV	GRADLE_VERSION 2.7
ENV     MAVEN_VERSION 3.3.1

# Maven
RUN     curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share && \
        mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
        ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Gradle
RUN	curl -Lks https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip -o /root/gradle.zip && \
	mkdir -p /opt/ && cd /opt/ && \
	unzip /root/gradle.zip && \
	ln -s gradle-${GRADLE_VERSION} gradle && \
	rm -f /root/gradle.zip
