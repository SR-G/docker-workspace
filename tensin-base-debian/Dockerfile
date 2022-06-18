FROM	debian:bullseye-slim
MAINTAINER SRG <serge.simon@gmail.com>

ENV	TIMEZONE Europe/Paris
ENV	HOME /root
ENV	TERM xterm
ENV	DEBIAN_FRONTEND noninteractive

# Insert bashrc
ADD	bashrc /root/.bashrc
ADD	apt-clean /usr/bin/

RUN	apt-get update && apt-get upgrade -y && apt-get install -y bash tzdata apt-utils locales && \
	echo $TIMEZONE > /etc/timezone && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	sed -i -e 's/# en_US.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
	locale-gen fr_FR.UTF-8 && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=fr_FR.UTF-8 && \
	apt-clean

ENV	LANG fr_FR.UTF-8
ENV	LANGUAGE fr_FR.UTF-8
ENV	LC_ALL fr_FR.UTF-8
