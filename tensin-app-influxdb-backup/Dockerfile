FROM	influxdb

WORKDIR	/data/
CMD 	/usr/bin/backup.sh
ENV	BACKUP_DEST /data/ 
ENV	INFLUXDB_HOST influxdb
ENV	DATABASES openhab_db:telegraf

ADD	backup.sh /usr/bin/backup.sh
RUN	chmod a+x /usr/bin/backup.sh
