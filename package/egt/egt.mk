################################################################################
#
# egt graphics library for microchip sam9x and sama5 soc's
#
################################################################################

EGT_VERSION = 1.3
EGT_SITE = https://github.com/linux4sam/egt.git
EGT_SITE_METHOD = git
EGT_GIT_SUBMODULES = YES
EGT_LICENSE = Apache-2.0
EGT_INSTALL_TARGET = YES
EGT_INSTALL_STAGING = YES
EGT_DEPENDENCIES = cairo

PACKAGE_EGT_EXTRA_CONFIG_OPTIONS = $(call qstrip,$(BR2_PACKAGE_EGT_EXTRA_CONFIG_OPTIONS))
EGT_CONF_OPTS = --program-prefix='egt_' --disable-debug
EGT_CONF_OPTS += $(PACKAGE_EGT_EXTRA_CONFIG_OPTIONS)

EGT_CONF_ENV += AR=$(TARGET_CC)-ar RANLIB=true
EGT_MAKE_ENV += AR=$(TARGET_CC)-ar RANLIB=true

ifeq ($(BR2_PACKAGE_EGT_INSTALL_EXAMPLES),y)
EGT_CONF_OPTS += --enable-examples
else
EGT_CONF_OPTS += --disable-examples
endif

ifeq ($(BR2_PACKAGE_EGT_INSTALL_ICONS),y)
EGT_CONF_OPTS += --enable-icons
else
EGT_CONF_OPTS += --disable-icons
endif

ifeq ($(BR2_PACKAGE_EGT_CHART_SUPPORT),y)
EGT_CONF_OPTS += --with-plplot
EGT_DEPENDENCIES += plplot
else
EGT_CONF_OPTS += --without-plplot
endif

ifeq ($(BR2_PACKAGE_LIBDRM),y)
EGT_CONF_OPTS += --with-libdrm
EGT_DEPENDENCIES += libdrm
else
EGT_CONF_OPTS += --without-libdrm
endif

ifeq ($(BR2_PACKAGE_LIBPLANES),y)
EGT_CONF_OPTS += --with-libplanes
EGT_DEPENDENCIES += libplanes
else
EGT_CONF_OPTS += --without-libplanes
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
EGT_CONF_OPTS += --with-libcurl
EGT_DEPENDENCIES += libcurl
else
EGT_CONF_OPTS += --without-libcurl
endif

ifeq ($(BR2_PACKAGE_LIBRSVG),y)
EGT_CONF_OPTS += --with-librsvg
EGT_DEPENDENCIES += librsvg
else
EGT_CONF_OPTS += --without-librsvg
endif

ifeq ($(BR2_PACKAGE_GSTREAMER1),y)
EGT_CONF_OPTS += --with-gstreamer
EGT_DEPENDENCIES += gstreamer1
else
EGT_CONF_OPTS += --without-gstreamer
endif

ifeq ($(BR2_PACKAGE_LIBEVDEV),y)
EGT_DEPENDENCIES += libevdev
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
EGT_CONF_OPTS += --with-libjpeg
EGT_DEPENDENCIES += jpeg
else
EGT_CONF_OPTS += --without-libjpeg
endif

ifeq ($(BR2_PACKAGE_TSLIB),y)
EGT_CONF_OPTS += --with-tslib
EGT_DEPENDENCIES += tslib
else
EGT_CONF_OPTS += --without-tslib
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
EGT_CONF_OPTS += --with-alsa
EGT_DEPENDENCIES += alsa-lib
else
EGT_CONF_OPTS += --without-alsa
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
EGT_CONF_OPTS += --with-sndfile
EGT_DEPENDENCIES += libsndfile
else
EGT_CONF_OPTS += --without-sndfile
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
EGT_CONF_OPTS += --with-zlib
EGT_DEPENDENCIES += zlib
else
EGT_CONF_OPTS += --without-zlib
endif

ifeq ($(BR2_PACKAGE_LIBINPUT),y)
EGT_CONF_OPTS += --with-libinput
EGT_DEPENDENCIES += libinput
else
EGT_CONF_OPTS += --without-libinput
endif

ifeq ($(BR2_PACKAGE_LUA),y)
EGT_CONF_OPTS += --with-lua
EGT_DEPENDENCIES += lua
else
EGT_CONF_OPTS += --without-lua
endif

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON),y)
EGT_CONF_OPTS += --with-xkbcommon
EGT_DEPENDENCIES += libxkbcommon
else
EGT_CONF_OPTS += --without-xkbcommon
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
EGT_CONF_OPTS += --with-x11
EGT_DEPENDENCIES += xlib_libX11
else
EGT_CONF_OPTS += --without-x11
endif

ifeq ($(BR2_PACKAGE_FILE),y)
EGT_CONF_OPTS += --with-libmagic
EGT_DEPENDENCIES += file
else
EGT_CONF_OPTS += --without-libmagic
endif

define EGT_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
EGT_POST_PATCH_HOOKS += EGT_RUN_AUTOGEN

$(eval $(autotools-package))
