# Exact-device source inventory — 2026-11-15

## Scope

This inventory checks public GitHub source evidence for the exact TP-Link TL-WR845N V4 profile. It does not import or reuse any Padavan source, code, image, or branding.

## OpenWrt-style community repositories

### mhkanon/Openwrt-TL-WR845N-V4

- Repository: https://github.com/mhkanon/Openwrt-TL-WR845N-V4
- Default branch tree at commit `43b48b799fdf87a659120eba296a27f5659bc318`: https://github.com/mhkanon/Openwrt-TL-WR845N-V4/tree/43b48b799fdf87a659120eba296a27f5659bc318
- The inspected tree contains `.config`, README, build workflow and helper scripts.
- The `.config` selects `CONFIG_TARGET_ramips_mt76x8_DEVICE_tplink_tl-wr845n-v4=y`.
- The inspected repository tree does not contain a checked-in device-tree source, board DTS, image recipe, or OpenWrt source patch implementing that profile.
- Its workflow clones a floating `master` branch from `coolsnowwolf/lede`. The currently fetched `target/linux/ramips/image/mt76x8.mk` from that branch does not contain the selected profile name.
- Consequently, the checked-in configuration alone is not a reproducible device port and does not establish a successful build for the exact hardware.

### xxxpabloxxx/WR845N

- GitHub search finds a configuration file selecting the same profile: https://github.com/xxxpabloxxx/WR845N
- A profile selection file is not the underlying device implementation. No matching DTS/image-recipe source was verified in this review.

## Upstream status

The current upstream OpenWrt ramips/mt76x8 image definition file is:
https://github.com/openwrt/openwrt/blob/main/target/linux/ramips/image/mt76x8.mk

No exact TL-WR845N V4 profile was verified there. Do not substitute TL-WR840N or TL-WR841N profiles.

## Engineering decision

Do not build a firmware image from a profile-only configuration. A real port requires inspectable source for:
- board DTS and flash partition map;
- Ethernet switch / PHY and Wi-Fi calibration/EEPROM handling;
- LED, button, MAC-address and network setup;
- TP-Link factory image header and hardware revision validation;
- exact partition-size checks and a documented recovery route.

The reported `0x3C0000` image region is only user-reported and must be confirmed against the live router. A 4 MB-class flash and approximately 29 MB RAM are also severe constraints for modern OpenWrt.

## Current outcome

**No reproducible exact-device OpenWrt source port has been established. No Ridoy.Net firmware image has been built.** This is a source audit, not a release or flash recommendation.
