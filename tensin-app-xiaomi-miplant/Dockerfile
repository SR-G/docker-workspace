FROM	debian:jessie

WORKDIR	/opt/miplant/
RUN	apt-get update && apt-get -y upgrade && apt-get -y install bash curl git bluez bluez-tools bluetooth usbutils dbus python3 python3-pip && \
	update-rc.d dbus enable && \
	update-rc.d bluetooth enable && \
	pip3 install paho-mqtt && \
	git clone https://github.com/open-homeautomation/miflora miflora-src && \
	cd miflora-src && ./build.sh && python3 setup.py build && python3 setup.py install && mv miflora .. && cd .. && rm -rf miflora-src/

ENV	MQTT_IP	192.168.8.4
ENV	MQTT_USERNAME admin
ENV	MQTT_PASSWORD password
ENV	MIPLANT_TOPIC miplant/

ADD	miflora.py /opt/miplant/
CMD	python3 miflora.py
