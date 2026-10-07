# APK Static Analysis

> **Status:** DRAFT. Pass 1 (application envelope) completed on 2026-10-07. Findings describe what the APK *declares or contains*; they are not test results and do not by themselves establish runtime behavior.

| Field | Value |
|---|---|
| Application | Icon Training |
| Package | `app.icontraining.icon` |
| Version analyzed | 2.5.0 (versionCode 65) |
| Environment | `ENV-001` (see [test-environments.md](test-environments.md)) |
| Analysis date | 2026-10-07 |
| Analyst | Gideon Ngetich (@Ngetich-86) |

## Scope

- The four APK files below were extracted from the maintainer's own installed Google Play copy of Icon Training on `ENV-001`.
- The analysis supports QA architecture understanding and risk-based test design: what the app is built with, which capabilities it declares, and where testing effort is likely to matter.
- Raw APK files, decoded resources and decompiler output stay on the analysis machine. **None of them are committed.** This document contains only sanitized, derived findings.
- Static evidence does not prove runtime behavior. A declared component, permission or library may be unused, conditional or disabled at runtime.
- Out of scope for this analysis: modifying, repackaging or re-signing the app; bypassing protections; probing backend infrastructure; security testing; publishing recovered source code or configuration values.

## Evidence vocabulary

| Tag | Meaning |
|---|---|
| STATIC-OBSERVED | Directly established from the APK, its manifests, resources or decompiled representation. |
| RUNTIME-OBSERVED | Established earlier through behavior on the physical device. |
| STATIC+RUNTIME-VERIFIED | Independent static and runtime evidence agree. |
| INFERRED | A reasonable interpretation that has not been directly verified. |
| NOT-YET-VERIFIED | Needs further analysis or runtime validation. |

## Artifact inventory

| File | Size (bytes) | SHA-256 |
|---|---|---|
| `base.apk` | 38,863,086 | `93d731bd18aa5832248300e9961228e8adacf6c0822fdc3674adc49768d72a6a` |
| `split_config.arm64_v8a.apk` | 51,860,590 | `087e88b58ba2fa06f0e8a77494d75e5752011f79d7ca8eb36b049db282f52ad9` |
| `split_config.en.apk` | 45,465 | `3d1e1d5ada2ac861bd47ac89ab4d1b949802654b0ea4c7d131c1f105eca9ba43` |
| `split_config.xxhdpi.apk` | 132,384 | `46d7a739cd2ba591feb070f28009815f2f404e45061ebda8419237c80b7a062b` |

Hashes and sizes were verified before analysis. The role of each file was confirmed by inspecting its contents, not only its name:

| File | Role (STATIC-OBSERVED) |
|---|---|
| `base.apk` | Main manifest, compiled Java/Kotlin code (3 dex files), resource table, resources and assets |
| `split_config.arm64_v8a.apk` | ABI split: 10 native libraries for `arm64-v8a` |
| `split_config.en.apk` | Language split: English resource table |
| `split_config.xxhdpi.apk` | Density split: density-specific drawables |

## Tooling

| Tool | Version | Use |
|---|---|---|
| OpenJDK | 21.0.12.1 | Runtime |
| Apktool | 3.0.3 | Manifest and resource decoding (code decoding skipped) |
| JADX | 1.5.6 | Java/Kotlin layer, used only for a high-level obfuscation assessment |

No network requests were made to application infrastructure, and the app was not modified or installed from these files.

## Package metadata

| Item | Value | Evidence |
|---|---|---|
| Package | `app.icontraining.icon` | STATIC+RUNTIME-VERIFIED |
| versionName | 2.5.0 | STATIC+RUNTIME-VERIFIED |
| versionCode | 65 | STATIC-OBSERVED |
| minSdk | 26 | STATIC-OBSERVED |
| targetSdk | 36 | STATIC-OBSERVED |
| compileSdk | 36 | STATIC-OBSERVED |
| Splits | Base requires an ABI split and a density split; a language split is also present (`config.arm64_v8a`, `config.xxhdpi`, `config.en`) | STATIC-OBSERVED |

## Application configuration

All STATIC-OBSERVED unless stated otherwise.

