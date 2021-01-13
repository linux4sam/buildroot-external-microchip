# AWS IoT Greengrass Core Software
GREENGRASS_CORE_VERSION = 1.11.0
GREENGRASS_CORE_SITE = https://d1onfpft10uf5o.cloudfront.net/greengrass-core/downloads/${GREENGRASS_CORE_VERSION}
GREENGRASS_CORE_SOURCE = greengrass-linux-armv7l-${GREENGRASS_CORE_VERSION}.tar.gz
GREENGRASS_CORE_LICENSE = Greengrass Core Software License Agreement
GREENGRASS_CORE_LICENSE_FILES = LICENSE
GREENGRASS_CORE_INSTALL_TARGET = YES

define GREENGRASS_CORE_INSTALL_TARGET_CMDS
        $(call suitable-extractor, $(GREENGRASS_CORE_SOURCE)) \
		$(GREENGRASS_CORE_DL_DIR)/$(GREENGRASS_CORE_SOURCE) | \
                $(TAR) --strip-components=0 -C  $(TARGET_DIR)/ $(TAR_OPTIONS) -
endef

$(eval $(generic-package))
