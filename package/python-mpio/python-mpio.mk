################################################################################
#
# python-mpio
#
################################################################################

PYTHON_MPIO_VERSION = 1ae75341c8e81394ecc67edae596bba2b06e4bcd
PYTHON_MPIO_SITE = https://github.com/linux4sam/mpio
PYTHON_MPIO_SITE_METHOD = git
PYTHON_MPIO_LICENSE = Apache-2.0 (libraries), GPL-3.0-only (programs)
PYTHON_MPIO_LICENSE_FILES = LICENSE LICENSE.MIT iocontrol/LICENSE iocontrol/LICENSE.MIT
PYTHON_MPIO_SETUP_TYPE = setuptools
PYTHON_MPIO_DEPENDENCIES = python-pyqt5

define PYTHON_MPIO_INSTALL_MENU
        $(INSTALL) -m 0644 -D $(@D)/iocontrol/res/mpio.png \
                $(TARGET_DIR)/opt/ApplicationLauncher/applications/resources/mpio.png
        $(INSTALL) -m 0644 -D $(@D)/iocontrol/res/08-iocontrol.xml \
                $(TARGET_DIR)/opt/ApplicationLauncher/applications/xml/08-iocontrol.xml
        $(INSTALL) -m 0755 -D $(@D)/iocontrol/res/iocontrol.sh \
                $(TARGET_DIR)/opt/iocontrol/iocontrol.sh
endef

PYTHON_MPIO_POST_INSTALL_TARGET_HOOKS += PYTHON_MPIO_INSTALL_MENU

$(eval $(python-package))
