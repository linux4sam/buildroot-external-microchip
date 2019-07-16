################################################################################
#
# noto fonts
#
################################################################################

NOTO_FONTS_VERSION = 2017-10-24
NOTO_FONTS_SITE = https://noto-website-2.storage.googleapis.com/pkgs
NOTO_FONTS_SOURCE = Noto-unhinted.zip
NOTO_FONTS_DEPENDENCIES = host-zip

NOTO_FONTS_FONTS = \
	$(call qstrip,$(BR2_PACKAGE_NOTO_FONTS_FONTS))

NOTO_FONTS_LICENSE = OFL-1.1
NOTO_FONTS_LICENSE_FILES += LICENSE_OFL.txt

define NOTO_FONTS_EXTRACT_CMDS
        $(UNZIP) -d $(@D) $(NOTO_FONTS_DL_DIR)/$(NOTO_FONTS_SOURCE)
        #mv $(@D)/noto-fonts-$(NOTO_FONTS_VERSION)/* $(@D)
        #$(RM) -r $(@D)/noto-fonts-$(NOTO_FONTS_VERSION)
endef

define NOTO_FONTS_INSTALL_TARGET_CMDS
	$(foreach f,$(NOTO_FONTS_FONTS), \
		mkdir -p $(TARGET_DIR)/usr/share/fonts/noto
		$(INSTALL) -m 0644 -t $(TARGET_DIR)/usr/share/fonts/noto $(@D)/$(f)
	)
endef

$(eval $(generic-package))
