#!/bin/sh

btmgmt le on 
btmgmt bredr off
hciconfig hci0 down
hciconfig hci0 up
service bluetooth restart
