UDMABUF_VERSION = v5.4.2
UDMABUF_SITE = https://github.com/ikwzm/udmabuf.git
UDMABUF_SITE_METHOD = git
UDMABUF_SITE_BRANCH = master
UDMABUF_SITE_COMMIT = cff954eb557db73a5196f12d16c687c5cb96eb32

UDMABUF_LICENSE = BSD-2-Clause
UDMABUF_LICENSE_FILES = LICENSE

UDMABUF_MODULE_SUBDIRS = .
UDMABUF_MODULE_MAKE_OPTS = CONFIG_U_DMA_BUF=m
UDMABUF_DEPENDENCIES = linux

define UDMABUF_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 \
		$(BR2_EXTERNAL_MCHP_PATH)/package/udmabuf/udmabuf.modules \
		$(TARGET_DIR)/etc/modules-load.d/udmabuf.conf
endef

$(eval $(kernel-module))
$(eval $(generic-package))