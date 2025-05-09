################################################################################
#
# libm2d
#
################################################################################

LIBM2D_VERSION = v2.0.0
LIBM2D_SITE = $(call github,linux4sam,libm2d,$(LIBM2D_VERSION))
LIBM2D_LICENSE = MIT
LIBM2D_LICENSE_FILES = COPYING
LIBM2D_DEPENDENCIES = libdrm host-pkgconf
LIBM2D_INSTALL_STAGING = YES

$(eval $(cmake-package))
