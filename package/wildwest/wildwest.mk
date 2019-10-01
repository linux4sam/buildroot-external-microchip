################################################################################
#
# wildwest
#
################################################################################

WILDWEST_VERSION = 0b1b22e3eb5c819983f3d14696214ebaabf28223
WILDWEST_SITE = $(call github,linux4sam,wildwest,$(WILDWEST_VERSION))
WILDWEST_LICENSE = Apache-2.0
WILDWEST_LICENSE_FILES = COPYING
WILDWEST_DEPENDENCIES = qt5base libplanes

define WILDWEST_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define WILDWEST_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define WILDWEST_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
	$(INSTALL) -D -m 0664 $(@D)/resources/wildwest.png \
		$(TARGET_DIR)/opt/applications/resources/wildwest.png
        $(INSTALL) -m 0755 -D $(@D)/resources/10-wildwest.xml \
                $(TARGET_DIR)/opt/applications/resources/10-wildwest.xml

endef

$(eval $(generic-package))
