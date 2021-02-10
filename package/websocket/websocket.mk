################################################################################
#
# web-socket
#
################################################################################

WEBSOCKET_VERSION = linux4sam-2020.04
WEBSOCKET_SITE = $(call github,MicrochipTech,websocket-buildroot-external-microchip,$(WEBSOCKET_VERSION))

define WEBSOCKET_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) -Wall -std=gnu11 -g -D_REENTRANT -static $(@D)/websocket_control.c $(@D)/websocket_protocol.c -o $(@D)/websocket
endef

define WEBSOCKET_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0777 $(@D)/websocket \
		$(TARGET_DIR)/root/
endef

$(eval $(generic-package))
