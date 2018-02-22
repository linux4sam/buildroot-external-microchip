################################################################################
#
# vision
#
################################################################################

VISION_VERSION = 45462e942ec27aaa2a5b6ee5502b880a7907bc8f
VISION_SITE = $(call github,linux4sam,vision,$(VISION_VERSION))
VISION_LICENSE = GPL-3.0-only
VISION_LICENSE_FILES = COPYING
VISION_DEPENDENCIES = python-pyqt5 opencv3

define VISION_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/vision
        $(INSTALL) -m 0755 -D $(@D)/detect.py \
                $(TARGET_DIR)/opt/vision/detect.py
        $(INSTALL) -m 0644 -D $(@D)/res/vision.png \
                $(TARGET_DIR)/opt/ApplicationLauncher/applications/resources/vision.png
        $(INSTALL) -m 0644 -D $(@D)/res/09-vision.xml \
                $(TARGET_DIR)/opt/ApplicationLauncher/applications/xml/09-vision.xml
        $(INSTALL) -m 0755 -D $(@D)/res/vision.sh \
                $(TARGET_DIR)/opt/vision/vision.sh
endef

$(eval $(generic-package))
