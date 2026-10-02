# Maestro flows

> **Status:** Two flows (`TC-AUTH-001` smoke, `TC-AUTH-002` auth navigation). There is no regression suite yet. See [docs/automation-strategy.md](../../docs/automation-strategy.md) for the strategy, the autonomy model and device constraints.

## Layout

| Path | Contents |
|---|---|
| `flows/smoke/` | Smoke flows. One file per test case, named after its `TC-` ID |
| `flows/auth/` | Authentication and account-entry navigation flows |

New folders (for example `flows/navigation/`, `subflows/`) are added only when they contain flows.

## Requirements

- Windows host with Maestro CLI (2.11.0 used so far) and a Java 17+ runtime
- Android Platform Tools / ADB on the same host, and exactly one authorized physical device (`ENV-001`), normally over wireless ADB. Several adb transports for that one device are fine.
- Icon Training installed from Google Play, in the state the test case's preconditions require

## Running a flow (PowerShell)

Connect the device first (for wireless ADB: `adb connect <current endpoint>`; the endpoint is dynamic and is never written into the repository). Then, in one PowerShell session:

```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-18.0.2.1"
$env:Path = "C:\Android\platform-tools;C:\Android\maestro\bin;$env:Path"
$env:MAESTRO_CLI_NO_ANALYTICS = "1"

$repo = "<repository path>"   # for a WSL checkout: \\wsl.localhost\<distro>\<path>

# Preflight: dot-source it so it can set $env:ICON_QA_DEVICE for this session.
# Add -AllowHelperInstall only for the first run or after a Maestro upgrade.
. "$repo\automation\maestro\scripts\preflight.ps1"

if ($env:ICON_QA_PREFLIGHT -eq 'READY') {
    maestro --device $env:ICON_QA_DEVICE test --no-reinstall-driver "$repo\automation\maestro\flows\smoke\TC-AUTH-001-signed-out-launch-screen.yaml"
}
```

- Use the **full path** to the flow. Relative paths fail from a `\\wsl.localhost\...` folder because Windows programs fall back to `C:\Windows` as their working directory.
- Keep `C:\Android\platform-tools` first in `Path` so that Maestro and scrcpy share one adb server.
- If PowerShell's execution policy blocks the script, start the session with `powershell -ExecutionPolicy Bypass`. This applies to that process only and changes no machine setting.

## Preflight

[`scripts/preflight.ps1`](scripts/preflight.ps1) runs before product flows and prints no device identifiers. It checks that:

1. adb is reachable.
2. Transports in state `device` group into exactly **one physical device** (by a hashed serial kept in memory). The number of adb transports can be higher: explicit TCP, mDNS/TLS discovery and USB can all point to the same phone. Stale `offline` transports are ignored.
3. One transport is selected deterministically (explicit TCP, then mDNS, then USB) and stored in `$env:ICON_QA_DEVICE`.
4. The app package is installed and its version matches the expected test environment (default `2.5.0`).
5. Both Maestro helper apps are installed (or `-AllowHelperInstall` is given).
6. No known blocking system UI (ColorOS post-install screen, package installer) is in the foreground.
7. An optional `-DebugOutput` path is outside the repository.

`$env:ICON_QA_PREFLIGHT` is `READY` or `BLOCKED`. If it is `BLOCKED`, do not run flows; record the attempt as BLOCKED / INFRASTRUCTURE.

## Result semantics

| Situation | Result |
|---|---|
| Icon Training does not match an expected result | FAIL |
| Preflight BLOCKED, ADB unavailable, ambiguous device selection | BLOCKED / INFRASTRUCTURE |
| System UI (for example the ColorOS post-install screen) covers the app | BLOCKED / INFRASTRUCTURE |
| Maestro helper dies (`DeviceServerDiedException`) | BLOCKED / INFRASTRUCTURE |

## Maestro helper apps

`dev.mobile.maestro` and `dev.mobile.maestro.test` stay installed on the device between runs (`--no-reinstall-driver`). After a Maestro upgrade, refresh them once. When the project ends or the device is returned, uninstall both. See [docs/automation-strategy.md §12](../../docs/automation-strategy.md#12-device-constraints-observed-on-env-001-coloros-131).

## Conventions

- Each flow names its test case in a header comment and in `name:`. The test case defines steps and expected results; record results there only after an actual run.
- Use text and accessibility-label selectors. No coordinates, no fixed sleeps; rely on Maestro's built-in waiting.
- Never use `clearState`, purchase, subscription, credential or account-selection steps without explicit human approval (see the autonomy model, Class B and C).
- Always set `launchApp.permissions` explicitly (see the strategy, section 12).
- Selectors are regular expressions: escape `?`, `.`, `(` and similar characters.

## Output and privacy

Maestro writes debug output (logs, screenshots, UI hierarchy) to `%USERPROFILE%\.maestro\tests\` by default, outside the repository. This output can contain the device serial, notification content and personal data. It is never committed. If `--debug-output` or `--output` is used, point it outside the repository or into a git-ignored path (`automation/maestro/output/`).

Only sanitized, derived results go into `test-cases/`, `reports/` and the feature inventory.
