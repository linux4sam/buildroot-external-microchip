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
ifconfig wlan0 up
if ifconfig | grep -q "wlan0" ; then
        echo "Wireless LAN interface is UP!"
else
        echo "Wireless LAN interface has FAILED"
	exit 0
fi
  
echo "3.############## Starting the Host AP deamon ##############" 
hostapd /etc/wilc_hostapd_open.conf -B &
if ps | grep -q "hostapd" ; 
then
	echo "hostapd process has started successfully"
else
	echo "hostapd has failed to start"
	exit 0
fi
echo "4.############## Configuring the AP IP Address to 192.168.0.1 ##############"
ifconfig wlan0 192.168.0.1
echo "5.############## Starting the DHCP server ##############"
/etc/init.d/S80dhcp-server restart
echo "6.############## Starting the WEB scoket deamon ##############"
cd /root
./websocket & 
echo "Now, The device comes up as an Access Point(AP) and host a webpage to provision"
echo "WiFi station interface"
echo "\n"
echo "Use a Phone/Laptop and connect to the 'wilc1000_SoftAP' WiFi AP"
echo "Using the web browser open http://192.168.0.1"
echo "---------------------------------------------------"
echo "---------------------------------------------------"
