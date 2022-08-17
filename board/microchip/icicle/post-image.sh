#!/usr/bin/env bash

cd ${BINARIES_DIR}
mkdir dts
cp -r microchip/ dts/
${BUILD_DIR}/uboot-2022.01/tools/mkimage -f mpfs_icicle.its mpfs_icicle.itb
