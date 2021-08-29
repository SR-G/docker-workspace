FROM    tensin-base-debian

RUN     apt-get update && apt-get install -y curl ca-certificates tar unzip && apt-clean

# Set environment
ENV     JAVA_PACKAGE       jdk
ENV     JAVA_HOME /opt/jdk
ENV     PATH .:$PATH:$JAVA_HOME/bin

# Java Version
# https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz?AuthParam=1543518300_a56c217e3fe1643603d5859ba373ed7d
# https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz?AuthParam=1547851308_26fba616fea1fe7295312759a25c2afa
# https://download.oracle.com/otn/java/jdk/8u281-b09/89d678f2be164786b292527658ca1605/jdk-8u281-linux-i586.tar.gz?AuthParam=1613942274_6276394331bff126cb1024a0b08acecf
# ENV     JAVA_VERSION 8u201
# ENV     JAVA_HASH 42970487e3af4f5aa5bca3f542482c60
# ENV     JAVA_VERSION_BUILD b09
# ENV	JAVA_DOWNLOAD_URL https://download.oracle.com/otn-pub/java/${JAVA_PACKAGE}/${JAVA_VERSION}-${JAVA_VERSION_BUILD}/${JAVA_HASH}/${JAVA_PACKAGE}-${JAVA_VERSION}-linux-x64.tar.gz

ADD 	jdk-8u301-linux-x64.tar.gz 	/opt/

# Download and unarchive Java
#	echo "Download : ${JAVA_DOWNLOAD_URL}" && \
#	curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" ${JAVA_DOWNLOAD_URL} | tar -xzf - -C /opt &&\
RUN	ln -s $(ls -d1 /opt/${JAVA_PACKAGE}* | tail -1) /opt/jdk && \
	rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/lib/plugin.jar \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so
