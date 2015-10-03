FROM	tensin-base-alpine-java-jdk8

EXPOSE	4040
RUN	mkdir /opt/subsonic/
WORKDIR	/opt/subsonic
VOLUME	["/var/subsonic"]
VOLUME	["/mp3"]
CMD	["/opt/subsonic/subsonic.sh"]
ADD	subsonic.sh /opt/subsonic/
ADD	subsonic-booter-jar-with-dependencies.jar /opt/subsonic/
ADD	http://nexus.tensin.org/content/sites/resources/war/subsonic.war /opt/subsonic/
