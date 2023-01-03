#!/usr/bin/env bash

BASE_DIR="$(pwd)"
BOARD_DIR="$(dirname $0)"
GENIMAGE_CFG="$2"

cd ${BINARIES_DIR}
mkdir -p dts
cp -r microchip/ dts/
mkdir -p mpfs_icicle_amp
cp *.dtbo mpfs_icicle_amp/
gzip -9 Image -c > Image.gz
$HOST_DIR/bin/mkimage -f mpfs_icicle_amp.its mpfs_icicle_amp.itb
${BASE_DIR}/support/scripts/genimage.sh -c ${GENIMAGE_CFG}
