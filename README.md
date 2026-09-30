# Icon Training — Mobile QA Engineering Portfolio

> **Project status: PLANNING / INITIAL SETUP**
> No test execution has been performed yet. This repository has no test results, defect reports, coverage figures or CI results. They will be added only as real, verified work is completed.

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

**Out of scope:**

- Reverse engineering, decompiling or modifying the application
- Inspecting or testing private/internal APIs or backend systems
- Security or penetration testing of production infrastructure
- Load or stress testing against production services
- Any testing that uses real user accounts or data other than the maintainer's own authorized test accounts

## 4. Planned Testing Types

- Risk-based QA planning
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

## 5. Planned Technology Stack

All items below are **PLANNED**. None are implemented yet.

| Purpose | Tool | Status |
|---|---|---|
| Mobile automation driver | Appium | PLANNED |
| Test runner / framework | WebdriverIO | PLANNED |
| Language | TypeScript | PLANNED |
| Target devices | Android Emulator / authorized physical Android device | PLANNED |
| CI/CD | GitHub Actions | PLANNED |
| Reporting | Allure | PLANNED |

## 6. Repository Structure

```
.
├── README.md                  Project overview (this file)
├── LICENSE
├── CONTRIBUTING.md            Workflow, branching, commits, evidence and privacy rules
├── docs/                      Strategy, plan, risk, environments, automation, AI, release report
├── test-cases/                Manual test cases, one folder per feature area
├── exploratory/               Exploratory charters and session reports
├── bugs/                      Defect reports, template and sanitized evidence
├── automation/                Future Appium + WebdriverIO + TypeScript framework
├── test-data/                 Synthetic test data only
├── reports/                   Execution, regression and release reports
└── .github/                   Issue/PR templates and (future) workflows
```

## 7. QA Workflow

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

*No environments have been recorded yet.*

## 9. Automation Roadmap

Automation will begin only after:

1. Application exploration
2. Feature inventory
3. Risk analysis
4. Manual test design
5. Identification of stable automation candidates

Planned architecture: Appium → WebdriverIO → TypeScript → Screen Objects → reusable fixtures/utilities → smoke/functional/regression suites → GitHub Actions → Allure reports.

See [automation/README.md](automation/README.md) and [docs/automation-strategy.md](docs/automation-strategy.md).

## 10. Reporting

Planned reports:

- **Execution reports** (`reports/execution/`): results of each manual test cycle
- **Regression reports** (`reports/regression/`): manual and automated regression results
- **Release quality reports** (`reports/release/`, [docs/release-quality-report.md](docs/release-quality-report.md)): overall quality assessment for a tested version
- **Allure reports**: generated by CI once automation exists (planned)

*No reports have been produced yet.*

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

**PLANNING / INITIAL SETUP**

| Milestone | Status |
|---|---|
| M0 — QA Repository Foundation | Complete |
| M1 — Product Exploration & Feature Inventory | Not started |
| M2 — Risk Analysis & Test Design | Not started |
| M3 — Manual Functional Testing | Not started |
| M4 — Exploratory & Mobile-Specific Testing | Not started |
| M5 — Android Automation Foundation | Not started |
| M6 — Automated Regression Coverage | Not started |
| M7 — AI Feature Evaluation | Not started |
| M8 — CI/CD & Reporting | Not started |
| M9 — Release Quality Assessment | Not started |

## 13. Author

**Gideon Ngetich**\
QA Engineer — Icon Train Smarter\
GitHub: [@Ngetich-86](https://github.com/Ngetich-86)

*This is a personal portfolio project. "Icon Training" and "Icon Train Smarter" are referenced only to identify the publicly available application under test. All trademarks belong to their respective owners.*
