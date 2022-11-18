################################################################################
 #
 # Hart Software Services
 #
################################################################################
HSS_PAYLOAD_GENERATOR_VERSION = v2022.09
HSS_PAYLOAD_GENERATOR_SITE = $(call github,polarfire-soc,hart-software-services,$(HSS_PAYLOAD_GENERATOR_VERSION))
HSS_PAYLOAD_GENERATOR_INSTALL_STAGING = NO
HSS_PAYLOAD_GENERATOR_INSTALL_TARGET = YES
HSS_PAYLOAD_GENERATOR_LICENSE = MIT
HSS_PAYLOAD_GENERATOR_LICENSE_FILES = LICENSE.md

ifeq ($(BR2_PACKAGE_MPFS_AMP_EXAMPLES),y)
HOST_HSS_PAYLOAD_GENERATOR_DEPENDENCIES += uboot mpfs_amp_examples
else
HOST_HSS_PAYLOAD_GENERATOR_DEPENDENCIES += uboot
endif

define HOST_HSS_PAYLOAD_GENERATOR_BUILD_CMDS
	$(MAKE) -C $(@D)/tools/hss-payload-generator

	cp $(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR_SRC) $(@D)/tools/hss-payload-generator/src.bin
	( \
		if [ "$(BR2_PACKAGE_MPFS_AMP_EXAMPLES)" = "y" ]; then \
			cp $(BINARIES_DIR)/mpfs-rpmsg-remote.elf $(@D)/tools/hss-payload-generator/amp.elf; \
		fi; \
		cd $(@D)/tools/hss-payload-generator; \
		./hss-payload-generator -c $(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR_CFG) -v $(BINARIES_DIR)/payload.bin; \
	)

endef

$(eval $(host-generic-package))
