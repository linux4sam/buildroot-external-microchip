################################################################################
#
# ptc_examples
#
################################################################################

PTC_EXAMPLES_VERSION = v1.4.0-rc1
PTC_EXAMPLES_SITE = $(call github,linux4sam,ptc_examples,$(PTC_EXAMPLES_VERSION))
PTC_EXAMPLES_LICENSE = Apache-2.0 (programs), Microchip (firmware and config files)
PTC_EXAMPLES_LICENSE_FILES = src/COPYING cfg/LICENCE.ptc_cfg fw/LICENCE.ptc_fw
PTC_EXAMPLES_DEPENDENCIES = libgpiod2 libevdev

ifeq ($(BR2_PACKAGE_PTC_EXAMPLES_PLATFORM),"SAMA5D27_WLSOM1_EK")
PTC_EXAMPLES_CONF_OPTS += -DSAMA5D27_WLSOM1_EK=ON
endif

define PTC_EXAMPLES_INSTALL_FIRMWARE
	mkdir -p $(TARGET_DIR)/lib/firmware/microchip
	$(INSTALL) -D -m 0644 $(@D)/cfg/*.bin $(TARGET_DIR)/lib/firmware/microchip
	$(INSTALL) -D -m 0644 $(@D)/fw/*.bin $(TARGET_DIR)/lib/firmware/microchip
endef

define PTC_EXAMPLES_INSTALL_SCRIPTS
	$(INSTALL) -D -m 0755 $(@D)/src/start_ptc_qt* $(TARGET_DIR)/root
endef

PTC_EXAMPLES_POST_INSTALL_TARGET_HOOKS += PTC_EXAMPLES_INSTALL_FIRMWARE PTC_EXAMPLES_INSTALL_SCRIPTS

$(eval $(cmake-package))
