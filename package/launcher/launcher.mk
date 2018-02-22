################################################################################
#
# launcher
#
################################################################################

LAUNCHER_VERSION = 06e8935693b7d91699a46b5af60c3ee308c8864b
LAUNCHER_SITE = $(call github,linux4sam,application-launcher,$(LAUNCHER_VERSION))
LAUNCHER_LICENSE = Atmel LIMITED License Agreement
LAUNCHER_LICENSE_FILES = COPYING
LAUNCHER_DEPENDENCIES = qt5base qt5quick1d

define LAUNCHER_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define LAUNCHER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LAUNCHER_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
	$(INSTALL) -D -m 0664 $(@D)/applications_list.xml \
		$(TARGET_DIR)/opt/ApplicationLauncher/applications_list.xml
endef

define LAUNCHER_INSTALL_INIT
        $(INSTALL) -m 0755 -D $(LAUNCHER_PKGDIR)/S99demo \
                $(TARGET_DIR)/etc/init.d/S99demo
        $(INSTALL) -m 0644 -D $(LAUNCHER_PKGDIR)/setup.sh \
                $(TARGET_DIR)/etc/profile.d/setup.sh
	$(INSTALL) -D -m 0664 $(LAUNCHER_PKGDIR)/demo.config \
		$(TARGET_DIR)/opt/ApplicationLauncher/demo.config
endef

ifeq ($(BR2_PACKAGE_LAUNCHER_INIT),y)
LAUNCHER_POST_INSTALL_TARGET_HOOKS += LAUNCHER_INSTALL_INIT
endif

$(eval $(generic-package))
