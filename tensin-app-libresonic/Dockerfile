FROM	tensin-base-alpine-java-jdk8

EXPOSE	4040
RUN	mkdir /opt/libresonic/
WORKDIR	/opt/libresonic
VOLUME	["/var/subsonic/","/mp3/"]
CMD	["/opt/libresonic/subsonic.sh"]
ADD	subsonic.sh /opt/libresonic/
ADD	subsonic-booter-jar-with-dependencies.jar /opt/libresonic/

ENV	LIBRESONIC_VERSION 6.0.1
ADD	https://github.com/Libresonic/libresonic/releases/download/v${LIBRESONIC_VERSION}/libresonic-v${LIBRESONIC_VERSION}.war /opt/libresonic/
RUN	mv /opt/libresonic/libresonic-v${LIBRESONIC_VERSION}.war /opt/libresonic/subsonic.war
