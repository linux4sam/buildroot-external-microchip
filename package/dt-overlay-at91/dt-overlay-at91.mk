################################################################################
#
# dt overlay at91
#
################################################################################

DT_OVERLAY_AT91_VERSION = bc401e014934bf59ed1a03ce4120bf0688768aa6
DT_OVERLAY_AT91_SITE = https://bitbucket.microchip.com/scm/linux4sam/dt-overlay-at91.git
DT_OVERLAY_AT91_SITE_METHOD = git
DT_OVERLAY_AT91_LICENSE = GPL-2.0 MIT 
DT_OVERLAY_AT91_LICENSE_FILES = COPYING LICENSES/GPL-2.0 LICENSES/MIT
DT_OVERLAY_AT91_DEPENDENCIES = linux host-uboot-tools

ifeq ($(BR2_PACKAGE_DT_OVERLAY_AT91_ONLY),y)
define DT_OVERLAY_AT91_BUILD_CMDS
	PATH="$(LINUX_DIR)/scripts/dtc:$(HOST_DIR)/bin:$(PATH)" $(MAKE) DTC="$(LINUX_DIR)/scripts/dtc/dtc" KERNEL_DIR="$(LINUX_DIR)" -C $(@D) $(BR2_PACKAGE_DT_OVERLAY_AT91_PLATFORM)_dtbos
endef
define DT_OVERLAY_AT91_INSTALL_TARGET_CMDS
	$(foreach f,$(notdir $(wildcard $(@D)/*/*.dtbo)),
		$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_AT91_PLATFORM)/$(f) \
			$(BINARIES_DIR))
endef
else
define DT_OVERLAY_AT91_BUILD_CMDS
	PATH="$(LINUX_DIR)/scripts/dtc:$(HOST_DIR)/bin:$(PATH)" $(MAKE) DTC="$(LINUX_DIR)/scripts/dtc/dtc" KERNEL_DIR="$(LINUX_DIR)" -C $(@D) $(BR2_PACKAGE_DT_OVERLAY_AT91_PLATFORM).itb
endef
define DT_OVERLAY_AT91_INSTALL_TARGET_CMDS
	$(foreach f,$(notdir $(wildcard $(@D)/*/*.dtbo)),
		$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_AT91_PLATFORM)/$(f) \
			$(BINARIES_DIR))
	$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_AT91_PLATFORM).itb $(BINARIES_DIR)/
endef
endif

$(eval $(generic-package))
