################################################################################
#
# Media files for EGT example applications
#
################################################################################


EGT_MEDIA_EXTRA_VERSION = 1.1
EGT_MEDIA_EXTRA_SITE = https://files.linux4sam.org/pub/demo/media
EGT_MEDIA_EXTRA_SOURCE = egt-media-extras-${EGT_MEDIA_EXTRA_VERSION}.tar.gz
EGT_MEDIA_EXTRA_LICENSE = Apache-2.0
EGT_MEDIA_EXTRA_INSTALL_TARGET = YES
EGT_MEDIA_EXTRA_INSTALL_STAGING = YES

define EGT_MEDIA_EXTRA_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/egt/examples
        $(call suitable-extractor, $(EGT_MEDIA_EXTRA_SOURCE)) \
		$(EGT_MEDIA_EXTRA_DL_DIR)/$(EGT_MEDIA_EXTRA_SOURCE) | \
                $(TAR) --strip-components=1 -C  $(TARGET_DIR)/usr/share/egt/examples $(TAR_OPTIONS) -
endef

$(eval $(generic-package))
