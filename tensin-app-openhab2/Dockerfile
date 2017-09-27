FROM	tensin-base-alpine-java-jdk8

# restore-addons will create links for extra addons from a /conf/openhab-bootstrap-config file
WORKDIR	/opt/openhab/
CMD	/opt/openhab/bootstrap.sh restore-addons && /opt/openhab/start.sh
EXPOSE	8081 8444
ENV	OPENHAB_HTTP_PORT 8081
ENV	OPENHAB_HTTPS_PORT 8444
ENV	SIGAR_VERSION 1.6.4
ENV	HABMIN_VERSION 2.1.0
ENV	OPENHAB1_VERSION 1.8.3
ENV	OPENHAB2_VERSION 2.1.0

# Script able to install various parts of the openhab installation
ADD	bootstrap.sh /opt/openhab/

RUN	apk --update add curl unzip eudev && \
	chmod a+x /opt/openhab/bootstrap.sh && \
	cd /opt/openhab/ && \
	./bootstrap.sh install-openhab2 ${OPENHAB2_VERSION} && \
	./bootstrap.sh install-sigar ${SIGAR_VERSION} && \
	./bootstrap.sh install-habmin ${HABMIN_VERSION} && \
	./bootstrap.sh install-openhab1-addons ${OPENHAB1_VERSION}
