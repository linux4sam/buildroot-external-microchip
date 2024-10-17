################################################################################
#
# wireless_kit_webpages
#
################################################################################

WIRELESS_KIT_PAGES_VERSION = main
WIRELESS_KIT_PAGES_SITE = https://github.com/MicrochipTech/wireless_kit_webpages.git
WIRELESS_KIT_PAGES_SITE_METHOD = git

define WIRELESS_KIT_PAGES_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/var/www/html
	$(INSTALL) -D -m 0755 $(@D)/* \
		$(TARGET_DIR)/var/www/html
endef

$(eval $(generic-package))
