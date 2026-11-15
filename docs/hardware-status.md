# Hardware status — TP-Link TL-WR845N (UN) V4.0

This page records values already supplied for this project. They are reference data, not a substitute for reading the live partition table and board identifiers.

| Item | Reported value |
|---|---|
| Model | TP-Link TL-WR845N (UN) V4.0 |
| Board / product ID | `TL_WR845N-V4` |
| SoC | MediaTek MT7628 |
| CPU | MIPS 24KEc |
| RAM reported by prior diagnostics | 28.96 MB |
| Hardware ID | `0x08450004` |
| Firmware partition / available region reported | `0x3C0000` |
| Stock firmware version reported | `3.4.3.9L-102_a3f62be` |

## Current finding

The relevant upstream OpenWrt platform family is `ramips/mt76x8`. The current upstream device-definition file checked during project setup did not provide a confirmed TL-WR845N V4 entry matching both the model and reported hardware ID.

A separate community repository does select a `tplink_tl-wr845n-v4` profile, but it builds from a different source tree and has a documented concern about an 8 MB artifact exceeding the roughly 4 MB available flash region. This is a lead for further engineering review, not a verified safe image. See [community reference review](community-reference-review.md).

Therefore this project is currently **compatibility blocked**. No factory image, sysupgrade image, recovery image, or flash command is authorized by this repository yet.

## Required before a firmware build

1. Confirm the live board name and exact flash chip / total flash capacity.
2. Read the live `/proc/mtd` partition map and device tree compatible strings.
3. Locate an exact upstream or independently maintained device port for this precise hardware revision.
4. Verify the TP-Link image header requirements, hardware ID/revision fields, maximum image size, and bootloader recovery path.
5. Build in CI, inspect image metadata and size, and publish checksums plus recovery instructions.
6. Only then consider a test flash, with a verified recovery method available.

## Safety rule

Never flash firmware for a neighboring model or hardware revision. A similar MT7628 chipset does not make two router images interchangeable. The compatibility workflow is a gate only; it does not generate firmware.
