#!/usr/bin/env bash

if ! [ -d "${TARGET_DIR}"/boot ]; then
	mkdir "${TARGET_DIR}"/boot
fi
if [ -d "${BINARIES_DIR}"/pic64gx_curiosity_kit ]; then
	cp "${BINARIES_DIR}"/pic64gx_curiosity_kit/*.dtbo "${TARGET_DIR}"/boot
else
	cp "${BINARIES_DIR}"/*.dtbo "${TARGET_DIR}"/boot
fi
