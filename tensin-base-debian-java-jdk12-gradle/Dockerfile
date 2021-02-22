FROM	tensin-base-debian-java-jdk12

# Set Appropriate Environmental Variables
ENV	GRADLE_HOME /opt/gradle
ENV	PATH $PATH:$GRADLE_HOME/bin

# Gradle version
ENV	GRADLE_VERSION 6.8.2

# Gradle
RUN	curl -Lks https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip -o /root/gradle.zip && \
	mkdir -p /opt/ && cd /opt/ && \
	unzip /root/gradle.zip && \
	ln -s gradle-${GRADLE_VERSION}/ gradle && \
	rm -f /root/gradle.zip
