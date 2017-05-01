FROM	jrottenberg/ffmpeg:3.3

VOLUME	["/data"]
WORKDIR	/data

CMD	/bin/bash
ENTRYPOINT []

RUN	apt-get update && apt-get -y install bash imagemagick curl git python3 python3-setuptools zlib1g-dev zlib1g libjpeg-dev gcc vim build-essential python3-pip python3-dev python3-pilkit python3-numpy python3-jinja2 && \
	git clone https://github.com/amietn/vcsi /opt/vcsi && \
	cd /opt/vcsi && \
 	pip3 install -r requirements.txt && \
	python3 setup.py install

