# Maestro flows

> **Status:** One smoke flow (`TC-AUTH-001`). There is no regression suite yet. See [docs/automation-strategy.md](../../docs/automation-strategy.md) for the strategy, the autonomy model and device constraints.

## Layout

| Path | Contents |
|---|---|
| `flows/smoke/` | Smoke flows. One file per test case, named after its `TC-` ID |

New folders (for example `flows/auth/`, `flows/navigation/`, `subflows/`) are added only when they contain flows.

## Requirements

- Windows host with Maestro CLI (2.11.0 used so far) and a Java 17+ runtime
- Android Platform Tools / ADB on the same host, and exactly one authorized device connected (`ENV-001`)
- Icon Training installed from Google Play, in the state the test case's preconditions require

## Running a flow (PowerShell)

Environment variables are set for the current session only:

```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-18.0.2.1"
$env:Path = "C:\Android\platform-tools;C:\Android\maestro\bin;$env:Path"
$env:MAESTRO_CLI_NO_ANALYTICS = "1"

# Run from the repository root (a WSL checkout can be opened from Windows as \\wsl.localhost\<distro>\<path>)
maestro test automation\maestro\flows\smoke\TC-AUTH-001-signed-out-launch-screen.yaml
```

Adjust the paths to your machine. Keep `C:\Android\platform-tools` first in `Path` so that Maestro and scrcpy share one adb server.

## Conventions

- Each flow names its test case in a header comment and in `name:`. The test case defines steps and expected results; record results there only after an actual run.
- Use text and accessibility-label selectors. No coordinates, no fixed sleeps; rely on Maestro's built-in waiting.
- Never use `clearState`, purchase, subscription, credential or account-selection steps without explicit human approval (see the autonomy model, Class B and C).
- Always set `launchApp.permissions` explicitly (see the strategy, section 12).
- Selectors are regular expressions: escape `?`, `.`, `(` and similar characters.

## Output and privacy

Maestro writes debug output (logs, screenshots, UI hierarchy) to `%USERPROFILE%\.maestro\tests\` by default, outside the repository. This output can contain the device serial, notification content and personal data. It is never committed. If `--debug-output` or `--output` is used, point it outside the repository or into a git-ignored path (`automation/maestro/output/`).

Only sanitized, derived results go into `test-cases/`, `reports/` and the feature inventory.
