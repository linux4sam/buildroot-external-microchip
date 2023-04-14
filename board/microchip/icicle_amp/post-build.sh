#!/usr/bin/env bash

if ! [ -d ${BR2_EXTERNAL_MCHP_PATH}/board/microchip/icicle_amp/rootfs-overlay/boot ]; then
	mkdir ${BR2_EXTERNAL_MCHP_PATH}/board/microchip/icicle_amp/rootfs-overlay/boot
fi
if [ -d ${BINARIES_DIR}/mpfs_icicle_amp ]; then
	cp ${BINARIES_DIR}/mpfs_icicle_amp/*.dtbo ${BR2_EXTERNAL_MCHP_PATH}/board/microchip/icicle_amp/rootfs-overlay/boot
else
	cp ${BINARIES_DIR}/*.dtbo ${BR2_EXTERNAL_MCHP_PATH}/board/microchip/icicle_amp/rootfs-overlay/boot
fi
