#!/bin/sh

set -eu

config="${TARGET_DIR}/etc/linuxptp.cfg"

[ -f "${config}" ] || exit 0

if grep -q '^ptp_minor_version[[:space:]]' "${config}"; then
	sed -i 's/^ptp_minor_version[[:space:]].*/ptp_minor_version\t0/' "${config}"
else
	sed -i '/^\[global\]$/a ptp_minor_version\t0' "${config}"
fi
