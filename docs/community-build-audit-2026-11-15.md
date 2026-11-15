# Community build audit — 2026-11-15

## Summary

A device-specific community repository exists for the exact marketing model **TP-Link TL-WR845N V4**, but the evidence inspected does **not** yet provide a reproducible, independently verified OpenWrt image recipe for this project.

## Evidence inspected

1. Community project: https://github.com/mhkanon/Openwrt-TL-WR845N-V4
2. Its checked-in `.config` selects:
   - `CONFIG_TARGET_ramips_mt76x8=y`
   - `CONFIG_TARGET_ramips_mt76x8_DEVICE_tplink_tl-wr845n-v4=y`
   - `CONFIG_TARGET_PROFILE="DEVICE_tplink_tl-wr845n-v4"`
3. Its workflow at https://github.com/mhkanon/Openwrt-TL-WR845N-V4/blob/master/.github/workflows/build-openwrt.yml clones the floating `master` branch of https://github.com/coolsnowwolf/lede (not a pinned commit).
4. The currently fetched `target/linux/ramips/image/mt76x8.mk` from that source branch does not contain the string `tplink_tl-wr845n-v4`. Therefore the checked-in profile selection and the workflow's current floating source are not demonstrably aligned. The build recipe is not reproducible as checked.
5. The current upstream OpenWrt mt76x8 device list also does not provide a TL-WR845N definition matching HWID `0x08450004`: https://github.com/openwrt/openwrt/blob/main/target/linux/ramips/image/mt76x8.mk
6. Community issue #2 reports an approximately 4 MB device and an 8 MB Actions artifact that would not fit: https://github.com/mhkanon/Openwrt-TL-WR845N-V4/issues/2
7. The same issue mentions a separate Padavan archive and later user reports of operation. That is not an OpenWrt build result and is deliberately not used as the basis of this Ridoy.Net project.

## Consequence

- Do not copy a WR840N/WR841N device profile.
- Do not build against an unpinned source branch while the selected device profile cannot be found in that branch.
- Do not treat a community release or a small-looking ZIP as proof of exact hardware compatibility.
- Do not publish or flash a binary based on this evidence.

## What is still needed

A source commit that actually contains the exact TL-WR845N V4 device profile, its matching device-tree source and board setup, plus primary evidence for the TP-Link image header, flash partition map, maximum accepted image size, and a verified recovery route. The reported HWID `0x08450004` must be confirmed against the actual stock image/header or bootloader data; the marketing model/profile string alone is not enough.

## Current Ridoy.Net build status

**No flashable firmware image has been built.** The project remains in the compatibility and source-verification stage. This audit adds evidence; it does not change the flash-safety status.
