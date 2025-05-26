################################################################################
#
# dt overlay mchp
#
################################################################################

DT_OVERLAY_MCHP_VERSION = linux4microchip-2025.04
DT_OVERLAY_MCHP_SITE = $(call github,linux4microchip,dt-overlay-mchp,$(DT_OVERLAY_MCHP_VERSION))
DT_OVERLAY_MCHP_LICENSE = GPL-2.0 MIT
DT_OVERLAY_MCHP_LICENSE_FILES = COPYING LICENSES/GPL-2.0 LICENSES/MIT
DT_OVERLAY_MCHP_DEPENDENCIES = linux host-uboot-tools

ifeq ($(BR2_PACKAGE_DT_OVERLAY_MCHP_ONLY),y)
define DT_OVERLAY_MCHP_BUILD_CMDS
	PATH="$(LINUX_DIR)/scripts/dtc:$(HOST_DIR)/bin:$(PATH)" $(MAKE) DTC="$(LINUX_DIR)/scripts/dtc/dtc" KERNEL_DIR="$(LINUX_DIR)" -C $(@D) $(BR2_PACKAGE_DT_OVERLAY_MCHP_PLATFORM)_dtbos
endef
define DT_OVERLAY_MCHP_INSTALL_TARGET_CMDS
	$(foreach f,$(notdir $(wildcard $(@D)/*/*.dtbo)),
		$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_MCHP_PLATFORM)/$(f) \
			$(BINARIES_DIR))
endef
else
ifeq ($(BR2_riscv),y)
	dt_overlay_arch := riscv
else
	dt_overlay_arch := arm
endif
define DT_OVERLAY_MCHP_BUILD_CMDS
	ARCH=$(dt_overlay_arch) PATH="$(LINUX_DIR)/scripts/dtc:$(HOST_DIR)/bin:$(PATH)" $(MAKE) DTC="$(LINUX_DIR)/scripts/dtc/dtc" KERNEL_DIR="$(LINUX_DIR)" -C $(@D) $(BR2_PACKAGE_DT_OVERLAY_MCHP_PLATFORM).itb
endef
define DT_OVERLAY_MCHP_INSTALL_TARGET_CMDS
	$(foreach f,$(notdir $(wildcard $(@D)/*/*.dtbo)),
		$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_MCHP_PLATFORM)/$(f) \
			$(BINARIES_DIR))
	$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_MCHP_PLATFORM).itb $(BINARIES_DIR)/
	$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_MCHP_PLATFORM).its $(BINARIES_DIR)/
endef
endif

$(eval $(generic-package))
