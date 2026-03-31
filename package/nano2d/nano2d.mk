################################################################################
#
# nano2d
#
################################################################################

NANO2D_VERSION = 2.0.41
NANO2D_SITE = $(call github,linux4sam,nano2d,$(NANO2D_VERSION))
NANO2D_LICENSE = MIT
NANO2D_LICENSE_FILES = LICENSE.txt
NANO2D_DEPENDENCIES = host-pkgconf
NANO2D_INSTALL_STAGING = YES

NANO2D_MODULE_SUBDIRS = drv/nano2Dkernel

define NANO2D_AUTOLOAD_MODULE
$(INSTALL) -D -m 0644 $(BR2_EXTERNAL)/package/nano2d/nano2d.conf \
$(TARGET_DIR)/usr/lib/modules-load.d/nano2d.conf
endef

NANO2D_POST_INSTALL_TARGET_HOOKS += NANO2D_AUTOLOAD_MODULE

$(eval $(kernel-module))
$(eval $(cmake-package))
