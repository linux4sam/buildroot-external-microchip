#!/bin/sh
# SPDX-License-Identifier: GPL-2.0

# Setup Cgroups
mount -t cgroup -o all cgroup /sys/fs/cgroup
echo 1 > /sys/fs/cgroup/memory.use_hierarchy

# Enable link protection
/etc/init.d/S02sysctl start
sysctl -w fs.protected_hardlinks=1
sysctl -w fs.protected_symlinks=1

/greengrass/ggc/core/greengrassd start
