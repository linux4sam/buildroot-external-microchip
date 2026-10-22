################################################################################
#
# fontforge
#
################################################################################

FONTFORGE_VERSION = 20251009
FONTFORGE_SOURCE = fontforge-$(FONTFORGE_VERSION).tar.xz
FONTFORGE_SITE = https://github.com/fontforge/fontforge/releases/download/$(FONTFORGE_VERSION)
FONTFORGE_LICENSE = GPL-3.0, BSD-3-Clause
FONTFORGE_LICENSE_FILES = COPYING.gplv3 LICENSE

# Only a host build without GUI is provided, used to generate fonts from
# their sources with the fontforge Python scripting interface.
HOST_FONTFORGE_DEPENDENCIES = \
	host-freetype \
	host-gettext \
	host-libglib2 \
	host-libxml2 \
	host-python3 \
	host-zlib

# fontforge refuses to configure in its source directory
FONTFORGE_SUPPORTS_IN_SOURCE_BUILD = NO

HOST_FONTFORGE_CONF_OPTS = \
	-DENABLE_GUI=OFF \
	-DENABLE_DOCS=OFF \
	-DENABLE_NATIVE_SCRIPTING=ON \
	-DENABLE_PYTHON_SCRIPTING=ON \
	-DENABLE_PYTHON_EXTENSION=OFF \
	-DENABLE_LIBSPIRO=OFF \
	-DENABLE_LIBGIF=OFF \
	-DENABLE_LIBJPEG=OFF \
	-DENABLE_LIBPNG=OFF \
	-DENABLE_LIBREADLINE=OFF \
	-DENABLE_LIBTIFF=OFF \
	-DENABLE_WOFF2=OFF \
	-DENABLE_HARFBUZZ=OFF \
	-DPython3_EXECUTABLE=$(HOST_DIR)/bin/python3 \
	-DPython3_ROOT_DIR=$(HOST_DIR) \
	-DPython3_FIND_STRATEGY=LOCATION

$(eval $(host-cmake-package))
