FROM	ubuntu:14.04
MAINTAINER SRG <serge.simon@gmail.com>

ENV	DEBIAN_FRONTEND noninteractive
ENV	TIMEZONE Europe/Paris
ENV	LANG fr_FR.UTF-8
ENV	LANGUAGE fr_FR.UTF-8
ENV	LC_ALL fr_FR.UTF-8
ENV	HOME /root
ENV	TERM xterm

# Activate multiverse, make sure the package repository is up to date and update ubuntu
RUN	sed -i 's/http:\/\/archive/http:\/\/fr.archive/g' /etc/apt/sources.list && \
	sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
	apt-get update && apt-get -y upgrade && \
	locale-gen fr_FR.UTF-8 && \
	apt-get install -y curl git htop man software-properties-common unzip vim wget zsh && \
	echo $TIMEZONE > /etc/timezone && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	dpkg-reconfigure tzdata && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Insert bashrc
ADD	bashrc /root/.bashrc
