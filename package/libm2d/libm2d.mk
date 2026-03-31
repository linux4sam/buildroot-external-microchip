################################################################################
#
# libm2d
#
################################################################################

LIBM2D_VERSION = v2.2.0
LIBM2D_SITE = $(call github,linux4sam,libm2d,$(LIBM2D_VERSION))
LIBM2D_LICENSE = MIT
LIBM2D_LICENSE_FILES = COPYING
LIBM2D_DEPENDENCIES = host-pkgconf
LIBM2D_INSTALL_STAGING = YES

ifeq ($(BR2_MCHP_SAM_GC520UL_NANO2D),y)
LIBM2D_CONF_OPTS += -DGPU=vivante,gc-nano2d
LIBM2D_DEPENDENCIES += nano2d
else ifeq ($(BR2_MCHP_SAM_GC520UL_ETNAVIV),y)
LIBM2D_CONF_OPTS += -DGPU=vivante,gc-etnaviv
LIBM2D_DEPENDENCIES += libdrm
else ifeq ($(BR2_MCHP_SAM_SAM9X7_GFX2D),y)
LIBM2D_CONF_OPTS += -DGPU=microchip,sam9x7-gfx2d
LIBM2D_DEPENDENCIES += libdrm
else
LIBM2D_CONF_OPTS += -DGPU=microchip,sam9x60-gfx2d
LIBM2D_DEPENDENCIES += libdrm
endif

ifeq ($(BR2_PACKAGE_LIBM2D_TESTS),y)
LIBM2D_CONF_OPTS += -DENABLE_TESTS=ON
else
LIBM2D_CONF_OPTS += -DENABLE_TESTS=OFF
endif

$(eval $(cmake-package))
