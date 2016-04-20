FROM    centos

VOLUME	["/data/"]
WORKDIR	/data/
CMD	/usr/bin/seafile start -c /root/.ccnet && tail -f /var/log/yum.log

ENV	SEAFILE_CLI_PACKAGE	x86-64
ENV	SEAFILE_CLI_VERSION	4.3.2

RUN	yum install -y which python ca-certificates curl zsh && \
	mkdir -p /root/.seafile-client && \
	curl -skSL https://bintray.com/artifact/download/seafile-org/seafile/seafile-cli_${SEAFILE_CLI_VERSION}_${SEAFILE_CLI_PACKAGE}.tar.gz | tar xzf - -C /opt/ && \
	mv /opt/seafile-cli-${SEAFILE_CLI_VERSION} /opt/seafile-cli/ && \
	ln -s /opt/seafile-cli/seaf-cli /usr/bin/seafile && \
	cd /opt/seafile-cli/ && ./seaf-cli init -d /root/.seafile-client  && rm -f /opt/seafile-cli/*.txt

