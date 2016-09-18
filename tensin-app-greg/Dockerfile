FROM	tensin-base-alpine-python3

VOLUME	["/podcasts/"]
WORKDIR /podcasts

RUN	mkdir /opt/  && \
	cd /opt/ && \
	apk --update add git && \
	git clone https://github.com/manolomartinez/greg && \
	cd greg && \
	pip3 install stagger && pip3 install -e .

ENTRYPOINT	["greg", "--configfile", "/etc/greg.conf"]
