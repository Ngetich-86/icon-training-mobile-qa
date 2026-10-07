# Icon Training — Mobile QA Engineering Portfolio

> **Project status: M1 in progress — product exploration, APK static analysis and a Maestro automation foundation.**
> Two automated test cases have been executed and passed on one physical Android device (`ENV-001`, app 2.5.0, 2026-10-02): `TC-AUTH-001` (smoke) and `TC-AUTH-002` (functional navigation). No defects have been reported and no execution or release reports exist yet. Results are added only as real, verified work is completed. See [Current evidence](#current-evidence).

---

## 1. Overview

This repository shows a structured QA engineering approach applied to the **publicly available Icon Training (Icon Train Smarter) mobile application**.

The maintainer is a QA Engineer with Icon Train Smarter. This repository is a **personal QA engineering portfolio** created independently. It is **not an official Icon Train Smarter project** and is not endorsed by, or maintained on behalf of, Icon Train Smarter.

**What this repository is not:**

- It is **not** the official application source repository.
- It does **not** contain proprietary application source code.
- It does **not** expose, document or probe private or internal APIs.
- It does **not** contain credentials, tokens or secrets.
- It does **not** contain production user information or personal health information.
- It does **not** contain confidential internal company documentation, communications or issue-tracker content.

**Evidence and findings:**

- Any application behavior documented here must come from **actual observed testing** of the publicly available app.
- All published evidence (screenshots, recordings, logs) must be **sanitized before commit**. See [Privacy & Responsible Disclosure](#11-privacy--responsible-disclosure).
- Findings apply to the **specific application version, device and environment recorded with them**. They should not be read as permanent or general product behavior.

## 2. Objectives

- Show the complete QA lifecycle, from product understanding through to release-quality reporting.
- Apply risk-based test planning and prioritization.
- Produce clear, reproducible test cases, exploratory session records and defect reports.
- Build maintainable Android UI automation for stable, high-value flows (planned).
- Integrate automated checks and reporting into CI/CD (planned).
- Apply responsible, privacy-first handling of all testing evidence.

## 3. QA Scope

**Planned in scope** (to be confirmed against a verified feature inventory in Milestone M1):

| Area | Folder |
|---|---|
| Authentication | `test-cases/authentication/` |
| Onboarding | `test-cases/onboarding/` |
| Navigation | `test-cases/navigation/` |
| Workouts | `test-cases/workouts/` |
| Workout tracking | `test-cases/workout-tracking/` |
| AI coaching | `test-cases/ai-coaching/` |
| Recovery | `test-cases/recovery/` |
| Nutrition | `test-cases/nutrition/` |
| Permissions | `test-cases/permissions/` |
| Health Connect integration | `test-cases/health-connect/` |

These areas are working assumptions for organizing the repository. An area stays unconfirmed until it has been observed in the tested app version.

**Static analysis (in scope, with limits):** static analysis of APK artifacts extracted from the maintainer's own installed public Google Play copy, solely for QA architecture understanding and test design. Raw APK files and decompiler output stay local and are never committed; only sanitized findings are published ([docs/apk-analysis.md](docs/apk-analysis.md)). Static findings are not treated as runtime behavior until observed on a device.

**Out of scope:**

- Modifying, repackaging or re-signing the application
- Bypassing app, platform or security protections
- Inspecting, probing or testing private/internal APIs or backend infrastructure
- Unauthorized security or penetration testing
- Publishing recovered proprietary source code, secrets or sensitive configuration values
- Destructive testing, and load or stress testing against production services
- Any testing that uses real user accounts or data other than the maintainer's own authorized test accounts

## 4. Planned Testing Types

- Risk-based QA planning
- Static analysis of the installed app's APK (application envelope: metadata, permissions, components, frameworks)
- Smoke testing
- Manual functional testing
- Regression testing
- Exploratory (session-based) testing
- Negative testing
- Boundary and edge-case testing
- Mobile-specific testing (gestures, orientation, backgrounding, app lifecycle)
- Android testing and cross-device considerations
- Network-condition and interruption testing
- Permission testing
- Accessibility testing
- API testing — **only** where legally and technically appropriate (for example, documented public interfaces), and never against private endpoints
- AI feature evaluation (see [docs/ai-testing-strategy.md](docs/ai-testing-strategy.md))

## 5. Technology Stack

The original plan (Appium + WebdriverIO + TypeScript) was revised on 2026-10-02 before any of it was built: the app under test is the public Google Play build, so black-box automation that needs no app source or test APK is a better fit. Rationale: [docs/automation-strategy.md §9](docs/automation-strategy.md).

| Purpose | Tool | Status |
|---|---|---|
| UI automation | [Maestro](https://docs.maestro.dev/) CLI 2.11.0 (YAML flows) | **In use** — 2 flows |
| Device bridge | Android Platform Tools / ADB (wireless, USB fallback) | **In use** |
| Run preflight | [`automation/maestro/scripts/preflight.ps1`](automation/maestro/scripts/preflight.ps1) | **In use** — selects exactly one physical device, checks app version and helper apps, blocks on covering system UI; prints no device identifiers |
| Target device | Physical OPPO Reno5 5G, Android 13 / ColorOS 13.1 (`ENV-001`) | **In use** |
| Alternative driver | Appium | Kept as a fallback if a Maestro limitation appears |
| CI | GitHub Actions | PLANNED — static checks only; the physical device is not reachable from hosted runners |
| Reporting | Maestro JUnit/HTML output summarized into `reports/` | PLANNED |

## 6. Repository Structure

```
.
├── README.md                  Project overview (this file)
├── LICENSE
├── CONTRIBUTING.md            Workflow, branching, commits, evidence and privacy rules
├── docs/                      Strategy, plan, risk, environments, APK analysis, automation, AI, release report
├── test-cases/                Manual test cases, one folder per feature area
├── exploratory/               Exploratory charters and session reports
├── bugs/                      Defect reports, template and sanitized evidence
├── automation/                Maestro flows (maestro/flows) and the device preflight script
├── test-data/                 Synthetic test data only
├── reports/                   Execution, regression and release reports
└── .github/                   Issue/PR templates and (future) workflows
```

## 7. QA Workflow

### Current approach (revised 2026-10-07)

```
Manual exploratory baseline
        ↓
APK / static analysis
        ↓
Risk-based test design
        ↓
Targeted real-device verification
        ↓
High-value Maestro regression
        ↓
API testing — only where legitimate and appropriate
        ↓
Controlled performance testing — only where appropriate
        ↓
Evidence-based QA reporting
```

The manual observations and Maestro work recorded so far remain valid and are the baseline for each later step. Static findings guide test design; they become product facts only when observed on a device.

### Full QA lifecycle

```
Product understanding
        ↓
Risk assessment
        ↓
Test strategy
        ↓
Test design
        ↓
Manual execution
        ↓
Exploratory testing
        ↓
Defect investigation
        ↓
Automation selection
        ↓
Automation implementation
        ↓
Regression execution
        ↓
CI/CD
        ↓
Quality reporting
```

Work is tracked issue-first through GitHub Issues and Milestones (M0–M9). See [CONTRIBUTING.md](CONTRIBUTING.md).

## 8. Test Environments

Each test cycle will record the exact application version, Android version, device (emulator or physical), screen resolution, network conditions, locale, date and tester. The template is in [docs/test-environments.md](docs/test-environments.md).

| Environment | App | Device / OS | Type | Last tested |
|---|---|---|---|---|
| `ENV-001` | Icon Training 2.5.0 | OPPO Reno5 5G, Android 13 (ColorOS 13.1) | Physical | 2026-10-02 (TC-AUTH-001, TC-AUTH-002) |

**Device coverage:** Android only, one physical device. **iOS and emulators have not been tested.** Device-specific constraints observed on ColorOS (permission grants, helper apps, wireless ADB drops) are recorded in [docs/automation-strategy.md §12](docs/automation-strategy.md).

## 9. Automation

Automation follows exploration: a flow is written only for a manually understood, stable, high-value path, and every flow maps to a test case ID.

| Flow | Test case | Last result |
|---|---|---|
| [`flows/smoke/TC-AUTH-001-signed-out-launch-screen.yaml`](automation/maestro/flows/smoke/TC-AUTH-001-signed-out-launch-screen.yaml) | [TC-AUTH-001](test-cases/authentication/TC-AUTH-001-signed-out-launch-screen.md) | PASS — 2026-10-02, `ENV-001` |
| [`flows/auth/TC-AUTH-002-open-forgot-password-from-login.yaml`](automation/maestro/flows/auth/TC-AUTH-002-open-forgot-password-from-login.yaml) | [TC-AUTH-002](test-cases/authentication/TC-AUTH-002-open-forgot-password-from-login.md) | PASS — 2026-10-02, `ENV-001` |

Flow conventions: text/semantic selectors, no fixed sleeps, explicit permissions, no state clearing.

### How to reproduce a run

1. Install Maestro 2.11.0 (Java 17+) and Android Platform Tools; connect the device over wireless ADB or USB.
2. Run the preflight from PowerShell (dot-sourced) and continue only if `$env:ICON_QA_PREFLIGHT` is `READY`.
3. Run a flow with `maestro test --no-reinstall-driver <flow.yaml>`.

Full instructions: [automation/maestro/README.md](automation/maestro/README.md). Raw Maestro output is kept local and is not committed (see Privacy).

### Result semantics

| Situation | Recorded as |
|---|---|
| The app does not match the expected result | **FAIL** |
| Preflight BLOCKED, ADB unavailable, ambiguous device, system UI covering the app, Maestro helper crash | **BLOCKED / INFRASTRUCTURE** — not a product defect |

## 10. Reporting

Planned reports:

- **Execution reports** (`reports/execution/`): results of each manual test cycle
- **Regression reports** (`reports/regression/`): manual and automated regression results
- **Release quality reports** (`reports/release/`, [docs/release-quality-report.md](docs/release-quality-report.md)): overall quality assessment for a tested version
- **Allure reports**: generated by CI once automation exists (planned)

*No execution, regression or release reports have been produced yet.* Results so far are recorded in each test case's execution history.

## 11. Privacy & Responsible Disclosure

The following must **never** be committed to this repository:

- Passwords, authentication tokens, session cookies, private API keys or any other secrets
- Production user information or personal health information
- Private company documents, confidential requirements, internal communications
- Proprietary source code
- Internal issue-tracker screenshots
- Private or internal endpoints
- Unsanitized logs containing personal information

Rules:

- Use **synthetic test data** whenever possible (`test-data/synthetic/`).
- Review and **sanitize every screenshot, recording and log** before publication. Redact names, emails, account identifiers, health metrics, device identifiers, location and notifications.
- **Raw captures are never committed.** Only sanitized copies are published, and redaction must be destructive (the underlying data removed, not covered by an overlay), with metadata stripped.
- **Responsible disclosure:** a potential security vulnerability, privacy issue, sensitive data exposure, or anything involving private endpoints or authentication/session information must **not** be filed as a public issue or committed here. Report it privately to Icon Train Smarter through the appropriate channel. It may be referenced publicly only after it has been resolved, and only with appropriate permission.

Full rules are in [CONTRIBUTING.md](CONTRIBUTING.md#privacy-checks).

## 12. Current Project Status

### Current evidence

| Artifact | Count | Where |
|---|---|---|
| Feature inventory entries | 13 features, 11 navigation observations | [docs/feature-inventory.md](docs/feature-inventory.md) |
| APK static analysis | Pass 1 (application envelope), app 2.5.0 | [docs/apk-analysis.md](docs/apk-analysis.md) |
| Test cases executed | 2 (both PASS) | [test-cases/authentication](test-cases/authentication) |
| Automated flows | 2 (Maestro) | [automation/maestro/flows](automation/maestro/flows) |
| Recorded environments | 1 physical Android device | [docs/test-environments.md](docs/test-environments.md) |
| Defect reports | 0 | [bugs/](bugs) — template and issue form ready |
| Exploratory session reports | 0 | [exploratory/](exploratory) — charter template ready |
| Execution / release reports | 0 | [reports/](reports) |

### Milestones

| Milestone | Status |
|---|---|
| M0 — QA Repository Foundation | Complete |
| M1 — Product Exploration & Feature Inventory | In progress |
| M2 — Risk Analysis & Test Design | Not started |
| M3 — Manual Functional Testing | Not started |
| M4 — Exploratory & Mobile-Specific Testing | Not started |
| M5 — Android Automation Foundation | In progress — Maestro foundation, preflight and first two flows done |
| M6 — Automated Regression Coverage | Not started |
| M7 — AI Feature Evaluation | Not started |
| M8 — CI/CD & Reporting | Not started |
| M9 — Release Quality Assessment | Not started |

Work is tracked in [Issues](https://github.com/Ngetich-86/icon-training-mobile-qa/issues) and [Milestones](https://github.com/Ngetich-86/icon-training-mobile-qa/milestones).

### Limitations

- One physical Android device; no iOS, emulator or device-matrix coverage yet.
- Only signed-out authentication flows are covered so far; Premium-gated areas are not reachable without a subscription.
- No CI: flows run locally against the physical device. Wireless ADB on `ENV-001` drops intermittently, which is recorded as BLOCKED / INFRASTRUCTURE rather than as a product result.
- Test plan, risk assessment and release-quality documents are templates until M2/M9 work is done.

## 13. Author

**Gideon Ngetich**\
QA Engineer — Icon Train Smarter\
GitHub: [@Ngetich-86](https://github.com/Ngetich-86)

*This is a personal portfolio project. "Icon Training" and "Icon Train Smarter" are referenced only to identify the publicly available application under test. All trademarks belong to their respective owners.*
