################################################################################
#
# egt launcher application
#
################################################################################

EGT_LAUNCHER_VERSION = 49e0dfb46a8272c6c21f26572a7d2f2c492f1a8e
EGT_LAUNCHER_SITE = https://github.com/linux4sam/egt-launcher.git
EGT_LAUNCHER_SITE_METHOD = git
EGT_LAUNCHER_GIT_SUBMODULES = YES
EGT_LAUNCHER_LICENSE = Apache-2.0
EGT_LAUNCHER_INSTALL_TARGET = YES
EGT_LAUNCHER_DEPENDENCIES = egt

define EGT_LAUNCHER_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
EGT_LAUNCHER_POST_PATCH_HOOKS += EGT_LAUNCHER_RUN_AUTOGEN

define EGT_LAUNCHER_INSTALL_INIT
        $(INSTALL) -m 0755 -D $(EGT_LAUNCHER_PKGDIR)/S99demo \
                $(TARGET_DIR)/etc/init.d/S99demo
endef

ifeq ($(BR2_PACKAGE_EGT_LAUNCHER_INIT),y)
EGT_LAUNCHER_POST_INSTALL_TARGET_HOOKS += EGT_LAUNCHER_INSTALL_INIT
endif

$(eval $(autotools-package))
