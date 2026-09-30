# Automation Strategy

> **Status:** PLANNED. No automation has been implemented. The framework will not be initialized until the prerequisites below are met (Milestone M5).

## 1. Goals

- Provide fast, repeatable regression checks for stable, high-value user journeys.
- Complement manual and exploratory testing, not replace it.
- Produce readable reports that CI can publish.

## 2. Prerequisites (before any automation begins)

1. Application exploration
2. Verified feature inventory
3. Risk analysis
4. Manual test design
5. Identification of stable automation candidates

## 3. Planned stack

| Layer | Tool | Status |
|---|---|---|
| Driver | Appium (UiAutomator2) | PLANNED |
| Framework / runner | WebdriverIO | PLANNED |
| Language | TypeScript | PLANNED |
| Pattern | Screen Object Model | PLANNED |
| Devices | Android Emulator / authorized physical device | PLANNED |
| CI | GitHub Actions | PLANNED |
| Reporting | Allure | PLANNED |

## 4. Automation candidate selection criteria

A test case is a candidate for automation when it meets most of these criteria:

- It covers a high or critical risk, or a frequently regressed journey
- The manual steps and expected results are stable and deterministic
- The UI elements have reliable locators (accessibility IDs preferred)
- Test data can be synthetic and reset or reused safely
- It does not depend on nondeterministic AI output for its assertions
- It does not require real payments, real personal data or production-impacting actions

Poor candidates: one-off exploratory checks, highly visual or subjective checks, flows that depend on nondeterministic content, and flows that would violate terms of service or affect other users.

## 5. Planned architecture

```
automation/
├── config/     WebdriverIO + Appium capabilities per environment (no secrets)
├── screens/    Screen Objects: locators + screen-level actions
├── tests/      Specs grouped by suite: smoke / functional / regression
├── fixtures/   Reusable setup/teardown, test hooks
└── utils/      Helpers: waits, gestures, logging, data loaders
```

## 6. Conventions (to apply when implemented)

- Prefer accessibility IDs, then resource IDs. Avoid brittle XPath.
- Use no hard-coded sleeps. Use explicit waits.
- Keep tests independent so they can run in any order.
- Load credentials from environment variables or CI secrets, never from source.
- Use tags for suites: `@smoke`, `@regression`, `@functional`.
- Record the application version in every report.

## 7. Legal / ethical boundaries

- Automate only through the public UI of the installed application.
- Do not decompile, patch, or bypass protections in the app.
- Do not automate against private APIs.
- Respect the application's terms of service and avoid generating excessive load.

## 8. Reporting

Allure results will be generated per run and published as CI artifacts (planned, M8). A CI status badge will be added **only after** a workflow genuinely passes.
