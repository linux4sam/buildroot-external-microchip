################################################################################
#
# libm2d
#
################################################################################

LIBM2D_VERSION = 90b2afe9d69e74c211eecf90e742b113935f7441
LIBM2D_SITE = https://bitbucket.microchip.com/scm/~c16205/libm2d.git
LIBM2D_SITE_METHOD = git
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
