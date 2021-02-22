FROM    tensin-base-debian

RUN     apt-get update && apt-get install -y curl ca-certificates tar unzip && apt-clean

# Set environment
ENV     JAVA_HOME /opt/jdk
ENV     PATH ${PATH}:${JAVA_HOME}/bin
ENV     JAVA_PACKAGE    openjdk
ENV     JAVA_VERSION 	15.0.2
ENV     JAVA_HASH 	0d1cfde4252546c6931946de8db48ee2
# ENV     JAVA_VERSION_BUILD 10

# Download and unarchive Java
# https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz
RUN mkdir -p -m 777 /opt && curl -jkSL \
    https://download.java.net/java/GA/jdk${JAVA_VERSION}/${JAVA_HASH}/7/GPL/${JAVA_PACKAGE}-${JAVA_VERSION}_linux-x64_bin.tar.gz \
     | tar -xzf - -C /opt && \
   ln -s $(ls -d1 /opt/jdk* | tail -1) /opt/jdk && \
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
