FROM	tensin-base-ubuntu-java-jdk8

ENV	GRADLE_VERSION	2.7

# Gradle
RUN	curl -Lks https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip -o /root/gradle.zip && \
	mkdir -p /opt/ && cd /opt/ && \
	unzip /root/gradle.zip && \
	ln -s gradle-${GRADLE_VERSION} gradle && \
	rm -f /root/gradle.zip

# Set Appropriate Environmental Variables
ENV	GRADLE_HOME /opt/gradle
ENV	PATH $PATH:$GRADLE_HOME/bin

# Default command is "/usr/bin/gradle -version" on /app dir
# (ie. Mount project at /app "docker --rm -v /path/to/app:/app gradle <command>")
# RUN mkdir /app
# WORKDIR /app
# ENTRYPOINT ["gradle"] 
# CMD ["-version"]