- `android:debuggable` is not explicitly declared in the decoded application manifest; no evidence from this checkpoint indicates a debuggable application build.
- `android:allowBackup="false"` and `android:fullBackupContent="false"`. No data-extraction rules are declared.
- `android:extractNativeLibs="false"`.
- The default `android.app.Application` class is used (no custom application class).
- A network security configuration is declared:
  - cleartext traffic is not permitted in the base configuration;
  - no domain-specific configuration and no pin set are declared in it;
  - user-installed certificate authorities are trusted only under `debug-overrides`, which Android applies to debuggable builds.
- Certificate pinning implemented in code: **NOT-YET-VERIFIED**. Its absence from the network security configuration does not show that the app does not pin.

## Permissions

**A declared permission does not establish that the corresponding capability is used at runtime.**

The manifest declares 34 permissions (STATIC-OBSERVED), plus one app-internal signature-level permission that protects internal broadcast receivers.

| QA category | Declared permissions |
|---|---|
| Network | Internet; network-state access |
| Notifications / scheduling | Post notifications; schedule exact alarms; receive boot completed; vibrate; wake lock |
| Camera / microphone | Camera (camera hardware declared as not required); record audio |
| Location | Fine and coarse location |
| Health Connect | **Read-only** access to heart rate, steps, exercise, sleep, total calories burned, active calories burned and distance, declared in both the platform and AndroidX permission forms. No write permissions are declared. |
| Storage | Read external storage; write external storage limited to Android 9 (API 28) and below |
| Billing | Google Play billing |
| Biometric | Biometric and fingerprint use |
| Attribution | Android AdServices attribution and ad-ID permissions; Play install referrer |

RUNTIME-OBSERVED context (2026-10-01/02, `ENV-001`): the notification permission was granted; location, camera, microphone and storage permissions were not granted. This is consistent with the declarations above but does not show which features use them.

## Components

| Component type | Count (STATIC-OBSERVED) |
|---|---|
| Activities | 10 |
| Activity aliases | 0 |
| Services | 13 |
| Broadcast receivers | 7 |
| Content providers | 5 |

Exported components, by category (STATIC-OBSERVED; listed for test design, not as security findings):

- **Launcher activity:** the app's main activity, which also handles the Health Connect permission-rationale and permission-usage intents. That this activity is the app's runtime entry point is STATIC+RUNTIME-VERIFIED.
- **Health Connect SDK service:** a binding service supplied by the AndroidX Health Connect library.
- **Permission-protected library components:** a Google sign-in revocation service, a third-party app-store purchase receiver, and the AndroidX profile installer.

All other activities, services, receivers and all five content providers are declared non-exported. Most components come from libraries rather than app-specific code.

## Deep links

- **No incoming deep links or app links were declared** in the analyzed manifests (STATIC-OBSERVED). No intent filter outside `<queries>` declares URI data.
- The `https`, `mailto`, `sms` and `tel` schemes, Custom Tabs, Health Connect settings, maps and billing entries appear under `<queries>`. They describe **outbound** interactions the app may perform (opening other apps or services), not links into the app.

## Framework and architecture

**Flutter application** (STATIC-OBSERVED). Evidence:

- Flutter embedding metadata in the manifest and Flutter engine classes in the Java/Kotlin layer
- The Flutter engine library and a compiled Dart (AOT) snapshot library in the ABI split
- A `flutter_assets` asset bundle and Flutter plugin components declared in the manifest
- The app's own Java/Kotlin code is a thin host activity (STATIC-OBSERVED), so the application logic is expected to be in the compiled Dart snapshot (INFERRED)

**Shorebird:** Shorebird code-push components are present in the analyzed APK (STATIC-OBSERVED). This means store versionName/versionCode alone may not always be sufficient to identify the Dart code under test (INFERRED). Whether this device currently has a Shorebird patch applied is NOT-YET-VERIFIED.

## SDK and dependency indicators

High level only. Presence does not show that a capability is used at runtime.

**Strong evidence** (STATIC-OBSERVED: manifest components or native libraries, plus Flutter license notices):

