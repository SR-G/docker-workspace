# Dockerfile for containerizing a graphical X11 applications. 
# 
# X11 applications are exposed via VNC on port 5900
#
# The VNC port is unprotected. To protect it, one can
# use a separete ssh jump host, e.g. 
# https://registry.hub.docker.com/u/geggo98/ssh-vpn-jump-host/
# 
# Author: stefan@schwetschke.de
# Date: 2014-11-06

# Using Ubuntu LTS, because it gets security updates very fast
FROM	tensin-base-ubuntu-java-jdk8

ENV	X11_USER xclient
ENV	RESOLUTION 1680x879x16

VOLUME	/home
EXPOSE	5900

# Set locale to UTF-8 to fix the locale warnings
RUN localedef -v -c -i fr_FR -f UTF-8 fr_FR.UTF-8 || :

# Installing the environment required: xserver, xdm, flux box, roc-filer and ssh
# and install some basic packages
# and clean up apt-get

RUN	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y lxde-core lxterminal xvfb x11vnc sudo software-properties-common autocutsel && \
	add-apt-repository ppa:webupd8team/java && \
	add-apt-repository ppa:vincent-vandevyvre/vvv && \
	apt-get update && \
	apt-get install -y firefox xterm && \
	apt-get clean

# Fix problems with Upstart and DBus inside a docker container.
RUN	dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

# Copy the files into the container
ADD	. /x11-src
RUN	chmod -R a=rX /x11-src

# Start x11vnc
ENTRYPOINT ["/bin/bash", "/x11-src/startup.sh"]
CMD	["/usr/bin/lxterminal"]
