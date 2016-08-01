FROM	tensin-base-alpine-python3

EXPOSE	5000
WORKDIR	/opt/borgweb/
CMD	["/usr/bin/borgweb"]

RUN	apk --update add git && \
	cd /opt/borgweb/ && \
	git clone https://github.com/borgbackup/borgweb.git . && \
	pip3 install -e . && \
	mkdir -p logs/ repo/
VOLUME	["/opt/borgweb/repo", "/opt/borgweb/logs"]
