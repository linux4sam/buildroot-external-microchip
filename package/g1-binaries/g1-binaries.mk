################################################################################
#
# g1-binaries
#
################################################################################

G1_BINARIES_VERSION = cb81273566b7c1609ce27bbf38af8042946472f7
G1_BINARIES_SITE = https://github.com/linux4sam/g1_decoder.git
G1_BINARIES_SITE_METHOD = git
G1_BINARIES_LICENSE = BSD
G1_BINARIES_INSTALL_TARGET = YES
G1_BINARIES_INSTALL_STAGING = YES

define G1_BINARIES_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
G1_BINARIES_POST_PATCH_HOOKS += G1_BINARIES_RUN_AUTOGEN

$(eval $(autotools-package))
