#!/bin/bash
ifconfig wlan0 up
hostapd /etc/wilc_hostapd_open.conf -B &
ifconfig wlan0 192.168.0.1
/etc/init.d/S80dhcp-server start &
cd /root
./websocket &

