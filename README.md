# RidoyNet Firmware

Fresh firmware project for the TP-Link TL-WR845N v4.

> **Status: hardware verification required — no flashable firmware has been built yet.**

## Project principles

- Start from a clean, reproducible OpenWrt-based build configuration.
- Preserve the exact device target, image format, partition layout, and device-specific installation/recovery requirements.
- Do not reuse files or configuration from earlier firmware projects.
- Keep SSH access LAN-only by default; never expose administrative SSH on WAN.
- Do not publish or flash an image until its device compatibility and build artifacts have been verified.

## Hardware gate

Before selecting a build target or producing an image, verify the exact hardware revision and board identifiers from the router label and a read-only system report. The TL-WR845N has multiple hardware revisions; images are not interchangeable.

## Build status

This repository currently contains project documentation only. A successful build, image checksum, and installation/recovery instructions must be added after hardware verification.
