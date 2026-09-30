# Automation (PLANNED)

> **Status:** PLANNED. Nothing has been implemented. This folder is a placeholder for a future Android UI automation framework. No dependencies have been installed and Appium/WebdriverIO have not been initialized.

## Proposed architecture

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

## Planned folder layout

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
- Do not decompile, patch or instrument the app binary.
- Do not use private or internal APIs.
- Supply credentials through environment variables or CI secrets only. Never commit them.
- Do not commit app binaries (`.apk` / `.aab`).
