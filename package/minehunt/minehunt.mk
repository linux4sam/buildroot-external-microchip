################################################################################
#
# minehunt
#
################################################################################

MINEHUNT_VERSION = v1.7
MINEHUNT_SITE = $(call github,linux4sam,minehunt,$(MINEHUNT_VERSION))
MINEHUNT_LICENSE = LGPL-2.1-only, GPL-3.0-only
MINEHUNT_DEPENDENCIES = qt5base qt5quick1d

define MINEHUNT_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define MINEHUNT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define MINEHUNT_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
