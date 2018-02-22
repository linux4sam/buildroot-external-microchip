################################################################################
#
# qtviewplanes
#
################################################################################

QTVIEWPLANES_VERSION = dc54405edd052215ac51821c2eed79811f5870b6
QTVIEWPLANES_SITE = $(call github,linux4sam,qtviewplanes,$(QTVIEWPLANES_VERSION))
QTVIEWPLANES_LICENSE = Apache-2.0
QTVIEWPLANES_LICENSE_FILES = COPYING
QTVIEWPLANES_DEPENDENCIES = qt5base libplanes

define QTVIEWPLANES_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define QTVIEWPLANES_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QTVIEWPLANES_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
