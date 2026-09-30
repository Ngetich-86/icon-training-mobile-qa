# GitHub Actions Workflows (PLANNED)

> **No workflows are configured yet.** CI/CD is planned for Milestone M8, after the automation framework exists (M5–M6).

## Planned workflows

| Workflow | Purpose | Status |
|---|---|---|
| Docs checks | Markdown lint and link checks | PLANNED |
| Smoke automation | Run the automated smoke suite on an Android emulator | PLANNED |
| Regression automation | Run the regression suite on schedule or on demand | PLANNED |
| Reporting | Publish Allure results as CI artifacts | PLANNED |

## Rules

- Secrets (test-account credentials) come only from GitHub Actions encrypted secrets.
- Workflows must not print secrets or personal data to logs.
- A CI status badge will be added to the README **only after** a workflow genuinely passes.
