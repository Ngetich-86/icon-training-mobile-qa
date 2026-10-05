# Test Environments

> **Status:** `ENV-001` is recorded as a baseline. Fields that the device's settings do not show were verified with Android Platform Tools / ADB on 2026-10-01 (see [ENV-001 history](#env-001-history)). Smoke testing (TC-AUTH-001, TC-AUTH-002) was performed on `ENV-001` on 2026-10-02.

Record a new entry for every distinct environment used in a test cycle. Test cases, bug reports and reports refer to entries by **Environment ID**.

Do **not** record device serial numbers, IMEIs, account emails or other identifying information.

## Environment record template

| Field | Value |
|---|---|
| Environment ID | _ENV-XXX_ |
| Application version | _Exact version and build number, as shown in app settings or store listing_ |
| Installation source | _e.g. Google Play (public), beta track_ |
| Android version | _e.g. Android 14 (API 34)_ |
| Device | _Manufacturer / model, or emulator image name_ |
| Emulator / physical | _Emulator / Physical_ |
| Screen resolution | _e.g. 1080 × 2400, density_ |
| Network | _e.g. Wi-Fi, 4G, throttled, offline_ |
| Locale | _e.g. en-US, time zone_ |
| Date tested | _YYYY-MM-DD_ |
| Tester | _Name / handle_ |
| Notes | _Font scale, dark mode, accessibility settings, and so on_ |

## Recorded environments

| Environment ID | App version | Android | Device | Type | Resolution | Network | Locale | Date | Tester |
|---|---|---|---|---|---|---|---|---|---|
| `ENV-001` | 2.5.0 | Android 13 | OPPO Reno5 5G | Physical | 1080 × 2400, 480 dpi | Wi-Fi | en-US, Kenya, Africa/Nairobi | 2026-10-02 | Gideon Ngetich |

### ENV-001 — Physical Android baseline

Values were first read from the device's own settings screens. Values marked *(ADB, 2026-10-01)* were later read from the device with Android Platform Tools / ADB. Nothing was taken from generic specifications for the model.

| Field | Value |
|---|---|
| Environment ID | `ENV-001` |
| Application version | Icon Training 2.5.0. Verified 2026-10-01 from Android Settings → App info. Build/version code: not exposed in Android App info |
| Installation source | Google Play Store |
| Android version | Android 13, API level 33 *(ADB, 2026-10-01)* |
| Device | OPPO / OPPO Reno5 5G. ADB model identifier: `PEGM00`; ADB vendor market name: OPPO Reno5 5G *(ADB, 2026-10-01)* |
| Emulator / physical | Physical |
| OEM software | ColorOS 13.1 (Official version). Build display ID: `PEGM00_13.1.0.200(CN01)` *(ADB, 2026-10-01)* |
| Hardware | Qualcomm SDM765G 5G octa-core; 12.0 GB RAM (+4.00 GB memory expansion shown); 256 GB storage; 4300 mAh (typ.) battery |
| Screen size | 6.43 inches |
| Screen resolution | Physical size 1080 × 2400 px; physical density 480 dpi. No size or density override reported *(ADB, 2026-10-01)*. Not exposed in device settings |
| Network | Wi-Fi (baseline) |
| Locale | Language: English (United States); Region: Kenya; Time zone: Africa/Nairobi |
| Date recorded | 2026-09-30 |
| Date tested | Not yet tested |
| Tester | Gideon Ngetich (@Ngetich-86) |
| Test host | Windows 11 Pro host with Ubuntu 22.04.5 LTS under WSL2 (Linux 5.15.153.1, x86_64); OpenJDK 21.0.12.1; Node v22.22.3; npm 10.9.8 (WSL). Android Platform Tools / ADB 37.0.1 installed on Windows and invoked from WSL; it communicated with the device over USB at first and over wireless ADB since 2026-10-02. scrcpy 4.1 installed on Windows and used to observe and control the device. Maestro CLI 2.11.0 on Windows (JDK 18.0.2.1, set per session). Android Studio and the full Android SDK are not installed |
| ADB transport | Wireless ADB over the local Wi-Fi network: primary for normal QA runs since 2026-10-02. The IP address and port are assigned dynamically and change when wireless debugging reconnects; they are not recorded. USB ADB: the earlier setup, kept as a fallback. scrcpy 4.1 verified over wireless ADB (2026-10-02) |
| Automation helpers on device | Maestro helper apps `dev.mobile.maestro` and `dev.mobile.maestro.test` stay installed between runs (approved 2026-10-02; lifecycle in [automation-strategy.md](automation-strategy.md#12-device-constraints-observed-on-env-001-coloros-131)) |
| Notes | Dark mode: enabled. Font size: small. Display size (zoom) setting: not recorded; the 6.43 in value above is the physical screen size |

#### ENV-001 history

| Date | Change |
|---|---|
| 2026-09-30 | Record created from the device's settings screens. Android Platform Tools / ADB was not available on the host, so the API level, screen resolution and pixel density were marked PENDING TOOL-BASED VERIFICATION. |
| 2026-10-01 | OS, locale, network and display settings added from the device's settings screens. Icon Training 2.5.0 recorded from Android Settings → App info. |
| 2026-10-01 | Android Platform Tools / ADB and scrcpy were configured on the Windows host (installation date not recorded). The pending values were verified with ADB: API level 33, physical size 1080 × 2400, physical density 480 dpi. ADB model identifier, vendor market name and build display ID added. Test host description corrected. This was environment verification, not application testing. |
| 2026-10-02 | Wireless ADB over the local Wi-Fi network became the primary transport for normal QA runs; scrcpy 4.1 verified over it. USB ADB remains a fallback. Maestro helper apps now stay installed (`--no-reinstall-driver`). The device, Android version and app version are unchanged. Observed the same day: wireless ADB dropped twice and had to be reconnected manually on a new port. The dynamic endpoint is not recorded. |

ADB queries used: `getprop` for `ro.product.manufacturer`, `ro.product.brand`, `ro.product.model`, `ro.vendor.oplus.market.name`, `ro.build.version.release`, `ro.build.version.sdk`, `ro.build.display.id` and `ro.build.version.oplusrom.display`; `wm size`; `wm density`. No device identifiers were recorded.

## Application version tracking

- Read the installed version from **Android Settings → App info** on the test device before each test cycle. Record it exactly as displayed, together with the date it was verified.
- Record a build/version code only if the device shows it. Never infer one.
- If the version differs from the one recorded for the environment, update the environment record. If other device settings also changed, create a new Environment ID instead.
- Every test result, bug report and report records the application version it was observed on (see [test-cases/README.md](../test-cases/README.md) and [bugs/README.md](../bugs/README.md)).
- When the app updates, earlier results stay attached to the version they were observed on. Retest against the new version and record the results separately.
