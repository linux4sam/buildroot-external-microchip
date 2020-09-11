#!/bin/sh
result=`grep "Start_STA" /etc/init.d/S85start_wlan`
res_len=${#result}
if [ $res_len -eq 0 ]
then
        echo "Device is not in STA mode.Place DUT in STA mode"
        exit 0
fi
echo BT_POWER_UP > /dev/wilc_bt
sleep 1
echo BT_DOWNLOAD_FW > /dev/wilc_bt
sleep 1
hciattach ttyS1 any 115200 noflow
sleep 2
ln -svf /usr/libexec/bluetooth/bluetoothd /usr/sbin
bluetoothd -n &
sleep 2
hciconfig hci0 up
sleep 1
hciconfig
if [ $1 -eq 3 ]
then
        hcitool -i hci0 cmd 0x08 0x0008 15 02 01 06 11 07 1b c5 d5 a5 02 00 89 86 e4 11 29 d2 01 00 88 77
fi
hciconfig hci0 leadv &
sleep 2
cd /usr/sbin
if [ $1 -eq 1 ]
then
        echo "Heart rate application started"
        cd /usr/bin
	./btgatt-server -i hci0 -s low -t public -r -v
elif [ $1 -eq 2 ]
then
        echo "transparent service application started"
        ./transparent_service -i hci0 -s low -t public -r
elif [ $1 -eq 3 ]
then
        echo "WiFi provisioning service application started"
                ./wifi_prov_service -i hci0 -s low -t public -r
else
        echo "select correct option: 1- heart rate service, 2-transparent service and 3-Wifi provision service"
fi
