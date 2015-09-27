FROM	tensin-base-alpine-java-jdk8

# Setup the Docker container environment and push Gitblit supervisor configuration
WORKDIR	/opt/gitblit
EXPOSE	80 443 9418 29418
VOLUME	["/opt/gitblit-data"]
VOLUME	["/var/log"]

# Install Gitblit
RUN	curl -Lks http://dl.bintray.com/gitblit/releases/gitblit-1.6.2.tar.gz -o /root/gitblit.tar.gz
RUN	mkdir -p /opt/gitblit
RUN	tar zxf /root/gitblit.tar.gz -C /opt/gitblit
RUN	rm -f /root/gitblit.tar.gz

CMD	["java", "-server", "-Xmx1024M", "-Djava.awt.headless=true", "-jar", "/opt/gitblit/gitblit.jar", "--baseFolder", "/opt/gitblit-data"]
