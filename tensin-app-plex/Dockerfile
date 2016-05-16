FROM	tensin-base-ubuntu

VOLUME	["/config", "/data"]
CMD	["/usr/sbin/start_pms"]
WORKDIR	/config
ENV	HOME /config

EXPOSE	32400

ADD	https://raw.githubusercontent.com/mrworf/plexupdate/master/plexupdate.sh /plexupdate.sh
# RUN	curl -sLo /plexupdate.sh https://raw.githubusercontent.com/mrworf/plexupdate/master/plexupdate.sh
RUN	sed -i 's/sudo //g' /plexupdate.sh && chmod a+x /plexupdate.sh && /plexupdate.sh -a -p -f -U
