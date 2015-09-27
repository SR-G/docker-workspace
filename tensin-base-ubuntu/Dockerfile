FROM	ubuntu:trusty
MAINTAINER SRG <serge.simon@gmail.com>

ENV	DEBIAN_FRONTEND noninteractive
ENV	TIMEZONE Europe/Paris

# Activate multiverse, make sure the package repository is up to date and update ubuntu
RUN	sed -i 's/http:\/\/archive/http:\/\/fr.archive/g' /etc/apt/sources.list
RUN	sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
	apt-get update && apt-get -y upgrade && \
	locale-gen fr_FR.UTF-8
RUN	apt-get install -y curl git htop man software-properties-common unzip vim wget zsh

RUN	echo $TIMEZONE > /etc/timezone && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	dpkg-reconfigure tzdata

ENV	LANG fr_FR.UTF-8
ENV	LANGUAGE fr_FR.UTF-8
ENV	LC_ALL fr_FR.UTF-8
ENV	HOME /root
ENV	TERM xterm

# Insert bashrc
ADD	bashrc /root/.bashrc
RUN	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
