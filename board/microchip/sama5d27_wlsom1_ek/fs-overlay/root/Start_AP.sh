#!/bin/sh
echo "---------------------------------------------------"
echo " #     #                                           "  
echo " #  #  # ###### #       ####   ####  #    # ###### " 
echo " #  #  # #      #      #    # #    # ##  ## #      "
echo " #  #  # #####  #      #      #    # # ## # #####  "
echo " #  #  # #      #      #      #    # #    # #      "
echo " #  #  # #      #      #    # #    # #    # #      "
echo "  ## ##  ###### ######  ####   ####  #    # ###### "
echo "---------------------------------------------------"
echo "    #    ######     ######                         "                         
echo "   # #   #     #    #     # ###### #    #  ####    "
echo "  #   #  #     #    #     # #      ##  ## #    #   "
echo " #     # ######     #     # #####  # ## # #    #   "
echo " ####### #          #     # #      #    # #    #   "
echo " #     # #          #     # #      #    # #    #   "
echo " #     # #          ######  ###### #    #  ####    "
echo "---------------------------------------------------"
  
if lsmod | grep -q "wilc_sdio" ; then
        echo "1.############## WILC-SDIO module is available ##############"
else
        echo "1. Inserting the wilc-sdio module" 
        modprobe wilc-sdio
	if lsmod | grep -q "wilc_sdio";  then
                echo "WILC-SDIO module insterted successfully"
        else
                echo "WILC-SDIO module insert failed"
		exit 0
        fi  
fi  
echo "2.############## Bringing up the wlan0 interface ##############" 
networkctl up wlan0
if ifconfig | grep -q "wlan0" ; then
        echo "Wireless LAN interface is UP!"
else
        echo "Wireless LAN interface has FAILED"
	exit 0
fi
  
cp /usr/lib/systemd/system/hostapd@.service.example /etc/systemd/system/hostapd@.service
cp /usr/lib/systemd/network/80-wifi-softap.network.example /etc/systemd/network/wlan0.network

echo "2.############# Stopping wpa_supplicant service if any ####"
systemctl stop wpa_supplicant.service
echo "3.############# Restarting systemd-networkd service #######"
systemctl restart systemd-networkd.service
echo "4.############## Starting the Host AP deamon ##############" 
systemctl start hostapd@open.service

if ps | grep -q "hostapd" ; 
then
	echo "hostapd process has started successfully"
else
	echo "hostapd has failed to start"
	exit 0
fi
cd /root
./websocket & 
echo "Now, The device comes up as an Access Point(AP) and host a webpage to provision"
echo "WiFi station interface"
echo "\n"
echo "Use a Phone/Laptop and connect to the 'wilc1000_SoftAP' WiFi AP"
echo "Using the web browser open http://192.168.1.1"
echo "---------------------------------------------------"
echo "---------------------------------------------------"
