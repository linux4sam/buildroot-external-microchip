################################################################################
#
# WILC3000 BLE uart break ioctl utility for PS
#
################################################################################

UART_BRK_IOCTL_VERSION = 1.0
UART_BRK_IOCTL_SITE = $(call github,linux4wilc,uart_brk_ioctl,$(UART_BRK_IOCTL_VERSION))
UART_BRK_LICENSE = GPL-2.0
UART_BRK_LICENSE_FILES = LICENSE

define UART_BRK_IOCTL_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) -Wall -std=gnu11 -g -D_REENTRANT -static $(@D)/uart_brk_ioctl.c -o $(@D)/uart_brk_ioctl
endef

define UART_BRK_IOCTL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/uart_brk_ioctl \
		$(TARGET_DIR)/etc/
endef

$(eval $(generic-package))
