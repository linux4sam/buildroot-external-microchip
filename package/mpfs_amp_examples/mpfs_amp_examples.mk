################################################################################
#
# Microchip PolarFire SoC AMP Examples
#
################################################################################
MPFS_AMP_EXAMPLES_VERSION = 2024.02
MPFS_AMP_EXAMPLES_SITE = $(call github,polarfire-soc,polarfire-soc-amp-examples,v$(MPFS_AMP_EXAMPLES_VERSION))
MPFS_AMP_EXAMPLES_INSTALL_TARGET = NO
MPFS_AMP_EXAMPLES_INSTALL_IMAGES = YES
MPFS_AMP_EXAMPLES_LICENSE = MIT
MPFS_AMP_EXAMPLES_LICENSE_FILES = LICENSE.md
MPFS_AMP_EXAMPLES_DIRS += $(BR2_PACKAGE_MPFS_AMP_CONTEXT_B)
MPFS_AMP_EXAMPLES_TARGET_DIR = /lib/firmware


define MPFS_AMP_EXAMPLES_BUILD_CMDS
	$(foreach project,$(MPFS_AMP_EXAMPLES_DIRS), \
		$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/$(project) CROSS_COMPILE=$(TARGET_CROSS) \
			REMOTE=1 REMOTEPROC=1 EXT_CFLAGS='-DMPFS_HAL_FIRST_HART=4 -DMPFS_HAL_LAST_HART=4'; \
		$(INSTALL) -D -m 775 $(@D)/$(project)/Remote-Default/mpfs-rpmsg-remote.elf \
			$(TARGET_DIR)$(MPFS_AMP_EXAMPLES_TARGET_DIR)/rproc-miv-rproc-fw;
		cp $(@D)/$(project)/Remote-Default/mpfs-rpmsg-remote.elf $(BINARIES_DIR);)
endef

$(eval $(generic-package))
