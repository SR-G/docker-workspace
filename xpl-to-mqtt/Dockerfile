FROM    scottw/alpine-perl

ENV     XPL_HOSTNAME "xpl2mqtt"
ENV     MQTT_INTERFACE eth0
ENV     MQTT_HOSTNAME 192.168.8.4
ENV     MQTT_PORT 1883
ENV     RFXCOM_HOSTNAME 192.168.8.13
ENV     RFXCOM_PORT 10001

ADD     start.sh /opt/
ADD     xpl-to-mqtt.pl /opt/

CMD     /opt/start.sh

RUN     apk update && apk add git curl tar bash make perl && \
        cd /opt && \
        git clone https://github.com/beanz/xpl-perl && \
        cd xpl-perl && cpan install YAML::Syck AnyEvent Date::Parse Module::Pluggable Sub::Name AnyEvent::RFXCOM::RX  AnyEvent::MQTT && \
        perl Makefile.PL && make && make install && \
        chmod a+x /opt/*.sh

WORKDIR	/opt/
