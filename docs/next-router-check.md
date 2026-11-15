# Next router check (read-only)

This is the next required step before any firmware build. It collects live hardware facts from the router; it does not flash, erase, reboot, or change configuration.

## 1. Connect to the router

From a computer or Android terminal on the router's Wi-Fi, connect to the router's actual LAN gateway address:

```sh
ssh root@192.168.1.1
```

If the router uses a different gateway address, substitute that address. Do not guess passwords or enable remote/WAN SSH. Use the router's locally configured SSH credentials.

## 2. Run the read-only collector

After SSH login, paste:

```sh
wget -O /tmp/collect-router-info.sh https://raw.githubusercontent.com/ridoybabu544-jpg/RidoyNet-Firmware-/main/scripts/collect-router-info.sh && sh /tmp/collect-router-info.sh && cat /tmp/ridoynet-router-diagnostics.txt
```

If `wget` is unavailable but `curl` exists:

```sh
curl -L -o /tmp/collect-router-info.sh https://raw.githubusercontent.com/ridoybabu544-jpg/RidoyNet-Firmware-/main/scripts/collect-router-info.sh && sh /tmp/collect-router-info.sh && cat /tmp/ridoynet-router-diagnostics.txt
```

## 3. Share the output safely

Copy the complete output here. Before sharing, redact MAC addresses, serial numbers, Wi-Fi passwords, public IP addresses, and any personally identifying values. Keep the partition names and sizes, board name, compatible strings, CPU/RAM information, and flash utility names visible.

## Safety gate

Do not run `mtd`, `flash_erase`, `nandwrite`, `sysupgrade`, `dd` against an MTD device, or any firmware-install command. The collected output is needed to confirm the exact flash layout, board identity, and available recovery path. A matching filename or a small-enough image is not proof of compatibility.
