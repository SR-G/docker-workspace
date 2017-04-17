FROM	ubuntu:16.04
MAINTAINER SRG <serge.simon@gmail.com>

ENV	DEBIAN_FRONTEND noninteractive
ENV	TIMEZONE Europe/Paris

# Activate multiverse, make sure the package repository is up to date and update ubuntu
RUN	sed -i 's/http:\/\/archive/http:\/\/fr.archive/g' /etc/apt/sources.list && \
	sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
	apt-get update && apt-get -y upgrade && \
	apt-get install -y curl git htop man software-properties-common tzdata locales unzip vim wget && \
	locale-gen fr_FR.UTF-8 && \
	dpkg-reconfigure tzdata && \
	echo $TIMEZONE > /etc/timezone && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Keep this after packages have been installed
ENV	LANG fr_FR.UTF-8
ENV	LANGUAGE fr_FR.UTF-8
ENV	LC_ALL fr_FR.UTF-8
ENV	HOME /root
ENV	TERM xterm

# Insert bashrc
ADD	bashrc /root/.bashrc
