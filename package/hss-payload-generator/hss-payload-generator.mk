################################################################################
#
# hss-payload-generator
#
################################################################################
HOST_HSS_PAYLOAD_GENERATOR_VERSION = 2023.09
HOST_HSS_PAYLOAD_GENERATOR_SITE = $(call github,polarfire-soc,hart-software-services,v$(HOST_HSS_PAYLOAD_GENERATOR_VERSION))
HOST_HSS_PAYLOAD_GENERATOR_LICENSE = MIT
HOST_HSS_PAYLOAD_GENERATOR_LICENSE_FILES = LICENSE.md
HOST_HSS_PAYLOAD_GENERATOR_DEPENDENCIES = host-elfutils host-libyaml host-openssl

ifeq ($(BR2_PACKAGE_MPFS_AMP_EXAMPLES),y)
	HOST_HSS_PAYLOAD_GENERATOR_DEPENDENCIES += uboot mpfs_amp_examples
else
	HOST_HSS_PAYLOAD_GENERATOR_DEPENDENCIES += uboot
endif

define HOST_HSS_PAYLOAD_GENERATOR_BUILD_CMDS
	$(MAKE) -C $(@D)/tools/hss-payload-generator \
		HOST_INCLUDES="$(HOST_CPPFLAGS)" \
		LDFLAGS="$(HOST_LDFLAGS)"

	cp $(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR_SRC) \
		$(@D)/tools/hss-payload-generator/src.bin

	( \
		if [ "$(BR2_PACKAGE_MPFS_AMP_EXAMPLES)" = "y" ]; then \
			cp $(BINARIES_DIR)/mpfs-rpmsg-remote.elf \
				$(@D)/tools/hss-payload-generator/amp.elf; \
		fi; \
		cd $(@D)/tools/hss-payload-generator; \
		./hss-payload-generator \
			-c $(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR_CFG) \
			-v $(BINARIES_DIR)/payload.bin; \
	)
endef

$(eval $(host-generic-package))
