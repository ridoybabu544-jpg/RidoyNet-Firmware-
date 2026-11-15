# RidoyNet Firmware

A fresh firmware project for **TP-Link TL-WR845N (UN) V4.0**. This repository is the new project; no previous custom firmware source or configuration is being carried over.

## Verified device information already supplied

| Item | Value |
|---|---|
| Model | TP-Link TL-WR845N (UN) V4.0 |
| Board ID / Product ID | `TL_WR845N-V4` |
| SoC | MediaTek MT7628 |
| CPU architecture | MIPS 24KEc |
| RAM reported | 28.96 MB |
| Hardware ID | `0x08450004` |
| Firmware partition | `0x3C0000` (reported) |
| Current firmware reported | `3.4.3.9L-102_a3f62be` |

The reported partition size and prior diagnostic values are retained as reference data; they must be checked against the exact image layout before any installation.

## Project rules

- Start a clean firmware implementation and build pipeline in this repository.
- Do not copy the previous repository's source tree or old firmware configuration into this project.
- Identify and verify the supported upstream target, board definition, flash layout, image format, and recovery procedure before producing a flashable image.
- Keep administrative SSH access restricted to the LAN; do not expose it on the WAN.
- Never flash an image until its target compatibility, image size, checksum, and recovery path have been validated.

## Status

Documentation initialized. No source tree, build workflow, or flashable firmware image has been added or built in this repository yet.
