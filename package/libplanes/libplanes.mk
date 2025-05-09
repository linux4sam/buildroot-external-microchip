################################################################################
#
# libplanes
#
################################################################################

LIBPLANES_VERSION = v1.1.0
LIBPLANES_SITE = $(call github,linux4sam,libplanes,$(LIBPLANES_VERSION))
LIBPLANES_LICENSE = MIT
LIBPLANES_LICENSE_FILES = COPYING
LIBPLANES_AUTORECONF = YES
LIBPLANES_AUTORECONF_OPTS += -I $(HOST_DIR)/usr/share/autoconf-archive
LIBPLANES_DEPENDENCIES = libdrm cairo cjson lua \
	host-pkgconf host-autoconf-archive

ifeq ($(BR2_PACKAGE_LIBPLANES_INSTALL_EXAMPLES),y)
LIBPLANES_CONF_OPTS += --enable-examples
else
LIBPLANES_CONF_OPTS += --disable-examples
endif

ifeq ($(BR2_PACKAGE_DIRECTFB),y)
LIBPLANES_DEPENDENCIES += directfb
endif

ifeq ($(BR2_PACKAGE_PYTHON),y)
LIBPLANES_DEPENDENCIES += python host-swig
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
LIBPLANES_DEPENDENCIES += python3 host-swig
endif

LIBPLANES_INSTALL_STAGING = YES

define LIBPLANES_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
LIBPLANES_POST_PATCH_HOOKS += LIBPLANES_RUN_AUTOGEN

define LIBPLANES_INSTALL_INIT
        $(INSTALL) -m 0755 -D $(LIBPLANES_PKGDIR)/S99planes \
                $(TARGET_DIR)/etc/init.d/S99planes
endef

ifeq ($(BR2_PACKAGE_PLANES_INIT),y)
LIBPLANES_POST_INSTALL_TARGET_HOOKS += LIBPLANES_INSTALL_INIT
endif

define LIBPLANES_INSTALL_MENU
        $(INSTALL) -m 0644 -D $(@D)/scripts/planes.png \
                $(TARGET_DIR)/opt/applications/resources/planes.png
        $(INSTALL) -m 0755 -D $(@D)/scripts/planes-loop.sh \
                $(TARGET_DIR)/opt/planes/planes-loop.sh
        $(INSTALL) -m 0755 -D $(@D)/scripts/planes-loop.py \
                $(TARGET_DIR)/opt/planes/planes-loop.py
        $(INSTALL) -m 0755 -D $(@D)/python/examples/splash.py \
                $(TARGET_DIR)/usr/share/planes/splash.py
        $(INSTALL) -m 0755 -D $(@D)/python/examples/example.py \
                $(TARGET_DIR)/usr/share/planes/example.py
	 $(INSTALL) -m 0755 -D $(@D)/scripts/09-planes.xml \
		$(TARGET_DIR)/opt/applications/resources/09-planes.xml
endef

LIBPLANES_POST_INSTALL_TARGET_HOOKS += LIBPLANES_INSTALL_MENU

$(eval $(autotools-package))
