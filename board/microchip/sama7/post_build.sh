#!/bin/bash
# SPDX-License-Identifier: GPL-2.0

echo "conf=${BR2_CONFIG}, hd=${HOST_DIR}, sd=${STAGING_DIR}, td=${TARGET_DIR}, bd=${BUILD_DIR}, bindir=${BINARIES_DIR}, base=${BASE_DIR}"

if grep -Eq "^BR2_PACKAGE_CRYPTOAUTHLIB=y$" ${BR2_CONFIG}; then
echo "Copying libcryptoauth.so to python3.8/site-packages"
ln -sf /usr/lib/libcryptoauth.so ${TARGET_DIR}/usr/lib/python3.8/site-packages/cryptoauthlib/libcryptoauth.so

# cryptoauthlib device configuration
cp -p ${TARGET_DIR}/var/lib/cryptoauthlib/slot.conf.tmpl ${TARGET_DIR}/var/lib/cryptoauthlib/0.conf
fi

if grep -Eq "^BR2_PACKAGE_CRYPTOAUTHLIB_SAMA7G5EK=y$" ${BR2_CONFIG}; then
	sed -i "s/interface = .*/interface = i2c,0xC0,1/" ${TARGET_DIR}/var/lib/cryptoauthlib/0.conf
fi

if grep -Eq "^BR2_PACKAGE_GREENGRASS_CORE=y$" ${BR2_CONFIG}; then
	# Configure whether to use systemd or not
	GG_USESYSTEMD="no"
	if grep -Eq "^BR2_INIT_SYSTEMD=y$" ${BR2_CONFIG}; then
		GG_USESYSTEMD="yes"
	fi
	sed -i -e "/useSystemd/{s,\[yes|no],${GG_USESYSTEMD},g}" ${TARGET_DIR}/greengrass/config/config.json

	# Enable protection for hardlinks and symlinks
	if ! grep -qs 'protected_.*links' ${TARGET_DIR}/etc/sysctl.conf | grep -v '^#'; then
		cat >> ${TARGET_DIR}/etc/sysctl.conf <<-_EOF_
			# Greengrass: protect hardlinks/symlinks
			fs.protected_hardlinks = 1
			fs.protected_symlinks = 1
		_EOF_
	fi

	# Mount a cgroup hierarchy with all available subsystems
	if ! grep -qs '^cgroup' ${TARGET_DIR}/etc/fstab; then
		cat >> ${TARGET_DIR}/etc/fstab <<-_EOF_
			# Greengrass: mount cgroups
			cgroup    /sys/fs/cgroup    cgroup    defaults    0  0
		_EOF_
	fi
fi

# Mount debugfs on boot
echo "debugfs     /sys/kernel/debug debugfs defaults 0 0" >> ${TARGET_DIR}/etc/fstab

# Only run if libcamera IPA is enabled
if grep -Eq "^BR2_PACKAGE_LIBCAMERA_MCHP_IPA=y$" "${BR2_CONFIG}"; then
	echo "===== Re-signing IPA modules ====="

	# Extract libcamera-mchp version
	LIBCAMERA_MCHP_VERSION=$(grep -E '^LIBCAMERA_MCHP_VERSION\s*=' "${BR2_EXTERNAL_MCHP_PATH}/package/libcamera-mchp/"* | cut -d= -f2 | xargs)

	# Find the libcamera build directory
	LIBCAMERA_DIR="${BUILD_DIR}/libcamera-mchp-${LIBCAMERA_MCHP_VERSION}"

	if [ -d "${LIBCAMERA_DIR}" ]; then
		echo "Using libcamera-mchp version: ${LIBCAMERA_MCHP_VERSION}"
	fi

	if [ -d "${TARGET_DIR}/usr/lib/libcamera" ] && [ -n "${LIBCAMERA_DIR}" ]; then
		find "${TARGET_DIR}/usr/lib/libcamera" -name "ipa_*.so" \
			-exec "${LIBCAMERA_DIR}/src/ipa/ipa-sign-install.sh" \
			"${LIBCAMERA_DIR}/build/src/ipa-priv-key.pem" {} \; \
			-exec touch {}.sign \;
	fi

	echo "===== IPA modules signing complete ====="
fi
