FROM    tensin-base-debian-python2

WORKDIR	/data/
CMD	/usr/bin/seafile start -c /root/.ccnet && tail -F /etc/hostname

RUN	apt-get update && apt-get install -y zsh seafile-cli && \
	apt-get remove -y gnupg software-properties-common && \
	apt-clean && \
	mkdir -p /root/.seafile-client && \
	ln -s /usr/bin/seaf-cli /usr/bin/seafile && \
	/usr/bin/seaf-cli init -d /root/.seafile-client  
