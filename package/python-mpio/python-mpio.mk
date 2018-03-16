################################################################################
#
# python-mpio
#
################################################################################

PYTHON_MPIO_VERSION = d329ac453cc75d1483e516f7bfab6e8727675dc4
PYTHON_MPIO_SITE = $(call github,linux4sam,mpio,$(PYTHON_MPIO_VERSION))
PYTHON_MPIO_LICENSE = Apache-2.0, MIT
PYTHON_MPIO_LICENSE_FILES = LICENSE LICENSE.MIT
PYTHON_MPIO_SETUP_TYPE = setuptools

ifeq ($(BR2_PACKAGE_PYTHON),y)
PYTHON_MPIO_DEPENDENCIES += python
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
PYTHON_MPIO_DEPENDENCIES += python3
endif

$(eval $(python-package))
