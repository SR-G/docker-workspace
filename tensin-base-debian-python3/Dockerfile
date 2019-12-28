FROM	tensin-base-debian

RUN	apt-get update && apt-get install -y curl python3 && apt-clean && \
	curl -sL https://bootstrap.pypa.io/get-pip.py | python3 && \
	ln -s /usr/bin/python3 /usr/bin/python
