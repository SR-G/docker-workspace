FROM	tensin-base-ubuntu-supervisor

VOLUME	["/config", "/data"]
CMD	["/usr/sbin/start_pms"]

EXPOSE	32400

RUN	curl -sLo /plexupdate.sh https://raw.githubusercontent.com/mrworf/plexupdate/master/plexupdate.sh
RUN	chmod a+x /plexupdate.sh && /plexupdate.sh -a -p -f -U
