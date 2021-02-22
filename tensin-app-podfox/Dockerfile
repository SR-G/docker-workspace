FROM	tensin-base-debian-python3

ENTRYPOINT	["podfox", "--config=/data/podfox.json"]

VOLUME	["/podcasts/","/data/"]
WORKDIR /podcasts

RUN	cd /opt/ && \
	apt-get update -y && apt-get install -y git && \
	git clone https://github.com/brtmr/podfox && \
	cd podfox && \
	pip3 install feedparser requests colorama && pip3 install -e .
