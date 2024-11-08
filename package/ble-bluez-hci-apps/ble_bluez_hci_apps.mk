################################################################################
#
# bluez ble sw apps: ble-uart-bluez and dfu-bluez
#
################################################################################

BLE_BLUEZ_HCI_APPS_SITE = https://github.com/linux4microchip/ble_bluez_hci_apps.git
BLE_BLUEZ_HCI_APPS_VERSION = 27aee9b024985366ea0c9e2a77ce02113cc46252
BLE_BLUEZ_HCI_APPS_SITE_METHOD = git
BLE_BLUEZ_HCI_APPS_LICENSE = Microchip firmware

BLE_BLUEZ_HCI_APPS_DEPENDENCIES = bluez5_utils bluez5_utils-headers

define BLE_BLUEZ_HCI_APPS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/apps/ble_uart_app/ble-uart-bluez $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/apps/dfu_app/dfu-bluez $(TARGET_DIR)/usr/bin/
endef

$(eval $(cmake-package))
