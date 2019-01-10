################################################################################
#
# egt graphics library for microchip sam9x and sama5 soc's
#
################################################################################

EGT_VERSION = d586bb08343d7d9b108927b50d727e2edf60a27d
EGT_SITE = ssh://git@bitbucket.microchip.com/~c16205/egt.git
EGT_SITE_METHOD = git
EGT_GIT_SUBMODULES = YES
EGT_LICENSE = BSD
EGT_INSTALL_TARGET = YES
EGT_INSTALL_STAGING = YES

define EGT_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
EGT_POST_PATCH_HOOKS += EGT_RUN_AUTOGEN

$(eval $(autotools-package))
