import sys
import os
import paho.mqtt.client as mqtt

from miflora.miflora_poller import MiFloraPoller, \
MI_CONDUCTIVITY, MI_MOISTURE, MI_LIGHT, MI_TEMPERATURE, MI_BATTERY

mqtt_ip = os.environ['MQTT_IP']
mqtt_port = 1883
mqtt_username = os.environ['MQTT_USERNAME']
mqtt_password = os.environ['MQTT_PASSWORD']
miplant_label = os.environ['MIPLANT_LABEL']
miplant_mac = os.environ['MIPLANT_MAC']
miplant_topic = os.environ['MIPLANT_TOPIC']

poller = MiFloraPoller(miplant_mac)
print("Getting data from Mi Flora")
print("FW: {}".format(poller.firmware_version()))
print("Name: {}".format(poller.name()))
print("Temperature: {}".format(poller.parameter_value("temperature")))
print("Moisture: {}".format(poller.parameter_value(MI_MOISTURE)))
print("Light: {}".format(poller.parameter_value(MI_LIGHT)))
print("Conductivity: {}".format(poller.parameter_value(MI_CONDUCTIVITY)))
print("Battery: {}".format(poller.parameter_value(MI_BATTERY)))

# Publishing the results to MQTT
mqttc = mqtt.Client(miplant_label)
# mqttc.username_pw_set(mqtt_username,mqtt_password)
mqttc.connect(mqtt_ip, mqtt_port)
mqttc.publish(miplant_topic, "{ \"battery\" : " + str(poller.parameter_value(MI_BATTERY)) + ", \"version\" : \"" + str(poller.firmware_version()) + "\", \"sunlight\" : " + str(poller.parameter_value(MI_LIGHT)) + ", \"temperature\" : " + str(poller.parameter_value("temperature")) + ", \"moisture\" : " + str(poller.parameter_value(MI_MOISTURE)) + ", \"fertility\" : " + str(poller.parameter_value(MI_CONDUCTIVITY)) + " }")
mqttc.loop(2)
# End of MQTT section
