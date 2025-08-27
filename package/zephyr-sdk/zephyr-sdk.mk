################################################################################
#
# Zephyr SDK
#
################################################################################
HOST_ZEPHYR_SDK_VERSION = 0.17.0
HOST_ZEPHYR_SDK_SITE = https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v$(HOST_ZEPHYR_SDK_VERSION)
HOST_ZEPHYR_SDK_SOURCE = zephyr-sdk-$(HOST_ZEPHYR_SDK_VERSION)_linux-$(HOSTARCH)_minimal.tar.xz
HOST_ZEPHYR_SDK_EXTRA_DOWNLOADS =  https://raw.githubusercontent.com/zephyrproject-rtos/sdk-ng/refs/tags/v$(HOST_ZEPHYR_SDK_VERSION)/LICENSE
HOST_ZEPHYR_SDK_LICENSE = Apache-2.0
HOST_ZEPHYR_SDK_LICENSE_FILES = LICENSE

HOST_ZEPHYR_SDK_DEPENDENCIES = host-cmake

HOST_ZEPHYR_SDK_INSTALL_DIR = $(HOST_DIR)/opt/zephyr-sdk/zephyr-sdk-$(HOST_ZEPHYR_SDK_VERSION)

define HOST_ZEPHYR_SDK_INSTALL_CMDS
	rm -rf $(HOST_DIR)/opt/zephyr-sdk/zephyr-sdk
	mkdir -p $(HOST_ZEPHYR_SDK_INSTALL_DIR)
	cp -rf $(@D)/* $(HOST_ZEPHYR_SDK_INSTALL_DIR)/

	# Install host tools
	PATH=$(BR_PATH); $(HOST_ZEPHYR_SDK_INSTALL_DIR)/setup.sh -t $(ARCH)-zephyr-elf
endef

$(eval $(host-generic-package))
