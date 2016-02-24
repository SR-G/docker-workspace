FROM	tensin-base-alpine-java-jdk8

EXPOSE	8080
VOLUME	["/var/lib/youtrack/"]
ADD	files/etc /etc
CMD	java \
        -XX:MaxPermSize=250m -Xmx1g \
        -Duser.home=/var/lib/youtrack/ \
        -Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts -Djavax.net.ssl.trustStorePassword=changeit \
        -Djetbrains.youtrack.disableBrowser=true -Djetbrains.youtrack.enableGuest=false \
        -Djetbrains.mps.webr.log4jPath=/etc/youtrack/log4j.xml -Djava.awt.headless=true \
        -jar /opt/youtrack/youtrack.jar 8080

ENV	YOUTRACK_VERSION 6.5.17031

RUN	mkdir -p /opt/youtrack/ /var/lib/youtrack/ &&
	curl -sLo /opt/youtrack/youtrack-$YOUTRACK_VERSION.jar https://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar && \
	mv /opt/youtrack/youtrack-$YOUTRACK_VERSION.jar /opt/youtrack/youtrack.jar
