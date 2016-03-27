FROM	tensin-base-alpine

VOLUME	["/data/"]
WORKDIR	/opt/borgbackup/

# Install cURL
ENV     GLIBC_VERSION   2.23-r1
RUN     apk --update add curl ca-certificates tar && \
        curl -sLo /tmp/glibc-${GLIBC_VERSION}.apk https://github.com/andyshinn/alpine-pkg-glibc/releases/download/unreleased/glibc-${GLIBC_VERSION}.apk && \
        curl -sLo /tmp/glibc-bin-${GLIBC_VERSION}.apk https://github.com/andyshinn/alpine-pkg-glibc/releases/download/unreleased/glibc-bin-${GLIBC_VERSION}.apk && \
        curl -sLo /tmp/glibc-i18n-${GLIBC_VERSION}.apk https://github.com/andyshinn/alpine-pkg-glibc/releases/download/unreleased/glibc-i18n-${GLIBC_VERSION}.apk && \
        apk add --allow-untrusted /tmp/glibc-${GLIBC_VERSION}.apk /tmp/glibc-bin-${GLIBC_VERSION}.apk /tmp/glibc-i18n-${GLIBC_VERSION}.apk && \
        /usr/glibc-compat/bin/localedef -i fr_FR -f UTF-8 fr_FR.UTF-8

ENV	BORG_VERSION 1.0.0

RUN     apk add --update git musl python3 && rm /var/cache/apk/* && \
#	pip3 install borgbackup==$BORG_VERSION
	curl -sLo /opt/borgbackup/borg https://github.com/borgbackup/borg/releases/download/1.0.0/borg-linux64 && \
	chmod a+x /opt/borgbackup/borg

ENTRYPOINT	["/opt/borgbackup/borg"]
