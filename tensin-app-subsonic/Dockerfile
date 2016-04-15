FROM	tensin-base-alpine-java-jdk8

EXPOSE	4040
RUN	mkdir /opt/subsonic/
WORKDIR	/opt/subsonic
VOLUME	["/var/subsonic/","/mp3/"]
CMD	["/opt/subsonic/subsonic.sh"]
ADD	subsonic.sh /opt/subsonic/
ADD	subsonic-booter-jar-with-dependencies.jar /opt/subsonic/

ENV	SUBSONIC_VERSION 5.3
ADD	http://nexus.tensin.org/content/sites/resources/war/subsonic-${SUBSONIC_VERSION}.war /opt/subsonic/
RUN	mv /opt/subsonic/subsonic-${SUBSONIC_VERSION}.war /opt/subsonic/subsonic.war
