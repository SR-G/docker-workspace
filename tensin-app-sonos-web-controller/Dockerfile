FROM	tensin-base-alpine-nodejs

EXPOSE	8080
WORKDIR	/opt/sonos-web-controller/
CMD	nodejs server.js

RUN	apk --update add git && \
	git clone https://github.com/jishi/node-sonos-web-controller /opt/sonos-web-controller/ && \
	cd /opt/sonos-web-controller/ && \
	npm install
