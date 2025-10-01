################################################################################
#
# egt benchmark
#
################################################################################

EGT_BENCHMARK_VERSION = 1.4-rc1
EGT_BENCHMARK_SITE = https://github.com/linux4sam/egt-benchmark.git
EGT_BENCHMARK_SITE_METHOD = git
EGT_BENCHMARK_GIT_SUBMODULES = YES
EGT_BENCHMARK_LICENSE = Apache-2.0
EGT_BENCHMARK_INSTALL_TARGET = YES
EGT_BENCHMARK_DEPENDENCIES = egt

$(eval $(cmake-package))
