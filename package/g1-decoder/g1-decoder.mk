################################################################################
#
# g1-decoder for sama5d4 soc
#
################################################################################

G1_DECODER_VERSION = g1-decoder_1.0
G1_DECODER_SITE = https://github.com/linux4sam/g1_decoder.git
G1_DECODER_SITE_METHOD = git
G1_DECODER_LICENSE = BSD
G1_DECODER_INSTALL_TARGET = YES
G1_DECODER_INSTALL_STAGING = YES

define G1_DECODER_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
G1_DECODER_POST_PATCH_HOOKS += G1_DECODER_RUN_AUTOGEN

$(eval $(autotools-package))
