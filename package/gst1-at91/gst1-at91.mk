################################################################################
#
# gst1-at91
#
################################################################################

GST1_AT91_VERSION = gstreamer1.0-plugins-hantro_1.8
GST1_AT91_SITE = https://github.com/linux4sam/gst1-hantro-g1
GST1_AT91_SITE_METHOD = git
GST1_AT91_LICENSE = LGPLv2+
GST1_AT91_LICENSE_FILES = COPYING.LESSER
GST1_AT91_INSTALL_STAGING = YES
GST1_AT91_GIT_SUBMODULES = YES

GST1_AT91_DEPENDENCIES += \
	host-pkgconf \
	gstreamer1 \
	gst1-plugins-base \
	g1-decoder \
	libdrm

define GST1_AT91_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh --noconfigure
endef

GST1_AT91_POST_PATCH_HOOKS += GST1_AT91_RUN_AUTOGEN
GST1_AT91_DEPENDENCIES += host-automake host-autoconf host-libtool

GST1_AT91_CONF_ENV = \
		G1_CFLAGS="-I${STAGING_DIR}/usr/include" \
		G1_LIBS="-L${STAGING_DIR}/usr/lib" \
		GST_LIBDRM="${STAGING_DIR}/"

define GST1_AT91_BUILD_CMDS
	cd $(@D); $(TARGET_MAKE_ENV) make GST_LIBDRM="$(STAGING_DIR)"
endef

$(eval $(autotools-package))
