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

## Documentation standards

### Document status

Every document in `docs/` and every template starts with a status line directly under the title:

```markdown
> **Status:** TEMPLATE. <one sentence on what is and is not filled in>
```

| Status | Meaning |
|---|---|
| `TEMPLATE` | Structure only. Contains placeholders and no product-specific content. |
| `DRAFT` | Being written. Content may be incomplete and is not yet based on observed behavior. |
| `PLANNED` | Describes intended future work. Nothing in it has been done. |
| `VERIFIED` | Content is based on observed testing, and records the application version, environment and date it applies to. |

Folder READMEs describe what the folder holds and state plainly when it is still empty (for example, "No test cases have been written or executed yet.").

Rules:

- Update the status when the content changes. Do not leave a `TEMPLATE` label on a filled-in document, or a `VERIFIED` label on unverified content.
- Keep planned and executed work separate. Planned work uses future tense ("will be tested"). Only a `VERIFIED` document, a recorded test result or a bug report may describe application behavior, and only for the version and environment it records.
- Placeholders must not look like real values: use `XXX` in IDs (e.g. `BUG-XXX`), `_TBD_`, italic hints, or leave the cell empty.

### IDs

| Prefix | Item | Example | Location |
|---|---|---|---|
| `TC-<AREA>-` | Test case | `TC-AUTH-001` | `test-cases/<area>/` |
| `BUG-` | Defect report | `BUG-001` | `bugs/` |
| `CH-` | Exploratory charter | `CH-001` | `exploratory/charters/` |
| `SR-` | Exploratory session report | `SR-001` | `exploratory/session-reports/` |
| `ENV-` | Test environment record | `ENV-001` | `docs/test-environments.md` |
| `TP-` | Test plan | `TP-001` | `docs/` |
| `RQR-` | Release quality report | `RQR-001` | `reports/release/` |

- Numbers are three digits, zero-padded, assigned sequentially and never reused, even if the item is deleted.
- Area codes for test cases are listed in [test-cases/README.md](test-cases/README.md).
- Refer to other items by ID (e.g. "see `BUG-004`"), linking to the file where practical.

### File naming

