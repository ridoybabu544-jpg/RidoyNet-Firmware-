#!/usr/bin/env bash
set -euo pipefail

# Compatibility gate only. It does not compile or package firmware.
# A match must occur inside one upstream Device definition block.
HWID="0x08450004"
MODEL="TL-WR845N"
SOURCE_URL="https://raw.githubusercontent.com/openwrt/openwrt/main/target/linux/ramips/image/mt76x8.mk"
TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

echo "Checking upstream OpenWrt ramips/mt76x8 device definitions..."
curl --fail --location --silent --show-error "$SOURCE_URL" -o "$TMP_FILE"

if awk -v hwid="$HWID" -v model="$MODEL" '
  BEGIN { found=0; block="" }
  /^define Device\// { block=$0 ORS; next }
  { block=block $0 ORS }
  /^endef$/ {
    if (index(tolower(block), tolower(hwid)) && index(tolower(block), tolower(model))) found=1
    block=""
  }
  END { exit(found ? 0 : 1) }
' "$TMP_FILE"; then
  echo "One upstream Device block contains both the reported HWID and model."
  echo "This is only a preliminary match; DTS, flash layout, image format,"
  echo "and recovery compatibility still require independent verification."
  exit 0
fi

echo "::error::No upstream Device block matches model $MODEL and HWID $HWID."
echo "No firmware image will be built or published."
echo "Do not substitute a TL-WR840N/TL-WR841N image."
exit 1
