################################################################################
#
# Microchip PIC64GX SoC Examples
#
################################################################################
PIC64GX_EXAMPLES_VERSION = v2025.06
PIC64GX_EXAMPLES_SITE = https://github.com/pic64gx/pic64gx-linux-examples.git
PIC64GX_EXAMPLES_SITE_METHOD = git
PIC64GX_EXAMPLES_LICENSE = MIT
PIC64GX_EXAMPLES_LICENSE_FILES = LICENSE
PIC64GX_EXAMPLES_DIRS += amp dt-overlays
PIC64GX_EXAMPLES_FILES += amp/rpmsg-pingpong/rpmsg-pingpong amp/rpmsg-tty-example/rpmsg-tty
PIC64GX_EXAMPLES_TARGET_DIR = /opt/microchip/

define PIC64GX_EXAMPLES_INSTALL_DIRS
	$(foreach d,$(PIC64GX_EXAMPLES_DIRS), \
		rm -rf $(TARGET_DIR)$(PIC64GX_EXAMPLES_TARGET_DIR)$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)$(PIC64GX_EXAMPLES_TARGET_DIR)$(d)$(sep))
endef

define PIC64GX_EXAMPLES_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)$(PIC64GX_EXAMPLES_TARGET_DIR)
	$(foreach d,$(PIC64GX_EXAMPLES_DIRS), \
		rm -rf $(TARGET_DIR)$(PIC64GX_EXAMPLES_TARGET_DIR)$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)$(PIC64GX_EXAMPLES_TARGET_DIR)$(d)$(sep))

	echo $(PIC64GX_EXAMPLES_FILES)
	$(foreach example_file,$(PIC64GX_EXAMPLES_FILES), \
		$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/$(dir $(example_file)) \
		$(notdir $(example_file)) CC=$(TARGET_CC); \
			$(INSTALL) -D -m 775 $(@D)/$(example_file) \
			$(TARGET_DIR)$(PIC64GX_EXAMPLES_TARGET_DIR)/$(dir $(example_file));)
endef

$(eval $(generic-package))
