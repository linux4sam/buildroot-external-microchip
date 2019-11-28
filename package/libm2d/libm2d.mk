################################################################################
#
# libm2d
#
################################################################################

LIBM2D_VERSION = sam9x60_2.0
LIBM2D_SOURCE = libm2d-$(LIBM2D_VERSION).tar.gz
LIBM2D_SITE = https://files.linux4sam.org/pub/src
LIBM2D_STRIP_COMPONENTS = 0
LIBM2D_LICENSE = MIT
LIBM2D_LICENSE_FILES = COPYING
LIBM2D_AUTORECONF = YES
LIBM2D_AUTORECONF_OPTS += -I $(HOST_DIR)/usr/share/autoconf-archive
LIBM2D_DEPENDENCIES = libdrm \
	host-pkgconf host-autoconf-archive
LIBM2D_INSTALL_STAGING = YES

LIBM2D_CONF_OPTS = \
	--disable-cairo

define LIBM2D_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
LIBM2D_POST_PATCH_HOOKS += LIBM2D_RUN_AUTOGEN

$(eval $(autotools-package))
