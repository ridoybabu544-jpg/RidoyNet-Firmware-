# RidoyNet Firmware

A clean firmware project for **TP-Link TL-WR845N (UN) V4.0**. This repository is independent; no source tree or board configuration is copied from the previous firmware repository.

## Device data supplied earlier

| Item | Reported value |
|---|---|
| Model | TP-Link TL-WR845N (UN) V4.0 |
| Board / product ID | `TL_WR845N-V4` |
| SoC | MediaTek MT7628 |
| CPU architecture | MIPS 24KEc |
| RAM | 28.96 MB |
| Hardware ID | `0x08450004` |
| Firmware partition / available region | `0x3C0000` |
| Stock firmware version | `3.4.3.9L-102_a3f62be` |

These are previously supplied diagnostic values. The live partition map, flash capacity, board identifiers, and bootloader recovery method must be checked before any image can be considered safe.

## Current status: compatibility blocked

The relevant OpenWrt platform family is `ramips/mt76x8`, but the upstream device-definition file checked during project setup did not show a TL-WR845N entry matching both the reported model and hardware ID. Similar MT7628 routers are not interchangeable.

A separate community repository was found that selects this model profile, but it uses a different source tree and has a documented 4 MB / 8 MB image-size concern. It is recorded for reference only; no files or binaries were copied. See [community reference review](docs/community-reference-review.md).

The repository currently contains:
- Hardware notes and safety requirements
- A GitHub Actions compatibility-gate workflow
- A script that checks whether one upstream device-definition block contains both the model and hardware ID
- A read-only router diagnostics script at `scripts/collect-router-info.sh` and step-by-step instructions in [next router check](docs/next-router-check.md)
- A firmware feasibility review at `docs/firmware-feasibility.md`
- A source-level audit of the exact-model community build profile and its floating upstream source at `docs/community-build-audit-2026-11-15.md`
- A preliminary image-size/checksum audit at `scripts/audit-image-size.sh` (not a compatibility test)

The workflow is **not a firmware build**. It intentionally fails closed if the exact device definition is absent. No factory, sysupgrade, or recovery image is generated or published.

## Next engineering requirements

1. Confirm the live `/proc/mtd` map, flash chip capacity, board name, and device-tree compatible strings.
2. Find or develop a device port for this exact hardware revision.
3. Verify image header fields, maximum firmware size, partition layout, and bootloader recovery.
4. Add a reproducible OpenWrt source/build pipeline only after the exact target is established.
5. Inspect the generated image and publish checksums and tested recovery instructions before any flash attempt.

## Safety

Never flash firmware for a neighboring model or hardware revision. Do not expose administrative SSH on the WAN; keep it LAN-only.


## Latest automated check

The exact-device compatibility gate was executed on 2026-11-15 and **failed closed as intended**: upstream did not contain one device block matching both `TL-WR845N` and `0x08450004`. No build was attempted and no image was produced. See [the recorded result](docs/build-gate-result-2026-11-15.md) and [GitHub Actions run #12](https://github.com/ridoybabu544-jpg/RidoyNet-Firmware-/actions/runs/43723999536).
