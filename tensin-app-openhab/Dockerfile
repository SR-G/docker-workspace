FROM	tensin-base-alpine-java-jdk8

EXPOSE	8080 8443
VOLUME	["/opt/openhab/configurations/"]
WORKDIR	/opt/openhab/
ADD	bootstrap.sh /opt/openhab/
RUN	apk --update add curl unzip && \
	chmod a+x /opt/openhab/bootstrap.sh

ENV	OPENHAB_VERSION 1.8.2

CMD	/opt/openhab/bootstrap.sh $OPENHAB_VERSION && /opt/openhab/$OPENHAB_VERSION/runtime/start.sh
