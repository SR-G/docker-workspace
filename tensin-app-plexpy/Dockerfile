FROM	tensin-base-alpine

VOLUME	["/data"]
EXPOSE	8181

RUN	apk add --update git python && rm /var/cache/apk/*
RUN	mkdir -p /opt/plexpy && \
	git clone https://github.com/drzoidberg33/plexpy.git /opt/plexpy/

WORKDIR	/opt/plexpy
CMD	["python", "PlexPy.py", "--nolaunch", "--datadir=/data"]

