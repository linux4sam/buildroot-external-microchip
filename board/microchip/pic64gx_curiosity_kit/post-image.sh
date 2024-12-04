#!/bin/bash
set -e

GENIMAGE_CFG="$2"
MKIMAGE="${HOST_DIR}"/bin/mkimage

pushd "${BINARIES_DIR}"
mkdir -p dts
cp -r microchip/ dts/
mkdir -p pic64gx_curiosity_kit
for file in ./*.dtbo
do
  if [ -e "$file" ]
  then
    mv "$file" pic64gx_curiosity_kit/
  fi
done
gzip -9 Image -c > Image.gz
"${MKIMAGE}" -f pic64gx_curiosity_kit.its pic64gx_curiosity_kit.itb
popd
support/scripts/genimage.sh -c "${GENIMAGE_CFG}"

if [[ "${GENIMAGE_CFG}" == *"genimage_rootfs.cfg"* || "${GENIMAGE_CFG}" == *"genimage.cfg"* ]]; then
    "${HOST_DIR}"/bin/bmaptool create -o "${BINARIES_DIR}"/sdcard.bmap "${BINARIES_DIR}"/sdcard.img
fi
