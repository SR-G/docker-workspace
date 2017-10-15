FROM	tensin-base-alpine-python3

VOLUME	["/podcasts/","/data/"]
WORKDIR /podcasts

RUN	mkdir /opt/  && \
	cd /opt/ && \
	apk --update add git && \
	git clone https://github.com/brtmr/podfox && \
	cd podfox && \
	pip3 install feedparser requests colorama && pip3 install -e .

ENTRYPOINT	["podfox", "--config=/data/podfox.json"]
