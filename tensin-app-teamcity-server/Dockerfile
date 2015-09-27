# @see https://github.com/sjoerdmulder/teamcity-docker/blob/master/Dockerfile
FROM	tensin-base-alpine-java-jdk8

WORKDIR	/opt/TeamCity
VOLUME	["/var/lib/teamcity"]
EXPOSE 	8111
CMD	["/opt/TeamCity/bin/teamcity-server.sh", "run"]

ENV	TEAMCITY_DATA_PATH /var/lib/teamcity
ENV	TEAMCITY_VERSION 9.1.3

# Get and install teamcity
RUN	curl http://download-ln.jetbrains.com/teamcity/TeamCity-${TEAMCITY_VERSION}.tar.gz | tar -xz -C /opt

# Enable the correct Valve when running behind a proxy
RUN	sed -i -e "s/\.*<\/Host>.*$/<Valve className=\"org.apache.catalina.valves.RemoteIpValve\" protocolHeader=\"x-forwarded-proto\" \/><\/Host>/" /opt/TeamCity/conf/server.xml
RUN 	mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chown root:ssl-cert -R /etc/ssl/private; chmod -R 0640 /etc/ssl/private; chmod 0750 /etc/ssl/private;
