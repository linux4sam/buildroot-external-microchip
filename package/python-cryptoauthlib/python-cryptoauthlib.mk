################################################################################
#
# python-cryptoauthlib
#
################################################################################

PYTHON_CRYPTOAUTHLIB_VERSION = 20190304
PYTHON_CRYPTOAUTHLIB_SOURCE = cryptoauthlib-$(PYTHON_CRYPTOAUTHLIB_VERSION).tar.gz
PYTHON_CRYPTOAUTHLIB_SITE = https://pypi.python.org/packages/a6/b9/698260893ad00c0a730012c1ef7e22c7dc214d219af790069a57a48fbf0f
PYTHON_CRYPTOAUTHLIB_SETUP_TYPE = setuptools

$(eval $(python-package))
