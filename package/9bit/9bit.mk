################################################################################
#
# 9bit/Multidrop Serial Mode
#
################################################################################

9BIT_VERSION = f4cd916c8c58300ea1cbb398f0b40fe43a70d6d6
9BIT_SITE = $(call github,linux4sam,9bit,$(9BIT_VERSION))
9BIT_LICENSE = MIT
9BIT_LICENSE_FILES = COPYING

define 9BIT_BUILD_CMDS
	$(TARGET_MAKE_ENV) CC="$(TARGET_CC)" LD="$(TARGET_LD)" $(MAKE) -C $(@D) all
endef

define 9BIT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/p9bit_example $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/user_example $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/senda_example $(TARGET_DIR)/usr/bin
endef


$(eval $(generic-package))
