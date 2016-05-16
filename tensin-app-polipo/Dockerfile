FROM	tensin-base-alpine
VOLUME	["/cache", "/etc/polipo/"]
EXPOSE	8123
CMD	[ "/usr/local/bin/polipo", "-c", "/etc/polipo/config" ]
ADD	./etc /etc/

ENV	POLIPO_VERSION	1.1.1

RUN	mkdir -p /etc/polipo /cache /opt/ && \
	apk --update add ca-certificates build-base texinfo git && \
#	apt-get update && apt-get install -y ca-certificates git texinfo build-essential install-info && \
	git clone https://github.com/jech/polipo.git /opt/polipo/ && \
	cd /opt/polipo/ && \
	git checkout polipo-$POLIPO_VERSION && \
	make EXTRA_DEFINES="-DCHUNK_SIZE=16384" && \
	make install
