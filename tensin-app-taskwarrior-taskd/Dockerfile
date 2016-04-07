FROM	tensin-base-ubuntu

VOLUME	["/taskwarrior/data/", "/taskwarrior/keys/"]
CMD	taskd server --data /taskwarrior/data/
WORKDIR	/opt/taskd/

# RUN	apk --update add ca-certificates build-base cmake git gnutls-dev libuuid
RUN	apt-get update && \
	apt-get install -y --no-install-recommends git ca-certificates build-essential cmake gnutls-bin libgnutls28-dev uuid-dev && \
	git clone https://git.tasktools.org/scm/tm/taskd.git /opt/taskd && \
	cd /opt/taskd && \
	git checkout 1.1.0 && \
	cmake . && \
	make && \
	make install && \
	rm -rf /opt/taskd && \
	apt-get remove -y --auto-remove git build-essential cmake && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

