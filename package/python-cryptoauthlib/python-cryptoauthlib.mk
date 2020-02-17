################################################################################
#
# python-cryptoauthlib
#
################################################################################

PYTHON_CRYPTOAUTHLIB_VERSION = 20200208
PYTHON_CRYPTOAUTHLIB_SOURCE = cryptoauthlib-$(PYTHON_CRYPTOAUTHLIB_VERSION).tar.gz
PYTHON_CRYPTOAUTHLIB_SITE = https://files.pythonhosted.org/packages/1b/ed/da1709095abd203e37892f7183b68433382ce6a0f6129dfa0ac47e2ba85c
PYTHON_CRYPTOAUTHLIB_SETUP_TYPE = setuptools

$(eval $(python-package))
