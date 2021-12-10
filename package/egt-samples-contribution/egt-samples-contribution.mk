###############################################################################
#
# egt sample applications from the community
#
###############################################################################

EGT_SAMPLES_CONTRIBUTION_VERSION = 1.0
EGT_SAMPLES_CONTRIBUTION_SITE = https://github.com/linux4sam/egt-samples-contribution.git
EGT_SAMPLES_CONTRIBUTION_SITE_METHOD = git
EGT_SAMPLES_CONTRIBUTION_LICENSE = Apache-2.0
EGT_SAMPLES_CONTRIBUTION_INSTALL_TARGET = YES
EGT_SAMPLES_CONTRIBUTION_DEPENDENCIES = egt

ifeq ($(BR2_PACKAGE_EGT_SAMPLES_CONTRIBUTION_SLIDERB),y)
EGT_SAMPLES_CONTRIBUTION_CONF_OPTS += -DEGT_SAMPLES_CONTRIBUTION_SLIDERB=TRUE
endif

$(eval $(cmake-package))

