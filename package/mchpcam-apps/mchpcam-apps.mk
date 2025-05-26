################################################################################
#
# mchpcam-apps
#
################################################################################
MCHPCAM_APPS_VERSION = linux4microchip-2025.04
MCHPCAM_APPS_SITE = $(call github,linux4microchip,libcamera-mchp,$(MCHPCAM_APPS_VERSION))
MCHPCAM_APPS_LICENSE = \
    GPL-2.0+ (utils), \
    CC0-1.0 (meson build system)
MCHPCAM_APPS_LICENSE_FILES = \
    LICENSES/GPL-2.0-or-later.txt \
    LICENSES/GPL-2.0-only.txt \
    LICENSES/CC0-1.0.txt
MCHPCAM_APPS_DEPENDENCIES = libcamera-mchp
MCHPCAM_APPS_CONF_OPTS = \
	-Dpipelines=microchip-isc \
	-Dv4l2=false \
	-Ddocumentation=disabled \
	-Dgstreamer=disabled \
	-Dpycamera=disabled \
	-Dmchpcam=enabled

define MCHPCAM_APPS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/build/src/apps/mchpcam/mchpcam-still \
		$(TARGET_DIR)/usr/bin/mchpcam-still
endef

$(eval $(meson-package))

