include $(sort $(wildcard $(BR2_EXTERNAL_MCHP_PATH)/package/*/*.mk))

# add libm2d as a dependency of cairo when it is enabled
ifeq ($(BR2_PACKAGE_LIBM2D),y)
CAIRO_DEPENDENCIES += libm2d
$(CAIRO_TARGET_CONFIGURE): | libm2d
CAIRO_CONF_OPTS += --enable-gfx2d
endif
