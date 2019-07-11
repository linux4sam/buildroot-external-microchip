################################################################################
#
# Media files for EGT example applications
#
################################################################################


EGT_MEDIA_VERSION = 1.0
EGT_MEDIA_SITE = ftp://www.at91.com/pub/demo/media
EGT_MEDIA_SOURCE = egt-media-${EGT_MEDIA_VERSION}.tar.gz
EGT_MEDIA_LICENSE = Apache-2.0
EGT_MEDIA_INSTALL_TARGET = YES
EGT_MEDIA_INSTALL_STAGING = YES

define EGT_MEDIA_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/egt/examples
        $(call suitable-extractor, $(EGT_MEDIA_SOURCE)) \
		$(EGT_MEDIA_DL_DIR)/$(EGT_MEDIA_SOURCE) | \
                $(TAR) --strip-components=1 -C  $(TARGET_DIR)/usr/share/egt/examples $(TAR_OPTIONS) -
endef

$(eval $(generic-package))
