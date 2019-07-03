################################################################################
#
# wildwest
#
################################################################################

WILDWEST_VERSION = 69114abeb72380cdec8b7f7e80b94ac0dd77036e
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
endef

$(eval $(generic-package))
