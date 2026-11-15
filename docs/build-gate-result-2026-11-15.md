# Build gate result (2026-11-15)

## Result

The GitHub Actions workflow **Device compatibility gate** ran on the current `main` commit and failed at the intended exact-device check.

- Workflow run: [#12](https://github.com/ridoybabu544-jpg/RidoyNet-Firmware-/actions/runs/43723999536)
- Commit checked: `037a5a8c88e93f4761f3373b13fe9eeb2f9aff02`
- Check: `scripts/check-upstream-support.sh`
- Output: no upstream OpenWrt `Device` block contains both model `TL-WR845N` and HWID `0x08450004`.
- Outcome: no firmware image was built or published.

This is a **real compatibility-gate failure**, not a compiler failure. The workflow did not attempt to compile firmware.

## Why the gate stays closed

The device details currently recorded for this project indicate a MediaTek MT7628, approximately 29 MiB RAM, and a 4 MiB flash chip. The reported firmware partition limit is `0x3C0000` (3,932,160 bytes). Those values are user-provided / previously observed and still need read-only confirmation from the running router before they can be treated as a verified flash map.

A current upstream device definition for the exact model and hardware ID has not been found. A similarly named TP-Link model is not an acceptable substitute. A community build or an image that merely fits under the reported byte limit is not sufficient evidence of a safe image.

## What this means for this project

- Do not flash any generic OpenWrt, WR840N, WR841N, or unverified community image.
- Do not create a release or label any file as flashable at this stage.
- Keep the stock firmware and current router settings intact.
- SSH is currently disabled, so the next verification route must use the router's web administration interface or a separately enabled, authenticated diagnostic route.
- Before a device-specific build can be considered, the exact flash partition map, board identifier / compatible string, image header requirements, maximum accepted image size, and a recovery method must be established.

## Branding and interface work

The intended product name is **Ridoy.Net**. The planned interface changes (top-left Ridoy.Net logo and hiding footer text) are presentation work only; they must not be used to disguise an incompatible base image or bypass the device compatibility gate. No Padavan branding or source is to be introduced into this new project.

## Current release status

**No firmware binary exists. No installation is safe or authorized.** The repository is currently a documented feasibility and verification project, not a completed firmware release.
