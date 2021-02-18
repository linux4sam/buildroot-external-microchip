################################################################################
#
# gnuplot
#
################################################################################

PLPLOT_VERSION = plplot-5.15.0
PLPLOT_SITE = git://git.code.sf.net/p/plplot/plplot
PLPLOT_LICENSE = GPL
PLPLOT_LICENSE_FILES = Copyright
PLPLOT_INSTALL_STAGING = YES
PLPLOT_SUPPORTS_IN_SOURCE_BUILD = NO

PLPLOT_DEPENDENCIES = \
    host-pkgconf

ifeq ($(BR2_PACKAGE_CAIRO),y)
PLPLOT_DEPENDENCIES += cairo
endif

ifeq ($(BR2_PACKAGE_PLPLOT_EXTCAIRO_DEVICE),y)
PLPLOT_CONF_OPTS += -DDEFAULT_NO_CAIRO_DEVICES=OFF
PLPLOT_DEPENDENCIES += pango
endif

ifeq ($(BR2_PACKAGE_FONTCONFIG),y)
PLPLOT_DEPENDENCIES += fontconfig
endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
PLPLOT_DEPENDENCIES += freetype
endif

PLPLOT_CONF_OPTS += \
	-DDEFAULT_NO_BINDINGS=ON \
	-DENABLE_cxx=ON \
	-DNaNAwareCCompiler=ON \
	-DPL_DOUBLE=OFF \
	-DCMAKE_NATIVE_BINARY_DIR=${@D}/buildroot-build \
	-DCMAKE_VERBOSE_MAKEFILE=ON

# This fix is avoid configure error of missing genereated files hence manually copying
# these generated files from host
define PLPLOT_COPY_GEN_FILES
	mkdir -p ${@D}/buildroot-build
	mkdir -p ${@D}/buildroot-build/lib/qsastime
	mkdir -p ${@D}/buildroot-build/include
	cp -avf $(PLPLOT_PKGDIR)/deltaT.h  ${@D}/buildroot-build/lib/qsastime/
	cp -avf $(PLPLOT_PKGDIR)/tai-utc.h ${@D}/buildroot-build/lib/qsastime/
	cp -avf $(PLPLOT_PKGDIR)/plhershey-unicode.h ${@D}/buildroot-build/include/
endef
PLPLOT_PRE_CONFIGURE_HOOKS += PLPLOT_COPY_GEN_FILES

$(eval $(cmake-package))
