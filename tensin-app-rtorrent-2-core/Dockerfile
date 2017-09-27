FROM	tensin-base-alpine

EXPOSE 	49160 49161
VOLUME 	["/data/rtorrent/","/run/rtorrent/"]
WORKDIR	/data/
ENV	MEDIAINF_VER 0.7.94

# compile mediainfo packages
RUN	apk add --no-cache --virtual=build-dependencies autoconf automake cppunit-dev curl curl-dev file g++ gcc git libressl-dev libtool make ncurses-dev && \
	curl -o /tmp/libmediainfo.tar.gz -L "http://mediaarea.net/download/binary/libmediainfo0/${MEDIAINF_VER}/MediaInfo_DLL_${MEDIAINF_VER}_GNU_FromSource.tar.gz" && \
	curl -o /tmp/mediainfo.tar.gz -L "http://mediaarea.net/download/binary/mediainfo/${MEDIAINF_VER}/MediaInfo_CLI_${MEDIAINF_VER}_GNU_FromSource.tar.gz" && \
	mkdir -p /tmp/libmediainfo /tmp/mediainfo && tar xf /tmp/libmediainfo.tar.gz -C /tmp/libmediainfo --strip-components=1 && \
	tar xf /tmp/mediainfo.tar.gz -C /tmp/mediainfo --strip-components=1 && \
	cd /tmp/libmediainfo && ./SO_Compile.sh && \
	cd /tmp/libmediainfo/ZenLib/Project/GNU/Library && make install && \
	cd /tmp/libmediainfo/MediaInfoLib/Project/GNU/Library && make install && \
	cd /tmp/mediainfo && ./CLI_Compile.sh && \
	cd /tmp/mediainfo/MediaInfo/Project/GNU/CLI && make install && \
	apk del --purge build-dependencies && rm -rf /etc/nginx/conf.d/default.conf /tmp/*

CMD	/opt/start.sh

# rtorrent configuration
ADD	.rtorrent.rc /root/
ADD	start.sh /opt/

# rtorrent setup  
RUN	apk update && apk add --no-cache rtorrent curl openssl ca-certificates ffmpeg php7 php7-cli unrar tmux && \
	mkdir -p /data/rtorrent/.session /data/rtorrent/downloads/ /data/rtorrent/uploads/ /data/rtorrent/watch/ /data/rtorrent/finished/ /run/rtorrent/ && \
	addgroup -g 1000 rtorrent && \
	chmod a+x /opt/start.sh
