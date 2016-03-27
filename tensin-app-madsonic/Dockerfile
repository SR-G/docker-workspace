FROM	tensin-base-alpine-java-jdk8

EXPOSE	4040
RUN	mkdir /opt/madsonic/
WORKDIR	/opt/madsonic/
VOLUME	["/var/madsonic/"]
VOLUME	["/mp3"]

# Package Information
ENV	PKG_VER 6.0
ENV	PKG_BUILD 7860
ENV	PKG_DATE 20160109
ENV	PKG_NAME madsonic

# create destination directories
RUN	apk --update add musl && \
	mkdir -p /opt/madsonic/media /opt/madsonic/transcode && \
	curl -o /opt/madsonic/madsonic.zip -L http://www.madsonic.org/download/${PKG_VER}/${PKG_DATE}_${PKG_NAME}-${PKG_VER}.${PKG_BUILD}-standalone.zip && \
	curl -o /opt/madsonic/transcode/transcode.zip -L http://www.madsonic.org/download/transcode/20150725_madsonic-transcode-x64.zip && \
	unzip /opt/madsonic/madsonic.zip -d /opt/madsonic && \
	unzip /opt/madsonic/transcode/transcode.zip -d /opt/madsonic/transcode && \
	chmod -R a+x /opt/madsonic/transcode/* && \
	rm -rf /opt/madsonic/transcode/mac /opt/madsonic/transcode/windows /opt/madsonic/madsonic.zip /opt/madsonic/transcode/transcode.zip /opt/madsonic/*.bat /opt/madsonic/*.html

ADD	madsonic.war /opt/madsonic/

CMD	export LC_ALL=fr_FR.UTF8 && export LANG=fr_FR.UTF8 && /opt/madsonic/madsonic.sh --home=/var/madsonic/ --host=0.0.0.0 --port=4040 --default-music-folder=/mp3 && tail -f /opt/madsonic/version.txt