| Family | Indicators |
|---|---|
| Firebase Core / Analytics / Crashlytics | Firebase initialization components and services |
| Google Play Billing | Billing proxy activities, billing permission and queries |
| RevenueCat | RevenueCat purchase components |
| Google Sign-In / Credential Manager | Sign-in and credential-provider components. The Google account chooser was RUNTIME-OBSERVED (`FEAT-AUTH-004`), so Google sign-in entry is STATIC+RUNTIME-VERIFIED |
| Health Connect | Health Connect SDK service, permissions and queries |
| Google Maps / location | Maps configuration metadata, maps query, location foreground service |
| CameraX | CameraX components and native helpers |
| ML Kit barcode scanning | ML Kit components, barcode models and native library |
| Media playback | Video/media native libraries and media packages |
| WebView / URL launcher | In-app WebView activity and outbound link queries |
| Local notifications | Scheduled-notification and boot receivers |
| SQLite / Drift | SQLite native library and database packages |

**Weaker indicators** (Flutter license notices only; the notices also include build-time and development packages, so these are INFERRED):

- Secure storage, Dio (HTTP), connectivity monitoring, in-app update prompts
- Sign in with Apple and similar cross-platform packages, whose Android use is NOT-YET-VERIFIED

## Native libraries

The ABI split contains 10 `arm64-v8a` libraries (STATIC-OBSERVED). By category (purposes INFERRED from well-known library names; the native code was not reverse engineered):

- Flutter engine and the compiled Dart application snapshot
- Video/media playback
- Barcode scanning
- Camera image and surface helpers
- SQLite database
- Dart-to-Java interoperability
- AndroidX DataStore support

## Obfuscation

The Java/Kotlin dependency layer shows substantial name minification consistent with an optimized/minified build. Exact minification tooling was not established. Core application logic resides primarily in compiled Dart AOT code, which was not reconstructed by this checkpoint.

Dart-level obfuscation: NOT-YET-VERIFIED.

## Sensitive configuration

Static analysis identified client-side configuration associated with:

- Google services / Google Maps
- Firebase
- Shorebird
- Google Play distribution metadata

**Values are intentionally withheld** and are not recorded anywhere in this repository. Client-side configuration of this kind is normally shipped with mobile apps; it is **not** being reported as a vulnerability.

## QA implications

Risk areas for test design. These are not defects.

| Area | Why it matters |
|---|---|
| Version / patch provenance | Shorebird means the Dart code may change without a store version change. Test records need a way to note the patch state once it can be observed. |
| Authentication / session handling | Google sign-in and credential components, secure storage indicators; logout and session-persistence behavior (`FEAT-AUTH-*`). |
| Premium / billing | Play Billing and RevenueCat behind the observed paywall (`FEAT-SUB-*`). Purchase flows stay human-only (autonomy model, Class C). |
| Health Connect permissions | Read-only permissions and a permission-rationale entry point: grant, deny, revoke and Health Connect-unavailable states. |
| Notification scheduling / reboot | Exact alarms and boot rescheduling: reminder delivery, reboot, app update and permission-denied behavior. |
| Location / maps | Location permissions and a location foreground service: permission states, location off, background behavior. |
| Camera / barcode / microphone | Declared camera, barcode and audio capabilities: where they appear, and permission-state handling. |
| Offline / state synchronization | Local database and connectivity indicators: offline use, reconnection and data consistency. |
| Media / WebView | Video and audio playback, in-app web content: interruptions, network loss, back navigation. |
| Lifecycle / background-resume | Flutter host activity, notifications and foreground service: backgrounding, process death and resume. |
| Accessibility / testability | Flutter renders its own widgets; accessibility labels depend on Flutter semantics. This matches the unlabelled controls already recorded in the [feature inventory](feature-inventory.md#8-accessibility-and-testability-observations). |

## Unknowns

| Item | Status |
|---|---|
| Runtime Shorebird patch state | NOT-YET-VERIFIED |
| Runtime versionCode | NOT-YET-VERIFIED (App info on `ENV-001` does not show it) |
| Code-level certificate pinning | NOT-YET-VERIFIED |
| Dart obfuscation | NOT-YET-VERIFIED |
| Runtime use of the statically identified capabilities (camera, microphone, barcode, location, maps, biometrics, Health Connect, media, WebView) | NOT-YET-VERIFIED |
| Which SDKs initialize at runtime, and when | NOT-YET-VERIFIED |
