################################################################################
#
# videoplayer
#
################################################################################

VIDEOPLAYER_VERSION = 526ff3a609791aacfd4eeeb386831cf6e77c5061
VIDEOPLAYER_SITE = $(call github,linux4sam,atmel-video-player,$(VIDEOPLAYER_VERSION))
VIDEOPLAYER_LICENSE = Atmel LIMITED License Agreement
VIDEOPLAYER_LICENSE_FILES = COPYING
VIDEOPLAYER_DEPENDENCIES = qt5base gstreamer1 gst1-at91 libplanes

define VIDEOPLAYER_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define VIDEOPLAYER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define VIDEOPLAYER_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
	$(INSTALL) -D -m 0755 $(@D)/player \
		$(TARGET_DIR)/opt/VideoPlayer/player
	$(INSTALL) -D -m 0755 $(@D)/Player.sh \
		$(TARGET_DIR)/opt/VideoPlayer/Player.sh
	$(INSTALL) -D -m 0664 $(@D)/media/Microchip-masters.mp4 \
		$(TARGET_DIR)/opt/VideoPlayer/media/Microchip-masters.mp4
endef

$(eval $(generic-package))
