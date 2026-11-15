# Firmware feasibility and build gate

Reviewed: 2026-11-15.

## What the evidence says

- The router is reported as TL-WR845N (UN) V4.0, board ID `TL_WR845N-V4`, hardware ID `0x08450004`.
- The reported available firmware region is `0x3C0000` (3,932,160 bytes, approximately 3.75 MiB). This is a user-reported value and still needs confirmation from the live partition table.
- A community repository selects a `tplink_tl-wr845n-v4` profile, but its workflow clones a separate LEDE tree. This does not establish current upstream OpenWrt support.
- The community repository has an open report that an 8 MB Actions artifact was too large for the roughly 4 MB router. The issue discussion separately mentions a Padavan image archive. These are different artifacts and must not be confused.
- OpenWrt's own guidance says 4 MB flash devices are not supported by modern OpenWrt releases; its general current-device guidance recommends at least 8 MB flash. See https://openwrt.org/toh/start and https://openwrt.org/supported_devices.

## Build decision

**Do not start a standard modern OpenWrt build for this target yet.** The reported 28.96 MB RAM and 4 MB-class flash are below current OpenWrt's general recommended resource floor. Even if an old community target can compile, it may not fit, may be insecure/outdated, or may have a different flash map.

No upstream image is considered flashable until all of the following are verified:
1. Exact flash chip capacity and live `/proc/mtd` partition map.
2. Exact board name and device-tree compatible strings.
3. TP-Link factory header requirements, HWID, HWREV and maximum accepted image size.
4. Bootloader recovery method tested/documented for this exact hardware.
5. A reproducible build from a reviewed source commit.
6. Output image type and size independently checked, then checksum recorded.

## Safe next step

Use `scripts/collect-router-info.sh` on the router if shell access becomes available. It is read-only and does not modify flash or settings. If SSH is unavailable, the diagnostic data must be obtained through a supported local recovery/diagnostic method before proceeding. Do not enable WAN SSH or run flash-writing commands.

## No automatic release

This repository deliberately has no firmware build/release workflow at this stage. The compatibility gate is not a build. A CI job must not publish an image merely because compilation succeeds.
