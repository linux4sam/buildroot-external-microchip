################################################################################
#
# wifi_capi
#
# https://github.com/Wi-FiTestSuite/Wi-FiTestSuite-Linux-DUT OR
# https://www.wi-fi.org/members/certification-testing/wi-fi-test-suite
#
################################################################################


WIFI_CAPI_VERSION = 9.2.0
WIFI_CAPI_SOURCE = Wi-FiTestSuite_Sample_DUT_Code-Linux_v$(WIFI_CAPI_VERSION).tar.gz
WIFI_CAPI_PATCH = wifi_capi-0001-code_changes_$(WIFI_CAPI_VERSION).patch
WIFI_CAPI_PATCH_2 = wifi_capi-0002-code_changes_$(WIFI_CAPI_VERSION).patch
WIFI_CAPI_SITE = $(TOPDIR)/package/wifi_capi
WIFI_CAPI_SITE_METHOD = local
WIFI_CAPI_LICENSE = copyright (c) 2015 Wi-Fi Alliance
WIFI_CAPI_LICENSE_FILES = LICENSE.txt
WIFI_CAPI_INSTALL_TARGET = YES
WIFI_CAPI_ACTUAL_SOURCE_SITE = https://www.wi-fi.org/members/certification-testing/wi-fi-test-suite
WIFI_CAPI_DEPENDENCIES = libglib2 wpa_supplicant


define WIFI_CAPI_CONFIGURE_CMDS
    $(info "WIFI_CAPI_CONFIGURE_CMDS")
    $(TAR) -xvf  $(WIFI_CAPI_SITE)/$(WIFI_CAPI_SOURCE) -C $(@D)	
    sleep 2
    $(info "WIFI_CAPI_CONFIGURE_CMDS applying patch")
    patch -p1 -i $(@D)/$(WIFI_CAPI_PATCH) -d $(@D)/Wi-FiTestSuite_Sample_DUT_Code-Linux_v$(WIFI_CAPI_VERSION)
    patch -p1 -i $(@D)/$(WIFI_CAPI_PATCH_2) -d $(@D)/Wi-FiTestSuite_Sample_DUT_Code-Linux_v$(WIFI_CAPI_VERSION)
endef

define WIFI_CAPI_BUILD_CMDS
    $(info "WIFI_CAPI_BUILD_CMDS")
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/Wi-FiTestSuite_Sample_DUT_Code-Linux_v$(WIFI_CAPI_VERSION) all
endef

define WIFI_CAPI_INSTALL_STAGING_CMDS
    $(info "WIFI_CAPI_INSTALL_STAGING_CMDS")
endef

define WIFI_CAPI_INSTALL_TARGET_CMDS
    $(info "WIFI_CAPI_INSTALL_TARGET_CMDS")
    $(INSTALL) -D -m 0755 $(@D)/Wi-FiTestSuite_Sample_DUT_Code-Linux_v$(WIFI_CAPI_VERSION)/dut/wfa_dut $(TARGET_DIR)/usr/sbin
    $(INSTALL) -D -m 0755 $(@D)/Wi-FiTestSuite_Sample_DUT_Code-Linux_v$(WIFI_CAPI_VERSION)/ca/wfa_ca $(TARGET_DIR)/usr/sbin
    $(INSTALL) -D -m 0755 $(@D)/Wi-FiTestSuite_Sample_DUT_Code-Linux_v$(WIFI_CAPI_VERSION)/scripts/*.sh $(TARGET_DIR)/usr/sbin
    mkdir -p $(TARGET_DIR)/etc/WfaEndpoint
    cp -f $(@D)/Wi-FiTestSuite_Sample_DUT_Code-Linux_v$(WIFI_CAPI_VERSION)/wfa_cli.txt $(TARGET_DIR)/etc/WfaEndpoint
endef

$(eval $(generic-package))
