#!/bin/bash
# SPDX-License-Identifier: GPL-2.0

echo "conf=${BR2_CONFIG}, hd=${HOST_DIR}, sd=${STAGING_DIR}, td=${TARGET_DIR}, bd=${BUILD_DIR}, bindir=${BINARIES_DIR}, base=${BASE_DIR}"
echo "Copying libcryptoauth.so to python2.7/site-packages"

ln -sf /usr/lib/libcryptoauth.so ${TARGET_DIR}/usr/lib/python3.8/site-packages/cryptoauthlib/libcryptoauth.so
