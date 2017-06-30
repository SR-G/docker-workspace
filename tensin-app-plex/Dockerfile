FROM	tensin-base-ubuntu-rclone

VOLUME	["/config"]
CMD	["/usr/sbin/start_pms"]
WORKDIR	/opt/

EXPOSE	32400

RUN	apt-get update && apt-get install -y git && git clone https://github.com/mrworf/plexupdate.git && cd /opt/plexupdate/ && \
	sed -i 's/sudo //g' plexupdate.sh && chmod a+x plexupdate.sh && ./plexupdate.sh -a -p -f -U
