# TC-AUTH-002 — Signed-out user can open the Forgot Password screen from Login

| Field | Value |
|---|---|
| Test Case ID | `TC-AUTH-002` |
| Title | Signed-out user can open the Forgot Password screen from Login |
| Feature / Area | Authentication / account entry: login (`FEAT-AUTH-002`) and Forgot Password (`FEAT-AUTH-003`) |
| Priority | Medium (provisional: the risk matrix, #11, has not been rated yet) |
| Type | Functional (navigation) |
| Preconditions | Icon Training 2.5.0 installed from Google Play on `ENV-001`. No user signed in. App data not cleared. |
| Test Data | None. No text is entered. |
| Status | PASS |
| Environment | `ENV-001` |
| Application Version | 2.5.0 |
| Evidence | Maestro run output summarized below. Raw debug output kept locally, not committed (contains device identifiers) |
| Notes | Automated by [`automation/maestro/flows/auth/TC-AUTH-002-open-forgot-password-from-login.yaml`](../../automation/maestro/flows/auth/TC-AUTH-002-open-forgot-password-from-login.yaml). Based on automation-reproduced navigation `NAV-LOG-010` and `NAV-LOG-005` in the [feature inventory](../../docs/feature-inventory.md). Out of scope: return navigation (the in-app back arrow exposes no semantic selector; Android system Back leads elsewhere, `NAV-LOG-011`), entering an email, *Send OTP*, OTP delivery, email validation and password-recovery behavior. The *Email* label is not asserted because the hierarchy does not expose it. |

**Steps**

1. Start from the signed-out state.
2. Stop and relaunch Icon Training without clearing app data.
3. On the signed-out launch screen, tap *Login*.
4. On the login screen, tap *Forgot password?*.

**Expected Result**

- After step 2: *Start* is visible.
- After step 3: *Log in to your account* is visible.
- After step 4: the heading *Forgot Password*, the text *Just enter the Email address associated with your account* and the *Send OTP* button are visible.

**Actual Result**

2026-10-02 (automated, Maestro 2.11.0, physical device): the app relaunched to *Start*. Tapping *Login* showed *Log in to your account*. Tapping *Forgot password?* showed *Forgot Password*, *Just enter the Email address associated with your account* and *Send OTP*. All assertions completed, exit code 0. No text was entered, *Send OTP* was not tapped, and the input was still empty after the run.

**Execution history**

| Date | App version | Environment | Status | Evidence | Tester |
|---|---|---|---|---|---|
| 2026-10-02 | 2.5.0 | `ENV-001` (physical OPPO Reno5 5G) | PASS | Maestro run, exit code 0; raw output local only | Maestro 2.11.0 (automated) |
