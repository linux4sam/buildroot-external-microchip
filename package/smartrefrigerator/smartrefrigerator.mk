################################################################################
#
# smartrefrigerator
#
################################################################################

SMARTREFRIGERATOR_VERSION = 5c7bbb38ec639313d6b0e0d8e6919856eff8fc0a
SMARTREFRIGERATOR_SITE = $(call github,linux4sam,smart-refrigerator,$(SMARTREFRIGERATOR_VERSION))
SMARTREFRIGERATOR_LICENSE = Atmel LIMITED License Agreement
SMARTREFRIGERATOR_DEPENDENCIES = qt5base qt5quick1d qt5webkit libv4l
SMARTREFRIGERATOR_INSTALL_STAGING = NO

define SMARTREFRIGERATOR_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(QT5_QMAKE) SmartRefrigerator.pro
endef

define SMARTREFRIGERATOR_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define SMARTREFRIGERATOR_INSTALL_TARGET_CMDS
	$(MAKE) INSTALL_ROOT=$(TARGET_DIR) -C $(@D) install
	( cd $(SMARTREFRIGERATOR_BUILDDIR)/output/; \
		for file in $$(find SmartRefrigerator ApplicationLauncher -type f); do \
			if [ -x $$file ]; then \
				PERM="755"; \
			else \
				PERM="644"; \
			fi; \
			$(INSTALL) -m $$PERM -D $$file $(TARGET_DIR)/opt/$$file; \
		done ; \
		$(INSTALL) -m 644 nhttpd.conf $(TARGET_DIR)/etc/nhttpd.conf; \
	)
endef

$(eval $(generic-package))
