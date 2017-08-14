FROM	tensin-base-alpine

CMD	["/usr/sbin/minidlnad", "-d", "-S"]
EXPOSE	8200 1900/udp
VOLUME	["/data", "/var/cache/minidlna/"]
WORKDIR /data/

RUN	apk --update --no-cache add minidlna && \
	mkdir -p /data/{images,music,videos} 

ADD	minidlna.conf /etc/minidlna.conf
