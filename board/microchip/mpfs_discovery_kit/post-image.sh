#!/bin/bash
set -e

GENIMAGE_CFG="$2"
MKIMAGE="${HOST_DIR}"/bin/mkimage

pushd "${BINARIES_DIR}"
mkdir -p dts
cp -r microchip/ dts/
gzip -9 Image -c > Image.gz
"${MKIMAGE}" -f mpfs_discovery_kit.its mpfs_discovery_kit.itb
popd
support/scripts/genimage.sh -c "${GENIMAGE_CFG}"

if [[ "${GENIMAGE_CFG}" == *"genimage_rootfs.cfg"* || "${GENIMAGE_CFG}" == *"genimage.cfg"* ]]; then
    "${HOST_DIR}"/bin/bmaptool create -o "${BINARIES_DIR}"/sdcard.bmap "${BINARIES_DIR}"/sdcard.img
fi
