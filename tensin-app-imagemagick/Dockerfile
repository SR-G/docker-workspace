FROM	tensin-base-alpine

WORKDIR	/data
VOLUME	["/data"]

CMD	["/bin/bash"]

RUN	echo "http://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
	apk --update --update-cache add git curl tar ca-certificates imagemagick  --allow-untrusted
