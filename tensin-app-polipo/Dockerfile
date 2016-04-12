FROM	tensin-base-alpine
VOLUME	["/cache", "/etc/polipo/"]
EXPOSE	8123
CMD	[ "/usr/local/bin/polipo", "-c", "/etc/polipo/config" ]
ADD	./etc /etc/

ENV	POLIPO_VERSION	1.1.1

RUN	mkdir -p /etc/polipo /cache /opt/ && \
	apk --update add ca-certificates build-base texinfo git && \
	git clone https://github.com/jech/polipo.git /opt/polipo/ && \
	cd /opt/polipo/ && \
	git checkout polipo-$POLIPO_VERSION && \
	make && \
	make install


