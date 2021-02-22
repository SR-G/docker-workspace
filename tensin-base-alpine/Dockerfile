FROM	alpine:3.13.2
MAINTAINER SRG <serge.simon@gmail.com>

ENV	TIMEZONE Europe/Paris
ENV	LANG fr_FR.UTF-8
ENV	LANGUAGE fr_FR.UTF-8
ENV	LC_ALL fr_FR.UTF-8
ENV	HOME /root
ENV	TERM xterm

# Insert bashrc
ADD	bashrc /root/.bashrc

RUN	apk add --update bash tzdata && \
	echo $TIMEZONE > /etc/timezone && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	apk del tzdata && rm -rf /var/cache/apk/*
