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

# Create local commands to flash the board.
echo "./host/opt/sam-ba/sam-ba -x ${BR2_EXTERNAL_MCHP_PATH}/board/microchip/sama5d3_eds/nandflash-l4m_ACM0.qml" > ${BASE_DIR}/flash0
echo "./host/opt/sam-ba/sam-ba -x ${BR2_EXTERNAL_MCHP_PATH}/board/microchip/sama5d3_eds/nandflash-l4m_ACM1.qml" > ${BASE_DIR}/flash1
chmod +x ${BASE_DIR}/flash0
chmod +x ${BASE_DIR}/flash1
echo .
echo "Use ./flash1 to flash the build to the SAMA5D3 using ttyACM1."
echo .
