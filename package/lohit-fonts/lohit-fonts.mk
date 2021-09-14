################################################################################
#
# lohit fonts
#
################################################################################

LOHIT_FONTS_VERSION = 20140220
LOHIT_FONTS_SITE = https://releases.pagure.org/lohit
LOHIT_FONTS_SOURCE = lohit-ttf-$(LOHIT_FONTS_VERSION).tar.gz

LOHIT_FONTS_LICENSE = OFL-1.1
LOHIT_FONTS_LICENSE_FILES += OFL.txt

LOHIT_FONTS_FONTS = \
	$(call qstrip,$(BR2_PACKAGE_LOHIT_FONTS_FONTS))

define LOHIT_FONTS_EXTRACT_CMDS
        $(call suitable-extractor,$(LOHIT_FONTS_SOURCE)) $(LOHIT_FONTS_DL_DIR)/$(LOHIT_FONTS_SOURCE) | \
        $(TAR) --strip-components=1 -C $(@D) $(TAR_OPTIONS) -
endef

	   #ttffile = "$(shell echo "$f" | sed 's/.*/\u&/')"
define LOHIT_FONTS_INSTALL_TARGET_CMDS
	$(foreach f, $(LOHIT_FONTS_FONTS), \
	   mkdir -p $(TARGET_DIR)/usr/share/fonts/truetype/lohit-$(f)
	   $(INSTALL) -m 0644 -t $(TARGET_DIR)/usr/share/fonts/truetype/lohit-$(f) $(@D)/Lohit-$(shell echo "$f" | sed 's/.*/\u&/').ttf
	)
endef

$(eval $(generic-package))
