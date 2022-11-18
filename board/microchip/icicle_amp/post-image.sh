#!/usr/bin/env bash

cd ${BINARIES_DIR}
mkdir dts
cp -r microchip/ dts/
mkdir mpfs_icicle_amp
cp *.dtbo mpfs_icicle_amp/
gzip -9 Image -c > Image.gz
$HOST_DIR/bin/mkimage -f mpfs_icicle_amp.its mpfs_icicle_amp.itb
