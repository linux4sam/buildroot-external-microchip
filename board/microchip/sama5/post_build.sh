#!/bin/bash
# SPDX-License-Identifier: GPL-2.0

echo "conf=${BR2_CONFIG}, hd=${HOST_DIR}, sd=${STAGING_DIR}, td=${TARGET_DIR}, bd=${BUILD_DIR}, bindir=${BINARIES_DIR}, base=${BASE_DIR}"

if grep -Eq "^BR2_PACKAGE_CRYPTOAUTHLIB=y$" ${BR2_CONFIG}; then
echo "Copying libcryptoauth.so to python3.8/site-packages"
ln -sf /usr/lib/libcryptoauth.so ${TARGET_DIR}/usr/lib/python3.8/site-packages/cryptoauthlib/libcryptoauth.so

# cryptoauthlib device configuration
cp -p ${TARGET_DIR}/var/lib/cryptoauthlib/slot.conf.tmpl ${TARGET_DIR}/var/lib/cryptoauthlib/0.conf
fi

if grep -Eq "^BR2_PACKAGE_CRYPTOAUTHLIB_SAMA5D2_XPLAINED=y$" ${BR2_CONFIG}; then
	sed -i "s/interface = .*/interface = i2c,0xC0,2/" ${TARGET_DIR}/var/lib/cryptoauthlib/0.conf
elif grep -Eq "^BR2_PACKAGE_CRYPTOAUTHLIB_SAMA5D2_PTC_EK=y$" ${BR2_CONFIG}; then
	sed -i "s/interface = .*/interface = i2c,0xC0,1/" ${TARGET_DIR}/var/lib/cryptoauthlib/0.conf
elif grep -Eq "^BR2_PACKAGE_CRYPTOAUTHLIB_SAMA5D2_ICP=y$" ${BR2_CONFIG}; then
	sed -i "s/interface = .*/interface = i2c,0xC0,1/" ${TARGET_DIR}/var/lib/cryptoauthlib/0.conf
elif grep -Eq "^BR2_PACKAGE_CRYPTOAUTHLIB_SAMA5D27_SOM1_EK=y$" ${BR2_CONFIG}; then
	sed -i "s/interface = .*/interface = i2c,0xC0,0/" ${TARGET_DIR}/var/lib/cryptoauthlib/0.conf
elif grep -Eq "^BR2_PACKAGE_CRYPTOAUTHLIB_SAMA5D27_WLSOM1_EK=y$" ${BR2_CONFIG}; then
	sed -i "s/interface = .*/interface = i2c,0x6A,0/" ${TARGET_DIR}/var/lib/cryptoauthlib/0.conf
elif grep -Eq "^BR2_PACKAGE_CRYPTOAUTHLIB_SAMA5D29_CURIOSITY=y$" ${BR2_CONFIG}; then
	sed -i "s/interface = .*/interface = i2c,0x6A,1/" ${TARGET_DIR}/var/lib/cryptoauthlib/0.conf
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
