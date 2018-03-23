################################################################################
#
# homeautomation
#
################################################################################

HOMEAUTOMATION_VERSION = fc7a4a910799d771ac27706088c7f4c294c580c3
HOMEAUTOMATION_SITE = $(call github,linux4sam,home-automation,$(HOMEAUTOMATION_VERSION))
HOMEAUTOMATION_LICENSE = Atmel LIMITED License Agreement
HOMEAUTOMATION_DEPENDENCIES = qt5base qt5webkit qt5quick1d libv4l

define HOMEAUTOMATION_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define HOMEAUTOMATION_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOMEAUTOMATION_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
	$(INSTALL) -m 0755 $(@D)/HomeAutomation $(TARGET_DIR)/opt/HomeAutomation/
endef

$(eval $(generic-package))
