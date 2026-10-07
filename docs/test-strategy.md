# Test Strategy

> **Status:** DRAFT. The sections below define the intended approach. Product-specific content will be added only after verified exploration of the application (Milestone M1).

| Field | Value |
|---|---|
| Document owner | _TBD_ |
| Version | 0.1 (draft) |
| Last updated | _TBD_ |
| Application under test | Icon Training / Icon Train Smarter (publicly available Android app) |
| Application version(s) | _To be recorded; see [test-environments.md](test-environments.md)_ |

## 1. Purpose

Define the overall approach for assessing the quality of the publicly available Icon Training mobile application as a personal QA engineering portfolio. The approach is risk-based, evidence-driven and privacy-first.

## 2. Scope

**In scope** (provisional, to be confirmed by the M1 feature inventory):

- Authentication, onboarding, navigation
- Workouts and workout tracking
- AI coaching features
- Recovery and nutrition features
- Android permissions and Health Connect integration
- Mobile-specific behavior: lifecycle, interruptions, network conditions, orientation
- Accessibility

**Static analysis (in scope, with limits):** static analysis of APK artifacts extracted from the maintainer's own installed Google Play copy, solely for QA architecture understanding and test design ([apk-analysis.md](apk-analysis.md)). Raw APK files and decompiler output stay local and are never committed. Static findings are not treated as runtime behavior until observed on a device.

**Out of scope:**

- Modifying, repackaging or re-signing the application; bypassing app or platform protections
- Private/internal APIs and backend systems
- Unauthorized security/penetration testing, including of production infrastructure
- Publishing recovered proprietary source code, secrets or sensitive configuration values
- Destructive testing
- Performance/load testing against production services
- iOS (unless added later with a suitable device)

## 3. Objectives

- Identify and prioritize product quality risks.
- Design test cases that trace to features and risks.
- Execute and document tests against recorded versions and environments.
- Report defects clearly and reproducibly.
- Automate stable, high-value regression checks.
- Produce an evidence-based release quality assessment.

## 4. Quality Risks

Quality risks will be identified and rated in [risk-assessment.md](risk-assessment.md) after product exploration. Risk categories to consider:

- Functional correctness
- Data integrity (for example, workout history and tracked metrics)
- Integration with device services (permissions, Health Connect)
- Reliability under interruptions and poor networks
- Usability and accessibility
- AI output quality and safety
- Privacy of user data displayed in the app

## 5. Test Levels

| Level | Applicability |
|---|---|
| System testing (black-box, via the UI) | Primary level |
| End-to-end user journeys | Primary level |
| Integration with device/OS services | Where observable from the device (permissions, Health Connect) |
| API testing | Only where legally and technically appropriate. No private endpoints. |
| Unit / component testing | Not applicable (no access to source code) |

## 6. Test Types

- Smoke
- Functional
- Regression
- Exploratory (session-based)
- Negative
- Boundary / edge case
- Mobile-specific (lifecycle, gestures, orientation, backgrounding)
- Network-condition and interruption
- Permission
- Accessibility
- AI feature evaluation ([ai-testing-strategy.md](ai-testing-strategy.md))
- Automated UI regression (planned; [automation-strategy.md](automation-strategy.md))

## 7. Entry Criteria

- [ ] Application version recorded
- [ ] Test environment recorded
- [ ] Test cases for the cycle reviewed and in NOT RUN state
- [ ] Authorized test account(s) and synthetic test data available
- [ ] Evidence capture and sanitization process ready

## 8. Exit Criteria

- [ ] All planned test cases for the cycle have a recorded status
- [ ] All FAIL results have a linked defect report
- [ ] Critical/Major defects reviewed and their status documented
- [ ] Execution summary produced
- [ ] Evidence sanitized and reviewed

## 9. Test Environment

See [test-environments.md](test-environments.md). Planned: Android Emulator and/or an authorized physical Android device.

## 10. Test Data

- Synthetic data only (`test-data/synthetic/`)
- Authorized test accounts only. Credentials are never committed.
- No production user data or personal health information

## 11. Defect Management

- Defects are recorded with [bugs/bug-report-template.md](../bugs/bug-report-template.md) and tracked as GitHub Issues labeled `type:bug`.
- Severity and priority follow the guidance in the template.
- Security/privacy vulnerabilities follow responsible disclosure and are **never** filed publicly.

## 12. Automation Strategy

See [automation-strategy.md](automation-strategy.md). Automation starts only after manual test design identifies stable candidates.

## 13. Reporting

- Execution reports per cycle (`reports/execution/`)
- Regression reports (`reports/regression/`)
- Release quality report ([release-quality-report.md](release-quality-report.md))

## 14. Limitations

- Black-box testing only. There is no access to source code, internal requirements or backend systems.
- Results apply only to the recorded versions, devices and environments.
- Device coverage is limited to the devices and emulators available to the maintainer.
- Server-side behavior may change independently of the app version.
- AI outputs are nondeterministic, so evaluation is rubric-based rather than exact-match.

## 15. Privacy / Confidentiality

- No proprietary code, confidential documents, internal communications or credentials.
- All evidence sanitized before commit. See [CONTRIBUTING.md](../CONTRIBUTING.md#privacy-checks).
- Knowledge from the maintainer's role at Icon Train Smarter that is not publicly available is **not** used or disclosed in this repository.
