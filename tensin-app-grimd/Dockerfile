FROM tensin-base-alpine

EXPOSE 	53/udp 53/tcp 8080
WORKDIR	/opt/grimd/
CMD	/opt/grimd/grimd -config /data/grimd.toml
VOLUME	["/data/"]

RUN	apk --update upgrade && \
	apk add curl ca-certificates && \
	update-ca-certificates && \
	rm -rf /var/cache/apk/*

ENV	GRIMD_ARCHITECTURE	linux_x64
ENV	GRIMD_VERSION	1.0.3

# https://github.com/looterz/grimd/releases/download/v1.0.3/grimd_linux_x64
ADD	https://github.com/looterz/grimd/releases/download/v${GRIMD_VERSION}/grimd_${GRIMD_ARCHITECTURE}	/opt/grimd/grimd

RUN	chmod a+x /opt/grimd/grimd

