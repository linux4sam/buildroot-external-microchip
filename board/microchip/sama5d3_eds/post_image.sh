#!/bin/sh

echo .
echo "*** post-image script ***"
# echo "conf=${BR2_CONFIG}"
# echo "hd=${HOST_DIR}"
# echo "sd=${STAGING_DIR}"
# echo "td=${TARGET_DIR}"
# echo "bd=${BUILD_DIR}"
# echo "bindir=${BINARIES_DIR}"
# echo "base=${BASE_DIR}"
# echo "BR2_EXTERNAL_MCHP_PATH=${BR2_EXTERNAL_MCHP_PATH}"

cp ${BR2_EXTERNAL_MCHP_PATH}/board/microchip/sama5d3_eds/nandflash-l4m.qml ${BINARIES_DIR}/nandflash-l4m.qml

echo ""
echo "To program the onboard flash, ..."
echo "    sam-ba.exe -x nandflash-l4m.qml"
echo ""
