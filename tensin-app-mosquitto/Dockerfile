FROM	tensin-base-alpine

EXPOSE	1883 9883
VOLUME	["/var/lib/mosquitto", "/etc/mosquitto", "/etc/mosquitto.d"]
WORKDIR	/var/lib/mosquitto/

CMD	chown mosquitto:mosquitto -R /var/lib/mosquitto && mosquitto -c /etc/mosquitto/mosquitto.conf

RUN	addgroup -S mosquitto && \
	adduser -S -H -h /var/empty -s /sbin/nologin -D -G mosquitto mosquitto && \
	apk add --update mosquitto mosquitto-clients && \
	rm -rf /var/cache/apk/*
