################################################################################
#
# Microchip PolarFire SoC AMP Examples
#
################################################################################

PIC64GX_AMP_EXAMPLES_VERSION = a094fe781e35c9ffe11c8f5c45718dbc1b145a6d
PIC64GX_AMP_EXAMPLES_SITE_METHOD = git
PIC64GX_AMP_EXAMPLES_SITE = https://github.com/pic64gx/pic64gx-zephyr-examples-wrapper.git
PIC64GX_AMP_EXAMPLES_GIT_SUBMODULES = YES
PIC64GX_AMP_EXAMPLES_INSTALL_TARGET = NO
PIC64GX_AMP_EXAMPLES_INSTALL_IMAGES = YES
PIC64GX_AMP_EXAMPLES_TARGET_DIR = /lib/firmware

PIC64GX_AMP_EXAMPLES_DEPENDENCIES = host-pkgconf \
				    host-python3 \
				    host-python-pip \
				    host-zephyr-sdk

ZEPHYR_MODULES = $(@D)/modules/lib/open-amp
ZEPHYR_MODULES += $(@D)/modules/hal/libmetal

PIC64GX_AMP_EXAMPLES_CONF_ENV = BOARD=pic64gx_curiosity_kit \
				ZEPHYR_BASE="$(@D)/zephyr" \
				ZEPHYR_MODULES="$(subst $(space),;,$(ZEPHYR_MODULES));" \
				ZEPHYR_SDK_INSTALL_DIR="$(HOST_DIR)/opt/zephyr-sdk"

PIC64GX_AMP_EXAMPLES_CONF_OPTS = -DCMAKE_C_FLAGS="" -DCMAKE_CXX_FLAGS="" -DCMAKE_ASM_FLAGS=""
PIC64GX_AMP_EXAMPLES_SUBDIR = pic64gx-soc/apps/amp_example_openamp
PIC64GX_AMP_EXAMPLES_SUPPORTS_IN_SOURCE_BUILD = NO

define PIC64GX_AMP_EXAMPLES_PYTHON_DEPENDENCIES
	$(HOST_DIR)/bin/python3 -m venv $(@D)/.venv; \
	source $(@D)/.venv/bin/activate; \
	$(HOST_DIR)/bin/python3 -m pip install --use-feature=truststore -r $(@D)/zephyr/scripts/requirements.txt;
endef

PIC64GX_AMP_EXAMPLES_PRE_CONFIGURE_HOOKS += PIC64GX_AMP_EXAMPLES_PYTHON_DEPENDENCIES

define PIC64GX_AMP_EXAMPLES_BUILD_CMDS
	source $(@D)/.venv/bin/activate; \
	PATH=$(BR_PATH):${PATH}; \
	$(MAKE) -C $(@D)/$(PIC64GX_AMP_EXAMPLES_SUBDIR)/buildroot-build;
	$(INSTALL) -D -m 775 $(@D)/$(PIC64GX_AMP_EXAMPLES_SUBDIR)/buildroot-build/zephyr/zephyr.elf \
		$(TARGET_DIR)$(PIC64GX_AMP_EXAMPLES_TARGET_DIR)/rproc-remote-context-fw;
endef

$(eval $(cmake-package))
