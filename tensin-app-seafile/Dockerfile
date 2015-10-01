FROM		tensin-base-ubuntu-supervisor
# Interface the environment
RUN 		mkdir /opt/seafile
VOLUME 		["/opt/seafile"]
EXPOSE		10001 12001 8000 8080 8082

# Seafile dependencies and system configuration
# socat : Workaround for https://github.com/haiwen/seafile/issues/478
RUN		apt-get install -y python2.7 python-setuptools python-simplejson python-imaging sqlite3 python-mysqldb python-memcache socat

# Seafile daemons
ADD		seafile.sv.conf /etc/supervisor/conf.d/
ADD		seahub.sv.conf /etc/supervisor/conf.d/
ADD		download-seafile.sh /usr/local/sbin/download-seafile

# Clean up for smaller image
RUN		apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
