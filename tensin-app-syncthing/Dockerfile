FROM	tensin-base-alpine

EXPOSE	8080 21025 22000

ENV	UID 1027
ENV	GOSU_VERSION 1.9
ENV	SYNCTHING_VERSION 0.14.3

RUN	echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
	apk --update add curl ca-certificates shadow
RUN	curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" && \
	chmod a+x /usr/local/bin/gosu
RUN	useradd --no-create-home -g users syncthing
RUN	mkdir /opt/ && cd /opt/ && \
	curl -o /opt/syncthing.tar.gz -SL https://github.com/syncthing/syncthing/releases/download/v${SYNCTHING_VERSION}/syncthing-linux-amd64-v${SYNCTHING_VERSION}.tar.gz && \
	tar -xzvf syncthing.tar.gz && \
	rm -f syncthing.tar.gz && \
	mv syncthing-linux-amd64-v${SYNCTHING_VERSION} syncthing && \
	rm -rf syncthing/etc/ && \
	rm -f syncthing/*.pdf && \
	rm -f syncthing/*.txt && \
	mkdir -p /opt/syncthing/config /opt/syncthing/data 

WORKDIR	/opt/syncthing/
VOLUME	["/opt/syncthing/data", "/opt/syncthing/config"]
CMD	["/opt/syncthing/start.sh"]

ADD	./start.sh /opt/syncthing/start.sh
RUN	chmod 770 /opt/syncthing/start.sh
