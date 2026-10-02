# Automation Strategy

> **Status:** DRAFT. Revised 2026-10-02: Maestro is the initial framework (section 9). Two flows exist. There is no regression coverage yet. Sections 3, 5 and 6 describe the original Appium / WebdriverIO plan and are kept as history.

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

## 3. Planned stack (original plan, 2026-09-30, superseded by section 9)

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

## 5. Planned architecture (original plan, superseded by section 10)

```
automation/
├── config/     WebdriverIO + Appium capabilities per environment (no secrets)
├── screens/    Screen Objects: locators + screen-level actions
├── tests/      Specs grouped by suite: smoke / functional / regression
├── fixtures/   Reusable setup/teardown, test hooks
└── utils/      Helpers: waits, gestures, logging, data loaders
```

## 6. Conventions (original plan; the Maestro conventions are in [automation/maestro/README.md](../automation/maestro/README.md))

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

## 9. Strategy revision — 2026-10-02: Maestro as the initial framework

The original plan (sections 3, 5 and 6) chose Appium + WebdriverIO + TypeScript. Before any of it was implemented, the plan was revised to start with [Maestro](https://docs.maestro.dev/) because:

- **Black-box testing:** Maestro drives the installed app from outside through the accessibility layer. No application source code, test APK or build changes are needed.
- **Production app:** the app under test is the public Google Play build, which this project does not build or own.
- **Physical device:** tests run on the authorized physical device (`ENV-001`) through the existing Windows Android Platform Tools / ADB. Android Studio and the full SDK are not required.
- **Readable flows:** flows are short YAML files that map directly to test cases and are easy to review.
- **Lighter infrastructure:** one CLI on a Java 17+ runtime, instead of an Appium server, drivers and a TypeScript framework.
- **Feasibility confirmed:** on 2026-10-01 and 2026-10-02, Maestro 2.11.0 on Windows communicated with the device, launched Icon Training and read its UI hierarchy (see the ColorOS notes in section 12).

**Appium remains a possible future alternative** if a concrete Maestro limitation appears (for example, a control that cannot be reached through Maestro selectors). The original plan is kept above for that reason.

### Current stack

| Layer | Tool | Status |
|---|---|---|
| UI automation | Maestro CLI 2.11.0 (Windows) | In use: 2 flows |
| Device bridge | Android Platform Tools / ADB 37.0.1 (Windows) | In use |
| Device | Physical OPPO Reno5 5G, `ENV-001` | In use |
| Runtime | JDK 18 (Windows), set per session | In use |
| Mirroring / observation | scrcpy 4.1 | Available |
| CI | GitHub Actions | PLANNED: static checks only, because the physical device is not reachable from hosted runners |
| Reporting | Maestro JUnit/HTML output, summarized into `reports/` | PLANNED |

## 10. Maestro architecture

```
automation/maestro/
├── README.md        How to run, conventions, device constraints
└── flows/
    ├── smoke/       Smoke flows, one per test case, named after the TC- ID
    └── auth/        Authentication / account-entry navigation flows
```

Folders are added only when they contain material (for example `flows/navigation/` or `subflows/` for shared steps). The placeholder folders from the original plan (`config/`, `screens/`, `fixtures/`, `utils/`, `tests/`) are unused.

Each flow maps to exactly one test case in `test-cases/`. The test case is the source of truth for steps and expected results. A test result is recorded in the test case only after the flow has actually run.

## 11. Autonomy model

Routine work on the device can be automated. Human intervention is required only when an action is sensitive, destructive, ambiguous, security-relevant or needs human judgment.

### Class A — safe autonomous

May be performed without asking each time:

- Launch or relaunch the app without clearing state
- Inspect the UI hierarchy; collect sanitized, app-scoped observations
- Assert visible, non-sensitive UI
- Press Android Back where safe; return to known safe states
- Navigate ordinary, non-sensitive app screens; open informational screens; scroll; switch ordinary tabs
- Capture temporary local screenshots
- Collect application-scoped diagnostic information
- Repeat deterministic navigation; execute already-approved test cases

### Class B — stop for human review

Ask before:

- Entering credentials; selecting a Google account; submitting an OTP
- Registration or account creation; submitting a password reset
- Changing profile, fitness or health information
- Accepting sensitive permissions; Health Connect authorization
- Sending AI or chat messages that may persist remotely
- Any action that may create or update backend records, or submitting a form whose persistence is uncertain
- Opening an unexpected external application
- Accepting terms, privacy or consent where acceptance changes state
- Unknown dialogs with potentially persistent consequences

### Class C — prohibited

Never autonomously:

- Make purchases, start trials, subscribe, or restore purchases when consequences are uncertain; enter payment information
- Delete accounts; access another user's information
- Bypass authentication, certificate pinning or other security controls; root the device; modify or repackage the app
- Expose credentials or tokens; publish sensitive screenshots or logs
- Perform uncontrolled load testing
- Clear application data or uninstall the production app without explicit approval

### Stop conditions

Automation stops and reports when: an unknown sensitive screen appears; credentials are requested; personal or health data appears unexpectedly; purchase UI requires interaction; an action may create backend data; a security bypass would be needed; device connectivity is unstable; the app version differs from the recorded version; more than one device is connected; the repository state is unexpected; a privacy scan finds unresolved material; or a failure needs product interpretation.

## 12. Device constraints observed on `ENV-001` (ColorOS 13.1)

- **Helper reinstall and installer screen:** Maestro installs its helper apps at the start of a run, and they are no longer present afterwards. ColorOS sometimes shows its own app-installed result screen over the app at that moment. On 2026-10-02 this caused one tooling failure (the target element was hidden behind the installer screen). Flows should start with `launchApp`, which brings the app back to the foreground. `--no-reinstall-driver` does not help, because the helpers do not persist.
- **Default permission grants:** by default, Maestro's `launchApp` tries to grant every permission the app declares. ColorOS rejected all of these attempts (`SecurityException`). Flows therefore set `permissions` explicitly to the current device state, so that a run does not try to change permissions.
- **Helper process dying:** on 2026-10-02 the Maestro helper on the device stopped mid-run (`DeviceServerDiedException` while reading the view hierarchy) after a tap had already been performed. A run that ends this way is classified as BLOCKED / INFRASTRUCTURE, not as an application failure.
- **In-app vs system Back:** the in-app back arrow on the Forgot Password screen has no semantic selector, and Android system Back leads to a different screen. Flows do not substitute one for the other.

## 13. Discovery harness (design only, not implemented)

A lightweight, bounded helper for further exploration, run on the physical device:

```
launch → capture app-scoped hierarchy → identify visible controls
      → compare with the feature inventory → choose ONE Class A action
      → execute → capture the resulting hierarchy → record the transition → continue
```

Safeguards:

- **Screen signatures:** a screen is identified by the sorted set of its app-scoped labels and control types. Known signatures map to `FEAT-` IDs.
- **Visited transitions:** each (screen signature, action) pair is executed at most once per session.
- **Limits:** maximum navigation depth (default 3) and maximum actions per session (default 10).
- **Action allow-list:** only Class A actions (Back, open informational screens, scroll, ordinary tabs). Every other control is listed as `NOT EXPLORED` and never tapped.
- **Hard stops:** a text field, an account picker, any purchase or consent UI, an unknown dialog or an external app ends the session for human review.
- **Output:** proposed inventory and navigation-log entries for human review, never direct edits. Raw hierarchy stays local and is git-ignored.

It is not an unrestricted crawler and does not tap arbitrary controls.
