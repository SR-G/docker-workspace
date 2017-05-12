FROM	library/golang:alpine

ENV	TIMEZONE Europe/Paris
ENV	LANG fr_FR.UTF-8
ENV	LANGUAGE fr_FR.UTF-8
ENV	LC_ALL fr_FR.UTF-8
ENV	HOME /root
ENV	TERM xterm

# Insert bashrc
ADD	bashrc /root/.bashrc

ENV	GITHUB_RELEASE_VERSION 0.7.2

RUN	apk add --update bash tzdata curl ca-certificates git openssl && \
	curl https://github.com/aktau/github-release/releases/download/v${GITHUB_RELEASE_VERSION}/linux-amd64-github-release.tar.bz2 -sLo - | tar -xjf - -C /tmp && \
	mv /tmp/bin/linux/amd64/github-release /usr/local/bin && rm -rf /tmp/ && \
	echo $TIMEZONE > /etc/timezone && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	apk del tzdata && rm -rf /var/cache/apk/*
