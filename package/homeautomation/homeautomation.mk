################################################################################
#
# homeautomation
#
################################################################################

HOMEAUTOMATION_VERSION = 7e3f384de01fb2ad3a7b8b6a05acb0d8d68e9508
HOMEAUTOMATION_SITE = $(call github,linux4sam,home-automation,$(HOMEAUTOMATION_VERSION))
HOMEAUTOMATION_LICENSE = Atmel LIMITED License Agreement
HOMEAUTOMATION_DEPENDENCIES = qt5base libv4l

define HOMEAUTOMATION_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define HOMEAUTOMATION_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOMEAUTOMATION_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
	$(INSTALL) -m 0755 $(@D)/HomeAutomation $(TARGET_DIR)/opt/HomeAutomation/
	$(INSTALL) -D -m 0664 $(@D)/configs/home-automation.png \
		$(TARGET_DIR)/opt/applications/resources/home-automation.png
	 $(INSTALL) -m 0755 -D $(@D)/configs/01-home-automation.xml \
		$(TARGET_DIR)/opt/applications/resources/01-home-automation.xml

endef

$(eval $(generic-package))
