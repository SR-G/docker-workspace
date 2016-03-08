FROM	tensin-base-alpine

VOLUME	["/data/"]
ENV	BORG_VERSION 1.0.0

RUN     apk add --update git musl python3 && rm /var/cache/apk/* && \
	pip3 install borgbackup==$BORG_VERSION
