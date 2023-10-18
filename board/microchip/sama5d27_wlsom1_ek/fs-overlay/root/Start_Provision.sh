systemctl add-wants multi-user.target hostapd@open.service
networkctl down wlan0
reboot

