FROM    tensin-base-debian-python2

WORKDIR	/data/
CMD	/usr/bin/seafile start -c /root/.ccnet && tail -F /etc/hostname

RUN	apt-get update && apt-get install -y zsh apt-transport-https ca-certificates gnupg software-properties-common && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61 && \
	echo deb http://deb.seadrive.org stretch main | tee /etc/apt/sources.list.d/seafile.list && \
	apt-get update && apt-get install -y seafile-cli && \
	apt-get remove -y gnupg software-properties-common && \
	apt-clean && \
	mkdir -p /root/.seafile-client && \
	ln -s /usr/bin/seaf-cli /usr/bin/seafile && \
	/usr/bin/seaf-cli init -d /root/.seafile-client  
