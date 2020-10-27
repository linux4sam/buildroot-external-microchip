#!/bin/sh
echo " ######  #       #######         "
echo " #     # #       #               "
echo " #     # #       #               "
echo " ######  #       #####           "
echo " #     # #       #               "
echo " #     # #       #               "
echo " ######  ####### #######         "
echo " ######  ####### #     # ####### "
echo " #     # #       ##   ## #     # "
echo " #     # #       # # # # #     # "
echo " #     # #####   #  #  # #     # "
echo " #     # #       #     # #     # "
echo " #     # #       #     # #     # "
echo " ######  ####### #     # ####### "
echo "---------------------------------------------------"
echo "---------------------------------------------------"                                 

echo "1.############## Checking the mode of Interface ##############"
if ifconfig | grep -q "wlan0"; then
	if ifconfig | grep -q "mon.wlan0"; then
        	echo "Device is not in STA mode.Place DUT in STA mode"
        	exit 0
	fi
else
	modprobe wilc-sdio
fi

echo "2.############## Initializing Bluetooth on WILC module ##############"
echo BT_POWER_UP > /dev/wilc_bt
sleep 1
echo BT_DOWNLOAD_FW > /dev/wilc_bt
sleep 1

echo "3.############## Attaching the Bluetooth Device ##############"
hciattach ttyS1 any 115200 noflow
sleep 2
if hciconfig | grep -q hci0; then
	echo "Succssfully attached WILC Bluetooth interface"
else
	echo "Failed to attach the WILC Bluetooth interface"
	exit 0;
fi
ln -svf /usr/libexec/bluetooth/bluetoothd /usr/sbin
echo "4.############## Initializing the Bluetooth Deamon ##############"
killall bluetoothd
bluetoothd -n &
sleep 2
if ps | grep -q "bluetoothd"; then
	echo "Successfully started the Bluetooth Deamon" 
else
	echo "Failed to start the Bluetooth Deamon"
fi

echo "5.############## Bringing Up the HCI interface ##############"
hciconfig hci0 up
sleep 1

if hciconfig | grep -q "RUNNING"; then
	echo "WILC Bluetooth interface is Up and Running"
else
	echo "WILC Bluetooth interface failed"
	exit 0
fi
hciconfig

if [ $1 -eq 3 ]
then
        hcitool -i hci0 cmd 0x08 0x0008 15 02 01 06 11 07 1b c5 d5 a5 02 00 89 86 e4 11 29 d2 01 00 88 77
fi

echo "6.############## Starting Bluetooth Low Energy Advertisement ##############"
hciconfig hci0 leadv &
sleep 2

cd /usr/bin
if [ $1 -eq 1 ]
then
        echo "7.############## Heart rate application started ##############"
	./btgatt-server -i hci0 -s low -t public -r -v 
elif [ $1 -eq 2 ]
then
        echo "7.############## Transparent service application started ##############"
        ./transparent_service -i hci0 -s low -t public -r -m 512
elif [ $1 -eq 3 ]
then
        echo "7.############## WiFi provisioning service application started ##############"
	./wifi_prov_service -i hci0 -s low -t public -r -m 512
	echo "8.############## Trying to connect to the configured AP ##############"
	cd -
	./Start_STA.sh
else
        echo "select correct option: 1- heart rate service, 2-transparent service and 3-Wifi provision service"
fi
echo "---------------------------------------------------"
echo "---------------------------------------------------"
