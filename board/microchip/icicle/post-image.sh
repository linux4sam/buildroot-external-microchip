#!/usr/bin/env bash

cd ${BINARIES_DIR}
mkdir dts
cp -r microchip/ dts/
mkdir mpfs_icicle
mv *.dtbo mpfs_icicle/
${BUILD_DIR}/uboot-mpfs-uboot-2022.01/tools/mkimage -f mpfs_icicle.its mpfs_icicle.itb
