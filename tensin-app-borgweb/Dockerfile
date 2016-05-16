FROM	tensin-base-alpine-nodejs

VOLUME	["/data/"]

RUN	apk --update add git && \
	mkdir /opt/ && cd /opt/ && git clone https://github.com/borgbackup/borgweb.git && \
	cd borgweb/js && \
	npm install 
RUN	npm install gulp gulp-cli && \
	gulp watch

WORKDIR	["/opt/borgweb/"]
