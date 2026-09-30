# Bugs

> **No defects have been reported yet.** This folder will contain defect reports only for behavior actually observed during recorded test execution.

## Contents

| Path | Purpose |
|---|---|
| [bug-report-template.md](bug-report-template.md) | Standard defect report template and severity/priority guidance |
| `BUG-XXX-short-title.md` | Individual defect reports (none yet) |
| `evidence/` | **Sanitized** screenshots, recordings and log excerpts |

## Workflow

1. Reproduce the issue and confirm its reproducibility.
2. Record the environment (app version, device, OS, network).
3. Capture evidence, then **sanitize it** (see the [CONTRIBUTING.md checklist](../CONTRIBUTING.md#evidence-sanitization-checklist)).
4. Create `BUG-XXX-short-title.md` from the template, and optionally a GitHub Issue labeled `type:bug`.
5. Link the bug from the failing test case.
6. Retest when a new app version is available, and record the result with the new version number.

## Naming

- Bug IDs: `BUG-001`, `BUG-002`, … assigned sequentially
- Evidence: `bugs/evidence/BUG-001_short-description_YYYY-MM-DD.png`

## Responsible disclosure

**Never** publish potential security or privacy vulnerabilities here or in public issues. Report them privately to Icon Train Smarter through the appropriate channel. A vulnerability may be referenced here only after it has been resolved, and only with appropriate permission.
