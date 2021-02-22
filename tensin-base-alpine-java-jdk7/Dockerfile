FROM    tensin-base-alpine

# Set environment
ENV     JAVA_HOME /opt/jdk
ENV     JAVA_PACKAGE       jdk
ENV     PATH ${PATH}:${JAVA_HOME}/bin

ENV     GLIBC_VERSION   2.27-r0
ENV     GLIBC_URL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/
RUN     apk --no-cache --update add curl ca-certificates tar gzip && \
        echo "${GLIBC_URL}/glibc-${GLIBC_VERSION}.apk" && \
        curl -sLo /tmp/glibc-${GLIBC_VERSION}.apk ${GLIBC_URL}/glibc-${GLIBC_VERSION}.apk && \
        curl -sLo /tmp/glibc-bin-${GLIBC_VERSION}.apk ${GLIBC_URL}/glibc-bin-${GLIBC_VERSION}.apk && \
        curl -sLo /tmp/glibc-i18n-${GLIBC_VERSION}.apk ${GLIBC_URL}/glibc-i18n-${GLIBC_VERSION}.apk && \
        apk add --no-cache --allow-untrusted /tmp/glibc-${GLIBC_VERSION}.apk /tmp/glibc-bin-${GLIBC_VERSION}.apk /tmp/glibc-i18n-${GLIBC_VERSION}.apk && \
	/usr/glibc-compat/bin/localedef -i fr_FR -f UTF-8 fr_FR.UTF-8

# Download and unarchive Java
ADD 	jdk-7u80-linux-i586.tar.gz	/opt/

# Download and unarchive Java
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
