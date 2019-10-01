################################################################################
#
# homeautomation
#
################################################################################

HOMEAUTOMATION_VERSION = ebb179cd3787a572c3423880768ed6d056f61b2a
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
endef

$(eval $(generic-package))
