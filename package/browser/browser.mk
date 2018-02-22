################################################################################
#
# browser
#
################################################################################

BROWSER_VERSION = 0626a3e087940bca6ced55ceee0df0074c0e9fee
BROWSER_SITE = $(call github,linux4sam,qml-browser,$(BROWSER_VERSION))
BROWSER_LICENSE = Atmel LIMITED License Agreement
BROWSER_DEPENDENCIES = qt5base qt5quick1d qt5webkit
BROWSER_INSTALL_STAGING = NO

define BROWSER_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE) browser.pro
endef

define BROWSER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define BROWSER_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
	( cd $(BROWSER_BUILDDIR)/opt/; \
		for file in $$(find ApplicationLauncher -type f); do \
			if [ -x $$file ]; then \
				PERM="755"; \
			else \
				PERM="644"; \
			fi; \
			$(INSTALL) -m $$PERM -D $$file $(TARGET_DIR)/opt/$$file; \
		done ; \
	)
endef

$(eval $(generic-package))
