################################################################################
#
# egt sample applications
#
################################################################################

EGT_SAMPLES_VERSION = 22d9a88a4ebc549448aed040fd2e00d5a0ccb4b8
EGT_SAMPLES_SITE = https://bitbucket.microchip.com/scm/linux4sam/egt-samples.git
EGT_SAMPLES_SITE_METHOD = git
EGT_SAMPLES_GIT_SUBMODULES = YES
EGT_SAMPLES_LICENSE = Apache-2.0
EGT_SAMPLES_INSTALL_TARGET = YES
EGT_SAMPLES_DEPENDENCIES = egt

define EGT_SAMPLES_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
EGT_SAMPLES_POST_PATCH_HOOKS += EGT_SAMPLES_RUN_AUTOGEN

$(eval $(autotools-package))
