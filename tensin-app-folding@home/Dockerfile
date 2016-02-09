FROM	tensin-base-ubuntu

# If you set USERNAME to Anonymous, the folding@home client pauses for 5 minutes, but will then begin processing data.
ENV	USERNAME Anonymous
ENV	TEAM 0
ENV	POWER medium

RUN	apt-get update && apt-get -y upgrade && apt-get clean all && \
	apt-get -y install curl && \
	curl -sLo /tmp/fahclient.deb https://folding.stanford.edu/releases/public/release/fahclient/debian-testing-64bit/v7.4/fahclient_7.4.4_amd64.deb && \
	dpkg -i /tmp/fahclient.deb

# ADD	config.xml /etc/fahclient/
# RUN	chown fahclient:root /etc/fahclient/config.xml && \
#	sed -i -e "s/{{USERNAME}}/$USERNAME/;s/{{TEAM}}/$TEAM/;s/{{POWER}}/$POWER/" /etc/fahclient/config.xml

CMD	/etc/init.d/FAHClient start && tail -F /var/lib/fahclient/log.txt

VOLUME	["/etc/fahclient/"]
