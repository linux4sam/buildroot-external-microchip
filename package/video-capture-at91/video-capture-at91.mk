################################################################################
#
# video capture at91
#
################################################################################

VIDEO_CAPTURE_AT91_VERSION = dc8796111b4e64e2ca55190ae0118986f25f73ae
VIDEO_CAPTURE_AT91_SITE = $(call github,linux4sam,video-capture-at91,$(VIDEO_CAPTURE_AT91_VERSION))
VIDEO_CAPTURE_AT91_LICENSE = MIT
VIDEO_CAPTURE_AT91_LICENSE_FILES = LICENSES/MIT
VIDEO_CAPTURE_AT91_DEPENDENCIES = fswebcam libv4l

define VIDEO_CAPTURE_AT91_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/root/video-capture-at91
	cp -r $(@D)/$(BR2_PACKAGE_VIDEO_CAPTURE_AT91_PLATFORM)/* \
			$(TARGET_DIR)/root/video-capture-at91/
	cp -r $(@D)/utils.sh \
			$(TARGET_DIR)/root/
endef

$(eval $(generic-package))
