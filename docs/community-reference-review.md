# Community reference review

Reviewed on 2026-11-15.

A public community repository exists for this exact model family:
- https://github.com/mhkanon/Openwrt-TL-WR845N-V4

Its checked-in `.config` selects `ramips/mt76x8` and the profile `tplink_tl-wr845n-v4`. This is useful evidence that a community build configuration once targeted the model. It is not proof that the current upstream OpenWrt tree supports the device, nor proof that its images match every V4 hardware/flash variant.

Important limitations found during review:
- The repository workflow clones a separate LEDE source branch, not the current upstream OpenWrt source.
- The checked-in configuration uses Linux 5.4 and sets generic kernel/rootfs partition sizes of 16/160; these values are not validated against this router's reported 4 MB flash region.
- Its issue tracker contains a report that an 8 MB artifact was too large for a TL-WR845N V4 with roughly 4 MB available flash. The repository's release page has assets, but release presence alone does not establish safe compatibility with this individual unit.
- The community repository has no write permission from this project; its source and configuration are not copied into RidoyNet.

References:
- Community repository: https://github.com/mhkanon/Openwrt-TL-WR845N-V4
- Reported 4 MB / 8 MB size issue: https://github.com/mhkanon/Openwrt-TL-WR845N-V4/issues/2
- Community releases: https://github.com/mhkanon/Openwrt-TL-WR845N-V4/releases

Decision:
Do not import or flash those binaries. Continue with an independent device port only after the exact live flash map, flash capacity, device-tree identity, TP-Link image header, and recovery route are verified.
