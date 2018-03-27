################################################################################
#
# samegame
#
################################################################################

SAMEGAME_VERSION = v1.6
SAMEGAME_SITE = $(call github,linux4sam,samegame,$(SAMEGAME_VERSION))
SAMEGAME_LICENSE = BSD-3-Clause
SAMEGAME_DEPENDENCIES = qt5base qt5quick1d qt5declarative

define SAMEGAME_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define SAMEGAME_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define SAMEGAME_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
