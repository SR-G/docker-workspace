FROM	tensin-base-alpine

# Install cURL
ENV	GLIBC_VERSION	2.27-r0
# 		  https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.26-r0/glibc-2.25-r0.apk
ENV	GLIBC_URL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/
RUN	apk --no-cache --update add curl ca-certificates tar gzip && \
	echo "${GLIBC_URL}/glibc-${GLIBC_VERSION}.apk" && \
	curl -sLo /tmp/glibc-${GLIBC_VERSION}.apk ${GLIBC_URL}/glibc-${GLIBC_VERSION}.apk && \
	curl -sLo /tmp/glibc-bin-${GLIBC_VERSION}.apk ${GLIBC_URL}/glibc-bin-${GLIBC_VERSION}.apk && \
	curl -sLo /tmp/glibc-i18n-${GLIBC_VERSION}.apk ${GLIBC_URL}/glibc-i18n-${GLIBC_VERSION}.apk && \
	apk add --no-cache --allow-untrusted /tmp/glibc-${GLIBC_VERSION}.apk /tmp/glibc-bin-${GLIBC_VERSION}.apk /tmp/glibc-i18n-${GLIBC_VERSION}.apk && \
	/usr/glibc-compat/bin/localedef -i fr_FR -f UTF-8 fr_FR.UTF-8

# Java Version
ENV	JAVA_VERSION_MAJOR 8
ENV	JAVA_VERSION_MINOR 181
ENV	JAVA_VERSION_BUILD 13
ENV	JAVA_PACKAGE       jdk
ENV	JAVA_UUID 	   96a7b8442fe848ef90c96a2fad6ed6d1

# Download and unarchive Java
# http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.tar.gz?AuthParam=1509888995_1af4c2200894c6180842a064d16a39bc
# http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz?AuthParam=1532551342_a1c5f4e6dd24058ef5d961875f80c224
RUN mkdir /opt && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
  http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_UUID}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz && \
    ls -Al /tmp && \
    tar -xvzf /tmp/java.tar.gz -C /opt &&\
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk &&\
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
           /opt/jdk/jre/lib/amd64/libjfx*.so && \
    rm -rf /opt/jdk/jre/bin/jjs \
           /opt/jdk/jre/bin/keytool \
           /opt/jdk/jre/bin/orbd \
           /opt/jdk/jre/bin/pack200 \
           /opt/jdk/jre/bin/policytool \
           /opt/jdk/jre/bin/rmid \
           /opt/jdk/jre/bin/rmiregistry \
           /opt/jdk/jre/bin/servertool \
           /opt/jdk/jre/bin/tnameserv \
           /opt/jdk/jre/bin/unpack200 \
           /opt/jdk/jre/lib/ext/nashorn.jar \
           /opt/jdk/jre/lib/jfr.jar \
           /opt/jdk/jre/lib/jfr \
           /opt/jdk/jre/lib/oblique-fonts

# Set environment
ENV	JAVA_HOME /opt/jdk
ENV	PATH ${PATH}:${JAVA_HOME}/bin
