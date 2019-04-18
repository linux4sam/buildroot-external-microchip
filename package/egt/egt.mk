################################################################################
#
# egt graphics library for microchip sam9x and sama5 soc's
#
################################################################################

EGT_VERSION = 93fc9fb6574a73a00d7544bf795f2fe7ba661d2e
EGT_SITE = https://bitbucket.microchip.com/scm/linux4sam/egt.git
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
file

ifeq ($(BR2_PACKAGE_LIBCURL),y)
EGT_DEPENDENCIES += libcurl
endif

ifeq ($(BR2_PACKAGE_LIBRSVG),y)
EGT_DEPENDENCIES += librsvg
endif

define EGT_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
EGT_POST_PATCH_HOOKS += EGT_RUN_AUTOGEN

$(eval $(autotools-package))
