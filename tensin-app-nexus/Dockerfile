FROM	tensin-base-alpine-java-jdk8

ENV	SONATYPE_WORK /sonatype-work
ENV	CONTEXT_PATH /
ENV	JAVA_OPTS -server -XX:MaxPermSize=192m -Djava.net.preferIPv4Stack=true
ENV	LAUNCHER_CONF ./conf/jetty.xml ./conf/jetty-requestlog.xml
ENV	MAX_HEAP 768m
ENV	MIN_HEAP 256m

VOLUME	${SONATYPE_WORK}
EXPOSE	8081

RUN	adduser -h ${SONATYPE_WORK} -s /bin/false nexus

ENV	NEXUS_VERSION 2.11.4-01

RUN	mkdir -p /opt/sonatype/nexus \
  && curl --fail --silent --location --retry 3 \
    https://download.sonatype.com/nexus/oss/nexus-${NEXUS_VERSION}-bundle.tar.gz \
  | gunzip \
  | tar x -C /tmp nexus-${NEXUS_VERSION} \
  && mv /tmp/nexus-${NEXUS_VERSION}/* /opt/sonatype/nexus/ \
  && rm -rf /tmp/nexus-${NEXUS_VERSION}

WORKDIR	/opt/sonatype/nexus
CMD	["java", "-Dnexus-work=${SONATYPE_WORK}", "-Dnexus-webapp-context-path=${CONTEXT_PATH}", "-Xms${MIN_HEAP}", "-Xmx${MAX_HEAP}", "-cp", "'conf/:lib/*'", "${JAVA_OPTS}", "org.sonatype.nexus.bootstrap.Launcher", "${LAUNCHER_CONF}"]
