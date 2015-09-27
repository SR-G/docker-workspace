FROM    tensin-base-alpine-java-jdk8

ENV     MAVEN_VERSION 3.3.1

# Maven
RUN     curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share && \
        mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
        ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Set Appropriate Environmental Variables
ENV     MAVEN_HOME /usr/share/maven
ENV     PATH $PATH:$MAVEN_HOME/bin
