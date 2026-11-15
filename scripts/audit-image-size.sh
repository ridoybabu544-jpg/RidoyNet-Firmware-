#!/usr/bin/env bash
set -euo pipefail

# Preliminary size-only audit. This does NOT establish flash compatibility.
# Default is the user-reported 0x3C0000 region; override only after verifying
# the live partition map and vendor image-header accounting.
MAX_BYTES="${MAX_IMAGE_BYTES:-3932160}"

if [[ $# -ne 1 || ! -f "$1" ]]; then
  echo "Usage: $0 <firmware-image>" >&2
  exit 2
fi
if ! [[ "$MAX_BYTES" =~ ^[0-9]+$ ]] || (( MAX_BYTES <= 0 )); then
  echo "MAX_IMAGE_BYTES must be a positive integer" >&2
  exit 2
fi

FILE="$1"
SIZE="$(wc -c < "$FILE" | tr -d ' ')"
SHA256="$(sha256sum "$FILE" | awk '{print $1}')"

printf 'File: %s\nSize: %s bytes\nPreliminary limit: %s bytes\nSHA256: %s\n' \
  "$FILE" "$SIZE" "$MAX_BYTES" "$SHA256"

if (( SIZE > MAX_BYTES )); then
  echo "FAIL: image exceeds the preliminary reported size limit." >&2
  exit 1
fi

echo "PASS: size is below the preliminary limit only."
echo "WARNING: this does not verify image header, partition layout, HWID/HWREV,"
echo "device-tree compatibility, bootloader acceptance, or recovery safety."
