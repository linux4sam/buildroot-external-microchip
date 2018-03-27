################################################################################
#
# python-iocontrol
#
################################################################################

PYTHON_IOCONTROL_VERSION = v1.1
PYTHON_IOCONTROL_SITE = $(call github,linux4sam,iocontrol,$(PYTHON_IOCONTROL_VERSION))
PYTHON_IOCONTROL_LICENSE = GPL-3.0-only, MIT (QDarkStyleSheet)
PYTHON_IOCONTROL_LICENSE_FILES = LICENSE LICENSE.MIT
PYTHON_IOCONTROL_SETUP_TYPE = setuptools
PYTHON_IOCONTROL_DEPENDENCIES = python-pyqt5 python-mpio

define PYTHON_IOCONTROL_INSTALL_MENU
        $(INSTALL) -m 0644 -D $(@D)/res/iocontrol.png \
                $(TARGET_DIR)/opt/ApplicationLauncher/applications/resources/iocontrol.png
        $(INSTALL) -m 0644 -D $(@D)/res/08-iocontrol.xml \
                $(TARGET_DIR)/opt/ApplicationLauncher/applications/xml/08-iocontrol.xml
        $(INSTALL) -m 0755 -D $(@D)/res/iocontrol.sh \
                $(TARGET_DIR)/opt/iocontrol/iocontrol.sh
endef

PYTHON_IOCONTROL_POST_INSTALL_TARGET_HOOKS += PYTHON_IOCONTROL_INSTALL_MENU

$(eval $(python-package))
