# Test Environments

> **Status:** `ENV-001` is recorded as a baseline. Fields marked **PENDING TOOL-BASED VERIFICATION** are not shown in the device's settings and will be confirmed with tooling (e.g. ADB) later. No testing has been performed in any environment.

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
| `ENV-001` | 2.5.0 | Android 13 | OPPO Reno5 5G | Physical | PENDING TOOL-BASED VERIFICATION | Wi-Fi | en-US, Kenya, Africa/Nairobi | Not yet tested | Gideon Ngetich |

### ENV-001 — Physical Android baseline

All values were read from the device's own settings screens. Nothing was taken from generic specifications for the model.

| Field | Value |
|---|---|
| Environment ID | `ENV-001` |
| Application version | Icon Training 2.5.0. Verified 2026-10-01 from Android Settings → App info. Build/version code: not exposed in Android App info |
| Installation source | Google Play Store |
| Android version | Android 13 (API level: PENDING TOOL-BASED VERIFICATION) |
| Device | OPPO / OPPO Reno5 5G |
| Emulator / physical | Physical |
| OEM software | ColorOS 13.1 (Official version) |
| Hardware | Qualcomm SDM765G 5G octa-core; 12.0 GB RAM (+4.00 GB memory expansion shown); 256 GB storage; 4300 mAh (typ.) battery |
| Screen size | 6.43 inches |
| Screen resolution | Not exposed in device settings. Resolution and pixel density: PENDING TOOL-BASED VERIFICATION |
| Network | Wi-Fi (baseline) |
| Locale | Language: English (United States); Region: Kenya; Time zone: Africa/Nairobi |
| Date recorded | 2026-09-30 |
| Date tested | Not yet tested |
| Tester | Gideon Ngetich (@Ngetich-86) |
| Test host | Ubuntu 22.04.5 LTS under WSL2 (Linux 5.15.153.1, x86_64); OpenJDK 21.0.12.1; Node v22.22.3; npm 10.9.8. ADB and Android SDK tooling not installed |
| Notes | Dark mode: enabled. Font size: small. Display size (zoom) setting: not recorded; the 6.43 in value above is the physical screen size |

## Application version tracking

- Read the installed version from **Android Settings → App info** on the test device before each test cycle. Record it exactly as displayed, together with the date it was verified.
- Record a build/version code only if the device shows it. Never infer one.
- If the version differs from the one recorded for the environment, update the environment record. If other device settings also changed, create a new Environment ID instead.
- Every test result, bug report and report records the application version it was observed on (see [test-cases/README.md](../test-cases/README.md) and [bugs/README.md](../bugs/README.md)).
- When the app updates, earlier results stay attached to the version they were observed on. Retest against the new version and record the results separately.
