FROM	tensin-base-debian-python3

CMD	python3 /opt/miflora-mqtt-daemon/miflora-mqtt-daemon.py

RUN	apt-get update && apt-get -y upgrade && apt-get -y install curl git bluez bluez-tools bluetooth usbutils dbus && \
	update-rc.d dbus enable && \
	update-rc.d bluetooth enable && \
	cd /opt/ && git clone https://github.com/ThomDietrich/miflora-mqtt-daemon && \
	cd miflora-mqtt-daemon && pip3 install -r requirements.txt && rm -f *.txt *.dist *.md *.gif LICENCE AUTHORS *.service && \
	apt-clean

WORKDIR	/opt/miflora-mqtt-daemon

ADD	config.ini /opt/miflora-mqtt-daemon/
ADD	*.sh /opt/miflora-mqtt-daemon/
