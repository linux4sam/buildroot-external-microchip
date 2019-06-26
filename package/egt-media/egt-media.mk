################################################################################
#
# Media files for EGT example applications
#
################################################################################

EGT_MEDIA_VERSION = 1.0
EGT_MEDIA_SITE = https://microchiptechnology-my.sharepoint.com/:u:/g/personal/sandeepsheriker_mallikarjun_microchip_com
EGT_MEDIA_SOURCE = EYh2YH8-dNpDgZhXjmkSvHYBM4KXhHSTzHzeYqr77MYzBw?download=1
EGT_MEDIA_SITE_METHOD = wget
EGT_MEDIA_FILENAME = $(PKG)-$(EGT_MEDIA_VERSION).tar.gz

define EGT_MEDIA_RENAME_DOWNLOADS
	mv $(DL_DIR)/egt-media/$(EGT_MEDIA_SOURCE) $(DL_DIR)/$(EGT_MEDIA_FILENAME)
endef

EGT_MEDIA_POST_DOWNLOAD_HOOKS = EGT_MEDIA_RENAME_DOWNLOADS

define EGT_MEDIA_EXTRACT_CMDS
endef

define EGT_MEDIA_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/egt/examples
        $(call suitable-extractor, $(EGT_MEDIA_FILENAME)) \
		$(DL_DIR)/$(EGT_MEDIA_FILENAME) | \
                $(TAR) --strip-components=1 -C  $(TARGET_DIR)/usr/share/egt/examples $(TAR_OPTIONS) -
endef

$(eval $(generic-package))
