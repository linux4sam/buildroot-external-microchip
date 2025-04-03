################################################################################
#
# cryptoauthlib
#
################################################################################

CRYPTOAUTHLIB_VERSION = v3.7.7
CRYPTOAUTHLIB_SITE = $(call github,MicrochipTech,cryptoauthlib,$(CRYPTOAUTHLIB_VERSION))
CRYPTOAUTHLIB_INSTALL_STAGING = YES
CRYPTOAUTHLIB_LICENSE = LGPL-2.1
CRYPTOAUTHLIB_LICENSE_FILES = COPYING

CRYPTOAUTHLIB_CONF_OPTS += \
	-DATCA_HAL_I2C=ON \
	-DATCA_PKCS11=ON \
	-DATCA_OPENSSL=ON \
	-DATCA_ATECC508A_SUPPORT=ON \
	-DATCA_ATECC608_SUPPORT=ON \
	-DATCA_BUILD_SHARED_LIBS=ON \
	-DATCA_TNGTLS_SUPPORT=ON \
	-DATCA_TNGLORA_SUPPORT=ON \
	-DATCA_TFLEX_SUPPORT=ON \
	-DATCA_USE_ATCAB_FUNCTIONS=ON

$(eval $(cmake-package))