- Lowercase, hyphen-separated file names: `test-environments.md`, not `Test_Environments.md`. Conventional files (`README.md`, `CONTRIBUTING.md`, `LICENSE`) keep their usual names.
- Items with an ID start with the ID: `TC-AUTH-001-valid-sign-in.md`, `BUG-001-short-title.md`, `CH-001-short-title.md`, `SR-001-YYYY-MM-DD-short-title.md`.
- Reports: `EXEC-YYYY-MM-DD-<cycle>.md` and `REG-YYYY-MM-DD-<version>.md`.
- Evidence: see [Evidence naming and storage](#evidence-naming-and-storage).

### Markdown

- One `#` title per file, followed by the status line or folder notice.
- Use `##` / `###` headings in order without skipping levels.
- Use tables for structured fields (as in the templates) and numbered lists for steps.
- Wrap IDs, statuses, paths and commands in backticks.
- Use relative links between repository files.

### Versions, environments and dates

- **Application version:** record it exactly as shown in the app or store listing, including the build number where available (e.g. `x.y.z (build nnn)`). Never write "latest".
- **Environment:** refer to an `ENV-` record in [docs/test-environments.md](docs/test-environments.md) rather than repeating device details in each file.
- **Dates:** ISO 8601, `YYYY-MM-DD`. Record the date the work was actually done.

### Terminology

- **Test case:** a designed, scripted check (`TC-`). **Test execution:** one run of a test case against a recorded version and environment.
- **Defect / bug:** an observed mismatch between expected and actual behavior, recorded as `BUG-`.
- **Evidence:** a sanitized screenshot, recording or log excerpt that supports a recorded result.
- **Severity** is the impact of a defect. **Priority** is how urgently it should be addressed. See [bugs/bug-report-template.md](bugs/bug-report-template.md).
- Execution statuses (`NOT RUN`, `PASS`, `FAIL`, `BLOCKED`, `SKIPPED`) are defined in [test-cases/README.md](test-cases/README.md#allowed-execution-statuses). Always write them in upper case and do not use other status words for results.
- Call the application "Icon Training" and the company "Icon Train Smarter".

### Reproducibility

Anyone reading a result or bug report should be able to repeat it. Every result records the application version, environment ID, date, test data used (synthetic) and the exact steps.

## Test evidence requirements

- Every recorded result (PASS / FAIL / BLOCKED / SKIPPED) must include the **application version**, **device**, **OS version** and **date tested**.
- FAIL results and bug reports must include reproducible steps and **sanitized** evidence (screenshot, recording or log excerpt).
- Evidence must follow [Evidence naming and storage](#evidence-naming-and-storage) and pass the [sanitization checklist](#evidence-sanitization-checklist).
- Never mark a test PASS without actually executing it. New test cases default to **NOT RUN**.
- Do not publish metrics (pass rate, coverage, defect counts) unless they are derived from recorded results in this repository.

## Privacy checks

This repository is public. Anything committed, and anything pasted into an issue, pull request or comment, should be treated as permanently published, even if it is deleted later.

The following **MUST NOT** be committed or posted:

- Passwords, authentication tokens, session cookies, API keys, authorization headers or secrets of any kind
- Names, email addresses, phone numbers, usernames or profile photographs of real people
- Personal health information, and health or fitness metrics linked to a real person
- Production user information
- Device identifiers (serial numbers, IMEIs, advertising IDs, Android IDs) and IP addresses
- Precise location data
- Internal URLs, private endpoints and internal tools or dashboards
- Private company documents, proprietary documentation, confidential requirements or proprietary source code
- Internal communications, internal issue-tracker screenshots, and internal issue IDs where they are confidential
- Unsanitized screenshots, recordings, logs or reports
- APK binaries (`.apk`, `.apks`, `.aab`), decompiled or recovered proprietary source, raw static-analysis output (JADX/Apktool output, extracted `.dex` or `.so` files), and configuration values recovered from the app. Only sanitized findings are published, as in [docs/apk-analysis.md](docs/apk-analysis.md).

### Evidence types

These rules apply to all evidence, including:

| Evidence | What to look for |
|---|---|
| Screenshots | Visible personal data, notifications, status bar, other apps in view |
| Screen recordings | Every frame, not only the key moment. Audio, keyboard suggestions, notifications appearing mid-recording |
| Logs and console output (logcat, Appium, WebdriverIO) | Tokens, headers, cookies, URLs with query parameters, account and device IDs, email addresses |
| HTTP/API evidence | Request/response headers, cookies, bodies containing personal data. Never commit HAR files or packet captures |
| Crash evidence (stack traces, ANR traces, bug reports) | Device identifiers, account data, file paths containing user names. Commit a minimal excerpt only, never a full `bugreport` archive |
| Device information | Model and OS version are fine. Serial numbers, IMEIs and account names are not |
| Test reports (including generated Allure output) | Embedded screenshots, logs and environment details |

### Sanitization rules

- **Prefer synthetic data.** Evidence captured with synthetic test accounts and data (see below) needs little redaction.
- **Raw evidence is never committed by default.** Keep raw captures in a git-ignored location (`raw-evidence/`, `unsanitized/`, `tmp/`) and commit only a sanitized copy.
- **Redaction must be destructive.** The original pixels or text must be removed from the file, not hidden:
  - Images: fill the area with a solid color and export a new flattened PNG/JPG. A box drawn as a separate layer, annotation or shape over the image is not enough, because it can be removed. Do not use blur or pixelation.
  - Recordings: trim or re-encode so that the sensitive frames are removed or permanently covered in the output file.
  - Text and logs: delete the value or replace it with a placeholder such as `<REDACTED>` or `<TOKEN>`. Do not only shorten or partially mask it.
- **Strip metadata** (EXIF, GPS, device model and author fields) from images and videos before committing.
- **Commit the minimum.** Crop screenshots and cut logs down to the lines relevant to the result.
- **Review before publication.** Open the final file, not the original, and check it against the checklist below before committing it or attaching it to an issue.

### Evidence sanitization checklist

Before committing or posting any screenshot, recording, log or report, confirm that:

- [ ] The file is a sanitized copy, not the raw capture
- [ ] Names, email addresses, phone numbers, usernames and profile photographs are removed, or belong to synthetic test accounts
- [ ] Health, body and fitness metrics are synthetic, or removed if they relate to a real person
- [ ] Account IDs, device identifiers, advertising IDs and IP addresses are removed
- [ ] Location data, maps and addresses are removed
- [ ] The notification shade, status bar and any other visible apps show no personal content
- [ ] No tokens, cookies, API keys, authorization headers or URLs with query secrets appear
- [ ] No internal URLs, private endpoints, internal tools, dashboards, communications or confidential issue IDs are visible
- [ ] Redaction is destructive (flattened solid fill or deleted text, not an overlay, blur or pixelation)
- [ ] Metadata (EXIF/GPS) is stripped
- [ ] Every frame of a recording has been reviewed

### Evidence naming and storage

- Name evidence `<ID>_<short-description>_<YYYY-MM-DD>.<ext>`, where `<ID>` is the related test case, bug or session report ID and the date is the capture date.
- Store bug evidence in `bugs/evidence/`, and other evidence next to the relevant report in `reports/` or `exploratory/session-reports/`.
- Save sanitized log excerpts as `.txt` files. `*.log` files are git-ignored so that raw logs are not committed by accident.
- Evidence is referenced from the test case, bug or report by relative link.

### Synthetic data

Use synthetic test data (`test-data/synthetic/`) whenever possible. Use only test accounts you are authorized to use. Never use real users' accounts or data.

### Responsible disclosure

The following must **not** be filed as public GitHub issues, posted in comments or committed:

- Potential security vulnerabilities
- Privacy issues, including exposure of personal or health data
- Sensitive data exposure of any kind
- Details of private or internal endpoints
- Authentication or session information (tokens, cookies, session behavior that could be abused)

Report these privately to Icon Train Smarter through the appropriate channel. They may be referenced publicly only after they have been resolved, and only with appropriate permission.

## Pull request requirements

- Linked issue (`Closes #<n>`)
- Correct `type:`, `area:` and `priority:` labels and milestone
- Description of what changed and why
- For test results: application version, environment and evidence links
- Privacy checklist completed
- No generated artifacts (`node_modules/`, `allure-results/`, raw captures) committed
- `git diff --check` passes (no whitespace errors)
