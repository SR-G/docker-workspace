#!/bin/bash

xpl-hub       -i ${MQTT_INTERFACE} --define broadcast=0.0.0.0 -v &
# xpl-logger  -i ${MQTT_INTERFACE} --define broadcast=0.0.0.0 -v &
xpl-rfxcom-rx -i ${MQTT_INTERFACE} --define broadcast=255.255.255.255 -v --rfxcom-rx-verbose --rfxcom-rx-baud 9600 --rfxcom-rx-tty ${RFXCOM_HOSTNAME}:${RFXCOM_PORT} &
perl /opt/xpl-to-mqtt.pl
