FROM 	tensin-base-debian-java-jdk12

ENTRYPOINT ["/nxserver.sh"]

EXPOSE	4000

# Goto https://www.nomachine.com/download/download&id=6 and change for the latest NOMACHINE_PACKAGE_NAME and MD5 shown in that link to get the latest version.
# ex. : https://download.nomachine.com/download/6.7/Linux/nomachine_6.7.6_11_amd64.deb
ENV	NOMACHINE_PACKAGE_NAME nomachine_6.7.6_11_amd64.deb
ENV	NOMACHINE_BUILD 6.7
ENV	NOMACHINE_MD5 4d94be64f52b4b5d726da7d2610feeaa

RUN	apt-get update -y && \
	apt-get install -y xterm pulseaudio cups libgconf2-4 iputils-ping libnss3 libxss1 xdg-utils libpango1.0-0 fonts-liberation mate-desktop-environment-extras && \
	curl -fSL "http://download.nomachine.com/download/${NOMACHINE_BUILD}/Linux/${NOMACHINE_PACKAGE_NAME}" -o nomachine.deb && \
	echo "${NOMACHINE_MD5} *nomachine.deb" | md5sum -c - && \
	dpkg -i nomachine.deb && \
	rm nomachine.deb && \
	sed -i "s|#EnableClipboard both|EnableClipboard both |g" /usr/NX/etc/server.cfg && \
	apt-clean

ADD	nxserver.sh /
