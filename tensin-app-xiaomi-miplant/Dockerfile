FROM	ubuntu:artful

ENV     DEBIAN_FRONTEND noninteractive
ENV     TIMEZONE Europe/Paris

CMD	python3 /opt/miflora-mqtt-daemon/miflora-mqtt-daemon.py

RUN	apt-get update && apt-get -y upgrade && apt-get -y install bash tzdata locales curl git bluez bluez-tools bluetooth usbutils dbus python3 python3-pip && \
	update-rc.d dbus enable && \
	update-rc.d bluetooth enable && \
	locale-gen fr_FR.UTF-8 && \
        dpkg-reconfigure tzdata locales && \
        echo $TIMEZONE > /etc/timezone && \
        cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	cd /opt/ && git clone https://github.com/ThomDietrich/miflora-mqtt-daemon && \
	cd miflora-mqtt-daemon && pip3 install -r requirements.txt && rm -f *.txt *.dist *.md *.gif LICENCE AUTHORS *.service && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Keep this after packages have been installed
ENV     LANG fr_FR.UTF-8
ENV     LANGUAGE fr_FR.UTF-8
ENV     LC_ALL fr_FR.UTF-8
ENV     HOME /root
ENV     TERM xterm

WORKDIR	/opt/miflora-mqtt-daemon

ADD	config.ini /opt/miflora-mqtt-daemon
ADD	*.sh /opt/miflora-mqtt-daemon
