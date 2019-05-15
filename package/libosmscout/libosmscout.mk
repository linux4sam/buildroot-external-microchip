################################################################################
#
# libosmscout
#
################################################################################

LIBOSMSCOUT_VERSION = f59235065decd6a318f7787581c0135febfbc5db
LIBOSMSCOUT_SITE = $(call github,Framstag,libosmscout,$(LIBOSMSCOUT_VERSION))
LIBOSMSCOUT_LICENSE = LGPL
LIBOSMSCOUT_LICENSE_FILES = LICENSE
LIBOSMSCOUT_INSTALL_STAGING = YES
LIBOSMSCOUT_DEPENDENCIES = cairo libpng libxml2 pango
LIBOSMSCOUT_CONF_OPTS = -DOSMSCOUT_BUILD_TESTS=OFF \
	-DOSMSCOUT_BUILD_DEMOS=OFF \
	-DOSMSCOUT_BUILD_TOOL_IMPORT=OFF \
	-DOSMSCOUT_BUILD_BINDING_JAVA=OFF \
	-DOSMSCOUT_BUILD_DOC_API=OFF \
	-DCMAKE_BUILD_TYPE=Release

$(eval $(cmake-package))
