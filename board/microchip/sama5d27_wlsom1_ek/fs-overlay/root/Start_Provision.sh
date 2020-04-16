#!/bin/sh
cat << 'EOT' > /etc/init.d/S85start_wlan 
#!/bin/sh
case "$1" in
        start)
		modprobe wilc-sdio
                sh /root/Start_AP.sh
                ;;
        stop)
                ifconfig wlan0 down
		modprobe -r wilc-sdio
                ;;
esac
exit 0
EOT
chmod 0755 /etc/init.d/S85start_wlan
ifconfig wlan0 down
reboot

