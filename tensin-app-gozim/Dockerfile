FROM	tensin-base-supervisor

# Install Gitblit
RUN	apt-get install -y libleveldb-dev
RUN	curl -Lks https://github.com/akhenakh/gozim/releases/download/v1.0/gozim-1.0-amd64-linux.tar.gz -o /root/gozim.tar.gz
RUN	mkdir -p /opt/gozim
RUN	tar zxf /root/gozim.tar.gz -C /opt/gozim
RUN	rm -f /root/gozim.tar.gz

# Setup the Docker container environment and push Gitblit supervisor configuration
WORKDIR	/opt/gozim
EXPOSE	8080
VOLUME	["/zim"]
ADD	gozim.sv.conf /etc/supervisor/conf.d/
ADD	index.sh /opt/gozim/
