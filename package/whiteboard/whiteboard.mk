################################################################################
#
# whiteboard
#
################################################################################

WHITEBOARD_VERSION = 3d910b2373df365391e3c496270db8c696617abd
WHITEBOARD_SITE = $(call github,linux4sam,whiteboard,$(WHITEBOARD_VERSION))
WHITEBOARD_LICENSE = Apache-2.0
WHITEBOARD_LICENSE_FILES = COPYING
WHITEBOARD_DEPENDENCIES = qt5base

define WHITEBOARD_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define WHITEBOARD_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define WHITEBOARD_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
