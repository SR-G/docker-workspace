FROM	tensin-base-alpine-nodejs

WORKDIR	/opt/sonos-web-controller/
CMD	node server.js
ENV	SONOS_CONTROLLER_PORT	8001
EXPOSE	${SONOS_CONTROLLER_PORT}

RUN	apk --update add git && \
	git clone https://github.com/jishi/node-sonos-web-controller /opt/sonos-web-controller/ && \
	cd /opt/sonos-web-controller/ && \
	echo "{ \"port\": ${SONOS_CONTROLLER_PORT}, \"cacheDir\": \"./cache\" } " > settings.json && \
	npm install
