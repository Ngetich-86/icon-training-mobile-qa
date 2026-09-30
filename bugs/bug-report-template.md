# Bug Report Template

> Copy this template to `bugs/BUG-XXX-short-title.md` and, where appropriate, to a GitHub Issue using the **Bug report** issue form. Record only behavior you actually observed. **Do not** use this template for security or privacy vulnerabilities. Report those privately (see [README](README.md#responsible-disclosure)).

---

| Field | Value |
|---|---|
| Bug ID | _BUG-XXX_ |
| Title | _[Area] Concise description of the problem_ |
| Application Version | _Exact version and build_ |
| Environment | _Environment ID (see docs/test-environments.md)_ |
| Device | _Model / emulator image_ |
| OS | _Android version / API level_ |
| Severity | _Critical / Major / Minor / Trivial_ |
| Priority | _Critical / High / Medium / Low_ |
| Reproducibility | _Always / Intermittent (x of y attempts) / Once_ |
| Related test case | _TC-XXX, if any_ |
| Date observed | _YYYY-MM-DD_ |
| Reporter | _Name / handle_ |

## Preconditions

_State required before step 1 (account state, permissions, data, network)._

## Steps to Reproduce

1.
2.
3.

## Expected Result

_What should happen, and the basis for that expectation (e.g. app's own UI text, platform convention, accessibility guideline)._

## Actual Result

_What actually happened. Describe it factually, without speculating about cause._

## Evidence

_Links to sanitized screenshots or recordings in `bugs/evidence/`._

## Logs

_Sanitized, minimal log excerpt, if relevant. Remove tokens, identifiers and personal data._

```
```

## Notes

_Workarounds, related issues, variations tried, or open questions._

---

## Severity guidance

Severity describes the **impact on the user or product**. Priority describes **how urgently the issue should be addressed** and is set with product context.

| Severity | Definition | Examples (illustrative only) |
|---|---|---|
| **Critical** | Blocks a core journey with no workaround, causes data loss or corruption, crashes on launch, or exposes personal data. | App crashes on launch; completed workout data is lost; another user's data is visible. |
| **Major** | Significant feature failure or incorrect result with a difficult workaround; major accessibility barrier. | A key feature fails consistently; tracked values are recorded incorrectly; a screen is unusable with a screen reader. |
| **Minor** | Feature works but with limited-impact incorrect behavior, or an easy workaround exists. | Incorrect validation message; layout clipping on some screen sizes; a setting requires reopening the screen to apply. |
| **Trivial** | Cosmetic issue with no functional impact. | Typo; minor alignment or spacing inconsistency; inconsistent capitalization. |

*The examples above illustrate the categories only. They are not observed defects.*

## Priority guidance

| Priority | Meaning |
|---|---|
| Critical | Must be addressed immediately |
| High | Should be addressed in the next release |
| Medium | Should be addressed when capacity allows |
| Low | Nice to fix |
