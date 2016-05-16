FROM	tensin-base-alpine

RUN	apk add --no-cache python3 && \
	apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
	wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3 && \
	ln -s /usr/bin/python3 /usr/bin/python && \
	apk del build-dependencies 
