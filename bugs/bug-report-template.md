# Bug Report Template

> **Status:** TEMPLATE. Copy this template to `bugs/BUG-XXX-short-title.md` and, where appropriate, to a GitHub Issue using the **Bug report** issue form. Record only behavior you actually observed. **Do not** use this template for security or privacy vulnerabilities. Report those privately (see [README](README.md#responsible-disclosure)).

---

| Field | Value |
|---|---|
| Bug ID | _BUG-XXX_ |
| Title | _[Area] Concise description of the problem_ |
| Application Version | _Exact version and build_ |
| Environment | _Environment ID (see docs/test-environments.md)_ |
| Device | _Model / emulator image_ |
| OS Version | _Android version / API level_ |
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

## Relevant Logs

_Sanitized, minimal log excerpt, if relevant. Remove tokens, identifiers and personal data._

```
```

## Notes

_Workarounds, related issues, variations tried, or open questions._

---

## Severity guidance

- **Severity** is the **impact** of the defect on the user or product. It is set by the reporter from the observed behavior and does not change with schedules or opinions about urgency.
- **Priority** is the **urgency**, i.e. the order in which the defect should be addressed. It depends on severity but also on context such as how many users are affected, how often it occurs and release timing.

A defect can be high severity and low priority (e.g. a crash in a rarely used path), or low severity and high priority (e.g. a spelling mistake on the first screen every user sees).

Choose severity from the impact, not from how the defect feels. Use the lowest level whose definition fits.

| Severity | Definition (impact) | Generic examples (hypothetical) |
|---|---|---|
| **Critical** | A core user journey cannot be completed and there is no workaround, or user data is lost or corrupted. | Any app: the app closes immediately on every launch; data a user saved is no longer present after a restart. |
| **Major** | A feature does not work or produces incorrect results, and the workaround is difficult or unreasonable; or a major accessibility barrier. | Any app: a form rejects all valid input; a saved value is displayed with the wrong number; a button cannot be activated with a screen reader. |
| **Minor** | A feature works but behaves incorrectly in a limited way, or an easy workaround exists. | Any app: a validation message names the wrong field; text is clipped on a small screen; a change applies only after reopening the screen. |
| **Trivial** | Cosmetic issue with no functional impact. | Any app: a typo; inconsistent spacing or capitalization. |

*These examples are generic and hypothetical. They are not observations of Icon Training and do not describe any real defect.*

Potential security or privacy issues are not rated here. They follow [responsible disclosure](README.md#responsible-disclosure) instead of the public defect workflow.

## Priority guidance

| Priority | Meaning (urgency) |
|---|---|
| Critical | Should be addressed immediately, before other work |
| High | Should be addressed in the next release |
| Medium | Should be addressed when capacity allows |
| Low | Can be deferred; fix if convenient |

In this independent portfolio, the reporter records a **suggested** priority. It is not a commitment by Icon Train Smarter.
