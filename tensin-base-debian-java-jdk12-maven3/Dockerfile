FROM	tensin-base-debian-java-jdk12

# Set Appropriate Environmental Variables
ENV     MAVEN_HOME /opt/maven
ENV     PATH $PATH:$MAVEN_HOME/bin
ENV     MAVEN_VERSION 3.6.1

# Maven
RUN     mkdir -p /opt/ && cd /opt && \
	curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /opt && \
        ln -s /opt/apache-maven-$MAVEN_VERSION/ /opt/maven 
