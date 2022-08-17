################################################################################
 #
 # Microchip PolarFire SoC Examples
 #
################################################################################
MPFS_EXAMPLES_VERSION = 91aa8b53f3a50c5dfd85a48feff36a5815fe5f49
MPFS_EXAMPLES_SITE = https://github.com/polarfire-soc/polarfire-soc-linux-examples.git
MPFS_EXAMPLES_SITE_METHOD = git
MPFS_EXAMPLES_LICENSE = MIT
MPFS_EXAMPLES_LICENSE_FILES = LICENSE


EXAMPLE_DIRS += amp can gpio system-services ethernet fpga-fabric-interfaces dma pdma
EXAMPLE_FILES += amp/rpmsg-pingpong/rpmsg-pingpong amp/rpmsg-tty-example/rpmsg-tty can/uio-can-example gpio/gpiod-test gpio/gpio-event system-services/system-services-example system-services/signature-verification-demo fpga-fabric-interfaces/lsram/uio-lsram-read-write dma/uio-dma-interrupt pdma/pdma-ex
EXAMPLE_TARGET_DIR = /opt/microchip/

define MPFS_EXAMPLES_INSTALL_DIRS
	$(foreach d,$(EXAMPLE_DIRS), \
		rm -rf $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)$(d)$(sep))
endef

define MPFS_EXAMPLES_INSTALL_TARGET_CMDS
        $(INSTALL) -d $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)
	$(foreach d,$(EXAMPLE_DIRS), \
		rm -rf $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)$(d)$(sep))

        echo $(EXAMPLE_FILES)
	$(foreach example_file,$(EXAMPLE_FILES), \
		$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/$(dir $(example_file)) $(notdir $(example_file)) CC=$(TARGET_CC); \
                $(INSTALL) -D -m 775 $(@D)/$(example_file) $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)/$(dir $(example_file));)

	ln -sf $(EXAMPLE_TARGET_DIR)/ethernet/iio-http-server  $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)/iiohttpserver

endef

define MPFS_EXAMPLES_INSTALL_INIT_SYSTEMD
$(INSTALL) -D -m 644 $(@D)/ethernet/iio-http-server/collection/collectdiio.service \
        $(TARGET_DIR)/usr/lib/systemd/system/collectdiio.service
endef

define MPFS_EXAMPLES_INSTALL_INIT_SYSV
# iiohttp server
$(INSTALL) -D -m 775 $(@D)/ethernet/iio-http-server/collection/collectdiio.busybox \
        $(TARGET_DIR)/etc/init.d/collectdiio
# busy box init requires script renames
mv $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)ethernet/iio-http-server/run.{sh,systemd}
mv $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)ethernet/iio-http-server/run.{busybox,sh}
chmod +x $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)ethernet/iio-http-server/run.sh

endef

$(eval $(generic-package))
