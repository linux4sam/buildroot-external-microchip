###########################################################
#
# wilcbtapps
#
###########################################################

WILCBTAPPS_VERSION = linux4sam-2022.04-rc1
WILCBTAPPS_SITE = $(call github,MicrochipTech,wilcbtapps-buildroot-external-microchip,$(WILCBTAPPS_VERSION))

WILCBTAPPS_DEPENDENCIES += bluez5_utils

define WILCBTAPPS_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) -Wall -std=gnu11 -g -D_REENTRANT -I$(BLUEZ5_UTILS_DIR)/ \
		-L$(BLUEZ5_UTILS_DIR)/lib/.libs/ -L$(BLUEZ5_UTILS_DIR)/gdbus/.libs/ \
		-L$(BLUEZ5_UTILS_DIR)/src/.libs/ $(@D)/transparent_service.c \
		-o $(@D)/transparent_service \
		-lshared-mainloop -lbluetooth-internal -lgdbus-internal -lc

	$(TARGET_CC) $(TARGET_CFLAGS) -Wall -std=gnu11 -g -D_REENTRANT -I$(BLUEZ5_UTILS_DIR)/ \
		-L$(BLUEZ5_UTILS_DIR)/lib/.libs/ -L$(BLUEZ5_UTILS_DIR)/gdbus/.libs/ \
		-L$(BLUEZ5_UTILS_DIR)/src/.libs/ $(@D)/wifi_prov_service.c \
		-o $(@D)/wifi_prov_service \
		-lshared-mainloop -lbluetooth-internal -lgdbus-internal -lc
endef

define WILCBTAPPS_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/transparent_service \
                $(TARGET_DIR)/usr/bin
        $(INSTALL) -D -m 0755 $(@D)/wifi_prov_service \
                $(TARGET_DIR)/usr/bin
endef


$(eval $(generic-package))
