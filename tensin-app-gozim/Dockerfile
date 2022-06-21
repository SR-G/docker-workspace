FROM	tensin-base-debian-golang AS BUILD

RUN	apt-get update && apt-get install -y build-essential pkg-config

RUN	apt-get install -y gettext && mkdir -p /data/ && cd /data/ && \
	export GOPATH="/data/" && \
	git clone https://github.com/JojiiOfficial/ZimWiki && \
	cd ZimWiki && \
	sed -i 's/Address = ":8080"/Address = "0.0.0.0:8080"/' main.go && \
	make build 

FROM    tensin-base-debian

CMD	["/opt/gozim/ZimWiki"]
WORKDIR	/opt/gozim/
EXPOSE	8080
VOLUME	["/zim"]

COPY	--from=BUILD /data/ZimWiki/ZimWiki /opt/gozim/

