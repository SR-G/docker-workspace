FROM	tensin-base-ubuntu

EXPOSE	4000/tcp 4080/tcp
VOLUME	["/datas/temp", "/datas/shared", "/datas/incoming"]

WORKDIR	/datas/
CMD	["/start.sh"]

ADD	start.sh /start.sh

RUN	echo "mldonkey-server   mldonkey-server/launch_at_startup   boolean false" | debconf-set-selections && \
	apt-get update && \
	apt-get install -y mldonkey-server telnet && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /datas/shared /root/.mldonkey/ 
