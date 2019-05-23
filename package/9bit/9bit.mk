################################################################################
#
# 9bit/Multidrop Serial Mode
#
################################################################################

9BIT_VERSION = df45b743003a78bb735eb3c2cb294f3cce3ae43a
9BIT_SITE = https://github.com/linux4sam/9bit.git
9BIT_LICENSE = MIT
9BIT_LICENSE_FILES = COPYING
9BIT_SITE_METHOD = git

define 9BIT_BUILD_CMDS
	$(TARGET_MAKE_ENV) CC="$(TARGET_CC)" LD="$(TARGET_LD)" $(MAKE) -C $(@D) all
endef

define 9BIT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/p9bit_example $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/user_example $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/senda_example $(TARGET_DIR)/usr/bin
endef


$(eval $(generic-package))
