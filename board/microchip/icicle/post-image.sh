#!/usr/bin/env bash

cd ${BINARIES_DIR}
mkdir dts
cp -r microchip/ dts/
mkdir mpfs_icicle
mv *.dtbo mpfs_icicle/
gzip -9 Image -c > Image.gz
$HOST_DIR/bin/mkimage -f mpfs_icicle.its mpfs_icicle.itb
