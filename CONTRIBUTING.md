# Contributing

This is a personal QA engineering portfolio. These conventions keep the work traceable, reproducible and safe to publish.

## Issue-first workflow

1. Every piece of work starts from a GitHub Issue with a milestone, a `type:` label, an `area:` label and a `priority:` label.
2. Create a branch from `main` that references the issue number.
3. Do the work. Record only what was actually observed.
4. Open a pull request that links the issue (`Closes #<n>`) and complete the PR checklist.
5. Review the diff, including the privacy checks below, before merging.

## Branch naming

```
docs/<issue>-short-description
test/<issue>-short-description
automation/<issue>-short-description
fix/<issue>-short-description
ci/<issue>-short-description
```

Examples: `docs/3-test-case-schema`, `test/24-authentication-execution`, `ci/49-github-actions`.

## Commit conventions

Use [Conventional Commits](https://www.conventionalcommits.org/)-style prefixes:

| Prefix | Use for |
|---|---|
| `docs:` | Documentation, strategy, plans, templates |
| `test:` | Test cases, execution results, exploratory sessions |
| `feat:` | New automation capabilities (framework, screens, suites) |
| `fix:` | Corrections to tests, automation or docs |
| `ci:` | GitHub Actions and pipeline changes |
| `chore:` | Housekeeping (dependencies, config, repo maintenance) |

Rules:

- Write commit messages in the imperative mood: `docs: add test-case schema`.
- Reference the issue: `test: record authentication smoke results (#24)`.
- Never rewrite commit dates or fabricate history.

## Test evidence requirements

- Every recorded result (PASS / FAIL / BLOCKED / SKIPPED) must include the **application version**, **device**, **OS version** and **date tested**.
- FAIL results and bug reports must include reproducible steps and **sanitized** evidence (screenshot, recording or log excerpt).
- Evidence files are named `<ID>_<short-description>_<YYYY-MM-DD>.<ext>`, for example `BUG-001_login-error_2026-10-05.png`.
- Store evidence under `bugs/evidence/` or next to the relevant report in `reports/`.
- Never mark a test PASS without actually executing it. New test cases default to **NOT RUN**.
- Do not publish metrics (pass rate, coverage, defect counts) unless they are derived from recorded results in this repository.

## Privacy checks

The following **MUST NOT** be committed:

- Passwords
- Authentication tokens
- Session cookies
- Private API keys
- Production user information
- Personal health information
- Private company documents
- Proprietary source code
- Internal issue-tracker screenshots
- Internal communications
- Confidential requirements
- Private endpoints
- Secrets of any kind
- Unsanitized logs containing personal information

### Evidence sanitization checklist

Before committing any screenshot, recording or log, confirm that:

- [ ] Names, email addresses, phone numbers and usernames are redacted or belong to synthetic test accounts
- [ ] Health, body and fitness metrics are synthetic, or redacted if they are personal
- [ ] Account IDs, device IDs, advertising IDs and IP addresses are redacted
- [ ] Location data, maps and addresses are redacted
- [ ] Notification shade and status bar show no personal content
- [ ] No tokens, cookies, headers or URLs with query secrets appear in logs
- [ ] No internal tools, dashboards or communications are visible
- [ ] Redaction is destructive (solid boxes, not blur) and metadata (EXIF/GPS) is stripped

### Synthetic data

Use synthetic test data (`test-data/synthetic/`) whenever possible. Use only test accounts you are authorized to use. Never use real users' accounts.

### Responsible disclosure

Do **not** open public issues or commit details about potential security or privacy vulnerabilities. Report them privately to Icon Train Smarter through the appropriate channel.

## Pull request requirements

- Linked issue (`Closes #<n>`)
- Correct `type:`, `area:` and `priority:` labels and milestone
- Description of what changed and why
- For test results: application version, environment and evidence links
- Privacy checklist completed
- No generated artifacts (`node_modules/`, `allure-results/`, raw captures) committed
- `git diff --check` passes (no whitespace errors)
