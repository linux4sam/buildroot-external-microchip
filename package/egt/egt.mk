################################################################################
#
# egt graphics library for microchip sam9x and sama5 soc's
#
################################################################################

EGT_VERSION = 1ab2d333b670ee4c2308f837fb41fa12145d9ee1
EGT_SITE = ssh://git@bitbucket.microchip.com/linux4sam/egt.git
EGT_SITE_METHOD = git
EGT_GIT_SUBMODULES = YES
EGT_LICENSE = BSD
EGT_INSTALL_TARGET = YES
EGT_INSTALL_STAGING = YES
EGT_DEPENDENCIES = \
libevdev \
libgpiod \
g1-decoder \
libdrm \
libplanes \
cairo \
pango \
jpeg \
libpng \
gstreamer1 \
rapidxml \
file

define EGT_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
EGT_POST_PATCH_HOOKS += EGT_RUN_AUTOGEN

$(eval $(autotools-package))
