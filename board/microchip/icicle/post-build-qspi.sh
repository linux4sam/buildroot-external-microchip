#!/usr/bin/env bash

if ! [ -d "${TARGET_DIR}"/boot ]; then
	mkdir "${TARGET_DIR}"/boot
fi

cp "${BINARIES_DIR}"/boot.scr "${TARGET_DIR}"/boot/boot.scr
cp "${BINARIES_DIR}"/mpfs_icicle.itb "${TARGET_DIR}"/boot
