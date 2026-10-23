################################################################################
#
# noto fonts
#
################################################################################

NOTO_FONTS_VERSION = 2025-01
NOTO_FONTS_SOURCE =
NOTO_FONTS_LICENSE = OFL-1.1

NOTO_FONTS_FONTS = \
	$(call qstrip,$(BR2_PACKAGE_NOTO_FONTS_FONTS))

NOTO_FONTS_NOTOSANS_TAG = noto-monthly-release-2026.09.01
NOTO_FONTS_NOTOCJK_TAG = Sans2.004
NOTO_FONTS_NOTOEMOJI_TAG = v2.051

# Map font filenames to their respective GitHub URLs. Fetch from tags rather
# than the default branch: the upstream repositories reorganise their
# directory layout on main, which silently breaks the fetch.
NOTO_FONTS_URL_NotoSans-Regular.ttf = https://github.com/notofonts/notofonts.github.io/raw/$(NOTO_FONTS_NOTOSANS_TAG)/fonts/NotoSans/unhinted/ttf/NotoSans-Regular.ttf
NOTO_FONTS_URL_NotoSansCJKsc-Regular.otf = https://github.com/notofonts/noto-cjk/raw/$(NOTO_FONTS_NOTOCJK_TAG)/Sans/OTF/SimplifiedChinese/NotoSansCJKsc-Regular.otf
NOTO_FONTS_URL_NotoColorEmoji.ttf = https://github.com/googlefonts/noto-emoji/raw/$(NOTO_FONTS_NOTOEMOJI_TAG)/fonts/NotoColorEmoji.ttf

define NOTO_FONTS_EXTRACT_CMDS
	mkdir -p $(@D)
	$(foreach f,$(NOTO_FONTS_FONTS), \
		$(if $(NOTO_FONTS_URL_$(f)), \
			wget -O $(@D)/$(f) $(NOTO_FONTS_URL_$(f)) || exit 1; \
		, \
			$(error Unknown Noto font: $(f). Please add URL mapping for this font) \
		) \
	)
endef

define NOTO_FONTS_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/fonts/noto
	$(foreach f,$(NOTO_FONTS_FONTS), \
		$(INSTALL) -m 0644 -t $(TARGET_DIR)/usr/share/fonts/noto $(@D)/$(f)$(sep) \
	)
endef

$(eval $(generic-package))
