# Test Cases

> **One test case exists:** [`TC-AUTH-001`](authentication/TC-AUTH-001-signed-out-launch-screen.md) (smoke, automated with Maestro). Broader test design continues in Milestone M2, after the verified feature inventory (M1).

## Organization

One folder per feature area. The areas are provisional and will be confirmed against the feature inventory.

| Folder | Area | ID prefix |
|---|---|---|
| `authentication/` | Sign up, sign in, sign out, password reset | `TC-AUTH-` |
| `onboarding/` | First-run experience, profile setup | `TC-ONB-` |
| `navigation/` | App navigation, back behavior, deep screens | `TC-NAV-` |
| `workouts/` | Browsing and selecting workouts/programs | `TC-WKT-` |
| `workout-tracking/` | Performing and logging workouts | `TC-TRK-` |
| `ai-coaching/` | AI coaching features | `TC-AIC-` |
| `recovery/` | Recovery features | `TC-REC-` |
| `nutrition/` | Nutrition features | `TC-NUT-` |
| `permissions/` | Android runtime permissions | `TC-PRM-` |
| `health-connect/` | Health Connect integration | `TC-HC-` |

The area descriptions above are expected topics, not confirmed app features.

File naming: `<area>/TC-<PREFIX>-001-short-title.md`. Related cases may also be grouped in one file per area.

## Test case schema

| Field | Description |
|---|---|
| **Test Case ID** | Unique ID, e.g. `TC-AUTH-001` |
| **Title** | Short, specific description of what is verified |
| **Feature / Area** | Feature area / sub-feature |
| **Priority** | Critical / High / Medium / Low (from the risk assessment) |
| **Type** | Smoke / Functional / Regression / Negative / Boundary / Mobile-specific / Permission / Accessibility / Network / AI evaluation |
| **Preconditions** | Required state before the steps |
| **Test Data** | Synthetic data used (reference `test-data/synthetic/`). Never real credentials. |
| **Steps** | Numbered, atomic actions |
| **Expected Result** | Observable expected outcome |
| **Actual Result** | What was observed. Leave blank until executed. |
| **Status** | One of the allowed statuses below |
| **Environment** | Environment ID from `docs/test-environments.md` |
| **Application Version** | Exact version tested |
| **Evidence** | Relative links to sanitized evidence (see [CONTRIBUTING.md](../CONTRIBUTING.md#evidence-naming-and-storage)) |
| **Notes** | Linked bugs, observations, follow-ups |

## Allowed execution statuses

| Status | Meaning |
|---|---|
| `NOT RUN` | Designed but not yet executed. **Default for all new test cases.** |
| `PASS` | Executed, and the observed actual result matches the expected result. |
| `FAIL` | Executed, and an observed actual result differs from the expected result. A linked bug report is required. |
| `BLOCKED` | Execution was attempted or planned but could not be completed because of a blocker (e.g. a defect in an earlier step, unavailable test account, environment problem). The blocker must be identified, with a link to the related bug or issue where one exists. |
| `SKIPPED` | Intentionally not executed in this cycle. The reason must be recorded (e.g. out of scope for the cycle, feature not present in this version). |

### Rules

- New test cases **must** default to `NOT RUN`.
- **Never** mark a test `PASS` automatically or without actually executing it.
- A status other than `NOT RUN` requires **Environment**, **Application Version**, date and tester in the execution history.
- `PASS` and `FAIL` require an **Actual Result** describing what was observed.
- `FAIL` requires a linked bug report and sanitized evidence.
- `BLOCKED` and `SKIPPED` require the blocker or reason in **Notes**.
- When re-executing against a new version, record the new result with the new version and do not overwrite history. Use the execution history table.

## Test case template

```markdown
### TC-XXX-000 — <Title>

| Field | Value |
|---|---|
| Test Case ID | TC-XXX-000 |
| Title | |
| Feature / Area | |
| Priority | |
| Type | |
| Preconditions | |
| Test Data | |
| Status | NOT RUN |
| Environment | |
| Application Version | |
| Evidence | |
| Notes | |

**Steps**

1.
2.
3.

**Expected Result**

-

**Actual Result**

_Not yet executed._

**Execution history**

| Date | App version | Environment | Status | Evidence | Tester |
|---|---|---|---|---|---|
```
