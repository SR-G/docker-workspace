FROM	tensin-base-alpine

VOLUME	["/data","/root/.caddy/"]
WORKDIR	/data
EXPOSE 	80 443 2015

CMD 	["/opt/caddy/caddy", "--conf", "/etc/caddy.conf"]

ADD	caddy.conf /etc/caddy.conf

ARG	PLUGINS=git%2Cminify%2Cfilemanager

RUN	apk add --update openssh-client curl git tar && \
	mkdir -p /opt/caddy/ && \
	curl --silent --show-error --fail --location \
	--header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
	"https://caddyserver.com/download/build?os=linux&arch=amd64&features=${PLUGINS}" \
	| tar --no-same-owner -C /opt/caddy/ -xz caddy \
	&& chmod a+x,a+r /opt/caddy/caddy \
	&& /opt/caddy/caddy -version
