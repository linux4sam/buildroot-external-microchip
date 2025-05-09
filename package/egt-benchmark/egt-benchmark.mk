################################################################################
#
# egt benchmark
#
################################################################################

EGT_BENCHMARK_VERSION = 1.3
EGT_BENCHMARK_SITE = https://github.com/linux4sam/egt-benchmark.git
EGT_BENCHMARK_SITE_METHOD = git
EGT_BENCHMARK_GIT_SUBMODULES = YES
EGT_BENCHMARK_LICENSE = Apache-2.0
EGT_BENCHMARK_INSTALL_TARGET = YES
EGT_BENCHMARK_DEPENDENCIES = egt

EGT_BENCHMARK_CONF_OPTS = --program-prefix='egt_'

define EGT_BENCHMARK_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
EGT_BENCHMARK_POST_PATCH_HOOKS += EGT_BENCHMARK_RUN_AUTOGEN

$(eval $(autotools-package))
