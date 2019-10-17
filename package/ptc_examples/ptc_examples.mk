################################################################################
#
# ptc_examples
#
################################################################################

PTC_EXAMPLES_VERSION = v1.3.1
PTC_EXAMPLES_SITE = $(call github,linux4sam,ptc_examples,$(PTC_EXAMPLES_VERSION))
PTC_EXAMPLES_LICENSE = Apache-2.0 (programs), Microchip (firmware and config files)
PTC_EXAMPLES_LICENSE_FILES = src/COPYING cfg/LICENCE.ptc_cfg fw/LICENCE.ptc_fw
PTC_EXAMPLES_DEPENDENCIES = libgpiod libevdev

ifeq ($(BR2_PACKAGE_PTC_EXAMPLES_PLATFORM),"SAMA5D27_WLSOM1_EK")
TARGET_CFLAGS += -DSAMA5D27_WLSOM1_EK
endif

define PTC_EXAMPLES_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define PTC_EXAMPLES_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/ptc_qt*_demo $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/src/start_ptc_qt* $(TARGET_DIR)/root
	mkdir -p $(TARGET_DIR)/lib/firmware/microchip
	$(INSTALL) -D -m 0644 $(@D)/cfg/*.bin $(TARGET_DIR)/lib/firmware/microchip
	$(INSTALL) -D -m 0644 $(@D)/fw/*.bin $(TARGET_DIR)/lib/firmware/microchip
endef

$(eval $(generic-package))
