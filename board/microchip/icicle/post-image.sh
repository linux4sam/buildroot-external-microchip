#!/usr/bin/env bash

BASE_DIR="$(pwd)"
BOARD_DIR="$(dirname $0)"
GENIMAGE_CFG="$2"

cd ${BINARIES_DIR}
mkdir -p dts
cp -r microchip/ dts/
mkdir -p mpfs_icicle
mv *.dtbo mpfs_icicle/
gzip -9 Image -c > Image.gz
$HOST_DIR/bin/mkimage -f mpfs_icicle.its mpfs_icicle.itb
${BASE_DIR}/support/scripts/genimage.sh -c ${GENIMAGE_CFG}

if [[ "${GENIMAGE_CFG}" == *"genimage_rootfs.cfg"* || "${GENIMAGE_CFG}" == *"genimage.cfg"* ]]; then
    $HOST_DIR/bin/bmaptool create -o ${BINARIES_DIR}/sdcard.bmap ${BINARIES_DIR}/sdcard.img
fi
