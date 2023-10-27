cp /usr/lib/systemd/system/hostapd@.service.example /etc/systemd/system/hostapd@.service
cp /usr/lib/systemd/network/80-wifi-softap.network.example /etc/systemd/network/wlan0.network
systemctl add-wants multi-user.target hostapd@open.service
networkctl down wlan0
reboot

