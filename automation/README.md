# Automation

> **Status:** Revised 2026-10-02. Automation uses **Maestro**: see [maestro/](maestro/README.md), which holds two flows. There is no regression suite yet. The Appium / WebdriverIO architecture below is the original plan (2026-09-30), kept for history; its placeholder folders (`config/`, `screens/`, `tests/`, `fixtures/`, `utils/`) are unused. Reasons for the change are in [docs/automation-strategy.md](../docs/automation-strategy.md#9-strategy-revision--2026-10-02-maestro-as-the-initial-framework).

## Original proposed architecture (superseded)

```
Appium
   ↓
WebdriverIO
   ↓
TypeScript
   ↓
Screen Objects
   ↓
Reusable fixtures/utilities
   ↓
Smoke / Functional / Regression suites
   ↓
GitHub Actions
   ↓
Allure reports
```

## Original planned folder layout (unused)

| Folder | Planned purpose |
|---|---|
| `config/` | WebdriverIO and Appium capabilities per environment (emulator/physical). **No secrets.** |
| `screens/` | Screen Objects that hold locators and screen-level actions |
| `tests/` | Specs organized into smoke, functional and regression suites |
| `fixtures/` | Reusable setup/teardown and hooks |
| `utils/` | Helpers: waits, gestures, logging, test-data loading |

## When automation will begin

Automation will only begin after:

1. Application exploration
2. Feature inventory
3. Risk analysis
4. Manual test design
5. Identification of stable automation candidates

The candidate selection criteria are in [docs/automation-strategy.md](../docs/automation-strategy.md).

## Boundaries

- Automate only through the public UI of the installed application.
- Do not patch, repackage or instrument the app binary, or bypass its protections. Static analysis of the installed APK for test design is documented in [docs/apk-analysis.md](../docs/apk-analysis.md); its raw output stays local and is never committed.
- Do not use private or internal APIs.
- Supply credentials through environment variables or CI secrets only. Never commit them.
- Do not commit app binaries (`.apk` / `.aab`).
