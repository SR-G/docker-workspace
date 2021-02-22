FROM    tensin-base-alpine-java-jdk8

# Set Appropriate Environmental Variables
ENV     MAVEN_HOME /usr/share/maven
ENV     PATH $PATH:$MAVEN_HOME/bin
ENV     MAVEN_VERSION 3.5.4

# Maven
RUN     apk --update add subversion git && \
	curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share && \
        mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
        ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
