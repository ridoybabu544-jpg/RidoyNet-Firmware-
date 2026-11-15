#!/bin/sh
# RidoyNet read-only router diagnostics for TP-Link TL-WR845N V4.
# This script does not write to flash, change settings, or restart services.
set -u

OUT="${1:-/tmp/ridoynet-router-diagnostics.txt}"
umask 077
{
  echo "RidoyNet read-only diagnostics"
  date 2>/dev/null || true
  echo
  echo "== board/system =="
  for f in /tmp/sysinfo/board_name /tmp/sysinfo/model /proc/cpuinfo /proc/meminfo /proc/cmdline; do
    if [ -r "$f" ]; then
      echo "--- $f"
      cat "$f"
    fi
  done
  echo
  echo "== flash partitions (/proc/mtd) =="
  if [ -r /proc/mtd ]; then cat /proc/mtd; else echo "not available"; fi
  echo
  echo "== device tree compatible =="
  for f in /proc/device-tree/compatible /sys/firmware/devicetree/base/compatible; do
    if [ -r "$f" ]; then
      echo "--- $f"
      tr '\000' '\n' < "$f"
    fi
  done
  echo
  echo "== mount table =="
  cat /proc/mounts 2>/dev/null || true
  echo
  echo "== flash utilities present (no write commands executed) =="
  for c in mtd flash_erase nandwrite sysupgrade; do
    command -v "$c" 2>/dev/null || true
  done
  echo
  echo "== recent kernel log =="
  dmesg 2>/dev/null | tail -n 100 || true
} > "$OUT" 2>&1

chmod 600 "$OUT" 2>/dev/null || true
echo "Saved read-only diagnostics to: $OUT"
echo "Review and redact MAC addresses, serial numbers, and public IPs before sharing."
