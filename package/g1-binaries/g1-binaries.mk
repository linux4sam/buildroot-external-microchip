################################################################################
#
# g1-binaries
#
################################################################################

G1_BINARIES_VERSION = 1.2
G1_BINARIES_SITE = ftp://ftp.linux4sam.org/pub/demo/qtdemo
G1_BINARIES_SOURCE = g1-binaries-${G1_BINARIES_VERSION}.tar.gz
G1_BINARIES_LICENSE = PROPRIETARY
G1_BINARIES_INSTALL_TARGET = NO
G1_BINARIES_INSTALL_STAGING = YES

define G1_BINARIES_INSTALL_STAGING_CMDS
	cp -dpfr $(@D)/include/* $(STAGING_DIR)/usr/include/
	cp -dpfr $(@D)/lib/* $(STAGING_DIR)/usr/lib/
endef

$(eval $(generic-package))
