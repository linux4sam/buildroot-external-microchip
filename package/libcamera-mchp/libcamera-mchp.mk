################################################################################
#
# libcamera-mchp
#
################################################################################
LIBCAMERA_MCHP_VERSION = linux4microchip-2025.04
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
	gnutls \
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
	find $(@D)/build/src/ipa \
	$(if $(call qstrip,$(BR2_STRIP_EXCLUDE_FILES)), \
		-not \( $(call findfileclauses,$(call qstrip,$(BR2_STRIP_EXCLUDE_FILES))) \) ) \
	-type f -name 'ipa_*.so' -print0

define LIBCAMERA_MCHP_BUILD_STRIP_IPA_SO
	$(LIBCAMERA_MCHP_STRIP_FIND_CMD) | xargs --no-run-if-empty -0 $(STRIPCMD)
endef

define LIBCAMERA_MCHP_CREATE_DIRS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/libcamera/
endef

define LIBCAMERA_MCHP_INSTALL_SIGN_IPA
	$(INSTALL) -D -m 755 $(@D)/src/ipa/ipa-sign-install.sh $(TARGET_DIR)/usr/lib/libcamera/
	cd $(TARGET_DIR)/usr/lib/libcamera/ && \
	./ipa-sign-install.sh $(@D)/build/src/ipa-priv-key.pem ipa_*.so
endef

# Install the IPA module
define LIBCAMERA_MCHP_INSTALL_IPA_MODULE
       if [ -f $(@D)/build/src/ipa/microchip-isc/ipa_microchip_isc.so ]; then \
               $(INSTALL) -D -m 0755 $(@D)/build/src/ipa/microchip-isc/ipa_microchip_isc.so \
                       $(TARGET_DIR)/usr/lib/libcamera/ipa_microchip_isc.so ; \
       fi
endef

LIBCAMERA_MCHP_POST_BUILD_HOOKS += LIBCAMERA_MCHP_BUILD_STRIP_IPA_SO
LIBCAMERA_MCHP_PRE_INSTALL_TARGET_HOOKS += LIBCAMERA_MCHP_CREATE_DIRS
ifeq ($(BR2_PACKAGE_LIBCAMERA_MCHP_IPA),y)
LIBCAMERA_MCHP_POST_INSTALL_TARGET_HOOKS += LIBCAMERA_MCHP_INSTALL_IPA_MODULE
endif
LIBCAMERA_MCHP_POST_INSTALL_TARGET_HOOKS += LIBCAMERA_MCHP_INSTALL_SIGN_IPA

$(eval $(meson-package))
