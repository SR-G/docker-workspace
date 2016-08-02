FROM	tensin-base-ubuntu-java-jdk8

ENTRYPOINT ["/bin/bash" "/x11-src/startup.sh"]
CMD 	["/usr/bin/lxterminal"]

EXPOSE 	5900/tcp
VOLUME 	["/data]
WORKDIR	/data

ENV	X11_USER=xclient
ENV	RESOLUTION=1680x879x16

ADD 	x11-src /x11-src

# Set locale to UTF-8 to fix the locale warnings
RUN 	localedef -v -c -i fr_FR -f UTF-8 fr_FR.UTF-8 || :

RUN	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y lxde-core lxterminal xvfb x11vnc sudo software-properties-common autocutsel && \
	add-apt-repository ppa:webupd8team/java && \
	add-apt-repository ppa:vincent-vandevyvre/vvv && \
	apt-get update && \
	apt-get install -y firefox xterm && \
	apt-get clean && \
	chmod -R a=rX /x11-src

# Fix problems with Upstart and DBus inside a docker container.
RUN	dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

