################################################################################
#
# libcamera-mchp
#
################################################################################
LIBCAMERA_MCHP_VERSION = linux4microchip-2026.04
LIBCAMERA_MCHP_SITE = $(call github,linux4microchip,libcamera-mchp,$(LIBCAMERA_MCHP_VERSION))
LIBCAMERA_MCHP_LICENSE = \
    LGPL-2.1+ (library), \
    GPL-2.0+ (utils), \
    GPL-2.0 with Linux-syscall-note or BSD-3-Clause (linux kernel headers), \
    CC0-1.0 (meson build system)
LIBCAMERA_MCHP_LICENSE_FILES = \
    LICENSES/LGPL-2.1-or-later.txt \
    LICENSES/GPL-2.0-or-later.txt \
    LICENSES/GPL-2.0-only.txt \
    LICENSES/Linux-syscall-note.txt \
    LICENSES/BSD-3-Clause.txt \
    LICENSES/CC0-1.0.txt
LIBCAMERA_MCHP_INSTALL_STAGING = YES
LIBCAMERA_MCHP_CXXFLAGS = -O2 -pipe -g -feliminate-unused-debug-types
LIBCAMERA_MCHP_DEPENDENCIES = \
	host-openssl \
	host-pkgconf \
	host-python-pyyaml \
	host-python-jinja2 \
	host-python-ply \
	udev \
	openssl \
	libevent \
	libyaml \
	jpeg \
	libpng

LIBCAMERA_MCHP_CONF_OPTS = \
	-Dpipelines=microchip-isc \
	-Dv4l2=true \
	-Dcam=enabled \
	-Dudev=enabled \
	-Dipas=microchip-isc \
	-Dlc-compliance=disabled \
	-Dtest=false \
	-Ddocumentation=disabled \
	-Dgstreamer=disabled \
	-Dpycamera=disabled

# Open-Source IPA shlibs need to be signed in order to be runnable within the
# same process, otherwise they are deemed Closed-Source and run in another
# process and communicate over IPC.
LIBCAMERA_MCHP_STRIP_FIND_CMD = \
	find $(@D)/buildroot-build/src/ipa \
	$(if $(call qstrip,$(BR2_STRIP_EXCLUDE_FILES)), \
		-not \( $(call findfileclauses,$(call qstrip,$(BR2_STRIP_EXCLUDE_FILES))) \) ) \
	-type f -name 'ipa_*.so' -print0

define LIBCAMERA_MCHP_BUILD_STRIP_IPA_SO
	$(LIBCAMERA_MCHP_STRIP_FIND_CMD) | xargs --no-run-if-empty -0 $(STRIPCMD)
endef

# libgmp (used by gnutls/nettle for RSA) contains Thumb-2 instructions that
# are illegal on ARMv5TE (ARM926EJ-S). Swap detection order so libcrypto
# (OpenSSL) is used instead, which does not depend on libgmp.
define LIBCAMERA_MCHP_USE_OPENSSL_FOR_IPA_SIGNING
	$(SED) 's|dependency.*gnutls.*required.*false)|dependency('\''libcrypto'\'', required : false)|' \
		$(@D)/src/libcamera/meson.build
	$(SED) 's|config_h.set.*HAVE_GNUTLS.*|config_h.set('\''HAVE_CRYPTO'\'', 1)|' \
		$(@D)/src/libcamera/meson.build
endef

LIBCAMERA_MCHP_PRE_CONFIGURE_HOOKS += LIBCAMERA_MCHP_USE_OPENSSL_FOR_IPA_SIGNING

define LIBCAMERA_MCHP_CREATE_DIRS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/libcamera/ipa/
endef

define LIBCAMERA_MCHP_INSTALL_SIGN_IPA
	PATH="$(HOST_DIR)/bin:$(PATH)" $(@D)/src/ipa/ipa-sign.sh \
		$(@D)/buildroot-build/src/ipa-priv-key.pem \
		$(TARGET_DIR)/usr/lib/libcamera/ipa/ipa_microchip_isc.so \
		$(TARGET_DIR)/usr/lib/libcamera/ipa/ipa_microchip_isc.so.sign
endef

LIBCAMERA_MCHP_POST_BUILD_HOOKS += LIBCAMERA_MCHP_BUILD_STRIP_IPA_SO
LIBCAMERA_MCHP_PRE_INSTALL_TARGET_HOOKS += LIBCAMERA_MCHP_CREATE_DIRS
LIBCAMERA_MCHP_POST_INSTALL_TARGET_HOOKS += LIBCAMERA_MCHP_INSTALL_SIGN_IPA

$(eval $(meson-package))
