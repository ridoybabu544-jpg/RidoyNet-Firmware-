#!/usr/bin/env bash
set -euo pipefail

# This is a compatibility gate, not a firmware builder.
# It deliberately refuses to build or package an image unless upstream
# OpenWrt contains an exact device definition for the reported board ID.
HWID="0x08450004"
MODEL="TL-WR845N"
VARIANT="v4"
SOURCE_URL="https://raw.githubusercontent.com/openwrt/openwrt/main/target/linux/ramips/image/mt76x8.mk"
TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

echo "Checking upstream OpenWrt ramips/mt76x8 device definitions..."
curl --fail --location --silent --show-error "$SOURCE_URL" -o "$TMP_FILE"

if grep -Fqi "$HWID" "$TMP_FILE" && grep -Fqi "$MODEL" "$TMP_FILE"; then
  echo "An upstream entry contains both the reported HWID and model."
  echo "This is only a preliminary match; DTS, flash layout, image format,"
  echo "and recovery compatibility still require independent verification."
  exit 0
fi

echo "::error::No exact upstream TL-WR845N V4 entry matching HWID $HWID was found."
echo "No firmware image will be built or published."
echo "Do not substitute a TL-WR840N/TL-WR841N image."
exit 1
