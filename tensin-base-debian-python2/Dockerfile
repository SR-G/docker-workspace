FROM	tensin-base-debian

RUN	apt-get update && apt-get install -y curl python2 && apt-clean && \
	curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && \
	python2 get-pip.py
