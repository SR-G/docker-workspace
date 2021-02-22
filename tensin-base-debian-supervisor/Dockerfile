FROM	tensin-base-debian

# supervisor installation && 
# create directory for child images to store configuration in
RUN	apt-get update && apt-get -y install supervisor && \
	mkdir -p /var/log/supervisor/ && \
	mkdir -p /etc/supervisor/conf.d/

# supervisor base configuration
ADD	supervisor.conf /etc/supervisor.conf

# default command
CMD	["supervisord", "-c", "/etc/supervisor.conf"]
