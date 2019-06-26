################################################################################
#
# egt launcher application
#
################################################################################

EGT_LAUNCHER_VERSION = 92b47c1cd8f0447ff8f6ecea720c93dbaba4661c
EGT_LAUNCHER_SITE = https://bitbucket.microchip.com/scm/linux4sam/egt-launcher.git
EGT_LAUNCHER_SITE_METHOD = git
EGT_LAUNCHER_GIT_SUBMODULES = YES
EGT_LAUNCHER_LICENSE = Apache-2.0
EGT_LAUNCHER_INSTALL_TARGET = YES
EGT_LAUNCHER_DEPENDENCIES = egt

define EGT_LAUNCHER_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
EGT_LAUNCHER_POST_PATCH_HOOKS += EGT_LAUNCHER_RUN_AUTOGEN

$(eval $(autotools-package))
