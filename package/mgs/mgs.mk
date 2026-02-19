MGS_VERSION = dev
MGS_SITE = https://github.com/mchpgfx/mgs.git
MGS_GIT_SUBMODULES = YES
MGS_SITE_METHOD = git
MGS_LICENSE = License.md
MGS_INSTALL_TARGET = YES
MGS_DEPENDENCIES = libdrm

ifeq ($(BR2_PACKAGE_LIBEVDEV),y)
MGS_DEPENDENCIES += libevdev
endif

ifeq ($(BR2_PACKAGE_LIBINPUT),y)
MGS_CONF_OPTS += -DWITH_LIBINPUT=ON
MGS_DEPENDENCIES += libinput
else
MGS_CONF_OPTS += -DWITH_LIBINPUT=OFF
endif

ifeq ($(BR2_PACKAGE_SDL2),y)
MGS_CONF_OPTS += -DWITH_SDL2=ON
MGS_DEPENDENCIES += sdl2
endif

define MGS_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(BR2_EXTERNAL)/package/mgs/mgs_demo.service \
		$(TARGET_DIR)/usr/lib/systemd/system/mgs_demo.service

	$(INSTALL) -D -m 644 $(BR2_EXTERNAL)/package/mgs/50-mgs.preset \
		$(TARGET_DIR)/usr/lib/systemd/system-preset/50-mgs.preset

	$(INSTALL) -D -m 775 $(BR2_EXTERNAL)/package/mgs/launch_mgs.sh \
		$(TARGET_DIR)/usr/bin/launch_mgs.sh
endef

$(eval $(cmake-package))
