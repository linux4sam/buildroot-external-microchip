################################################################################
#
# wireless_firmware
#
################################################################################

WILC_FIRMWARE_VERSION = wilc_linux_15_6
WILC_FIRMWARE_SITE = $(call github,linux4wilc,firmware,$(WILC_FIRMWARE_VERSION))
WILC_FIRMWARE_LICENSE = Microchip firmware
WILC_FIRMWARE_LICENSE_FILES = LICENSE.wilc_fw

define WILC_FIRMWARE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware/mchp
	$(INSTALL) -D -m 0644 $(@D)/* $(TARGET_DIR)/lib/firmware/mchp

	rm -f ${TARGET_DIR}/lib/firmware/mchp/README.md
	rm -rf ${TARGET_DIR}/lib/firmware/mchp/LICENCE.wilc_fw
	chmod -x ${TARGET_DIR}/lib/firmware/mchp/*
endef

$(eval $(generic-package))
