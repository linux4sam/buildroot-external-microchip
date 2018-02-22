################################################################################
#
# qt5quick1d
#
################################################################################

QT5QUICK1D_VERSION = 64faeb0d8003e699a4d09e7dcee1ef6eb10302ad
QT5QUICK1D_SITE = $(call github,qt,qtquick1,$(QT5QUICK1D_VERSION))
QT5QUICK1D_DEPENDENCIES = qt5base qt5xmlpatterns qt5script \
	$(if $(BR2_PACKAGE_QT5WEBKIT),qt5webkit)
QT5QUICK1D_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_QT5_VERSION_LATEST),y)
QT5QUICK1D_LICENSE = GPL-2.0+ or GPL-3.0 or LGPL-2.1 with exception or LGPL-3.0, GFDL-1.3 (docs)
QT5QUICK1D_LICENSE_FILES = LICENSE.GPLv2 LICENSE.GPLv3 LICENSE.LGPLv21 LICENSE.LGPLv3 LGPL_EXCEPTION.txt LICENSE.FDL
else
QT5QUICK1D_LICENSE = GPL-3.0 or LGPL-2.1 with exception or LGPL-3.0, GFDL-1.3 (docs)
QT5QUICK1D_LICENSE_FILES = LICENSE.GPLv3 LICENSE.LGPLv21 LGPL_EXCEPTION.txt LICENSE.LGPLv3 LICENSE.FDL
endif

QT5QUICK1D_ENV = PATH=$(@D)/bin:$(BR_PATH)
define QT5QUICK1D_PYTHON2_SYMLINK
	mkdir -p $(@D)/bin
	ln -sf $(HOST_DIR)/usr/bin/python2 $(@D)/bin/python
endef
QT5QUICK1D_PRE_CONFIGURE_HOOKS += QT5QUICK1D_PYTHON2_SYMLINK

define QT5QUICK1D_CONFIGURE_CMDS
	mkdir -p $(@D)/.git
	(cd $(@D); $(TARGET_MAKE_ENV) $(QT5QUICK1D_ENV) $(HOST_DIR)/usr/bin/qmake)
endef

define QT5QUICK1D_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(QT5QUICK1D_ENV) $(MAKE) -C $(@D)
endef

define QT5QUICK1D_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(QT5QUICK1D_ENV) $(MAKE) -C $(@D) install
	$(QT5_LA_PRL_FILES_FIXUP)
endef

define QT5QUICK1D_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5Declarative.so.* $(TARGET_DIR)/usr/lib
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/plugins/qml* $(TARGET_DIR)/usr/lib/qt/plugins
	cp -dpfr $(STAGING_DIR)/usr/imports $(TARGET_DIR)/usr
endef

$(eval $(generic-package))
