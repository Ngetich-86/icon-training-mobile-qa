# TC-AUTH-001 — Signed-out app launch shows the signed-out launch screen

| Field | Value |
|---|---|
| Test Case ID | `TC-AUTH-001` |
| Title | Signed-out app launch shows the signed-out launch screen |
| Feature / Area | Authentication / account entry: signed-out launch (`FEAT-LCH-002`) |
| Priority | High (provisional: the risk matrix, #11, has not been rated yet) |
| Type | Smoke |
| Preconditions | Icon Training 2.5.0 installed from Google Play on `ENV-001`. No user signed in. App data not cleared. |
| Test Data | None |
| Status | PASS |
| Environment | `ENV-001` |
| Application Version | 2.5.0 |
| Evidence | Maestro run output summarized below. Raw debug output kept locally, not committed (contains device identifiers) |
| Notes | Automated by [`automation/maestro/flows/smoke/TC-AUTH-001-signed-out-launch-screen.yaml`](../../automation/maestro/flows/smoke/TC-AUTH-001-signed-out-launch-screen.yaml). Based on automation observations `NAV-LOG-009` / `FEAT-LCH-002` in the [feature inventory](../../docs/feature-inventory.md). The purpose of *Start* is not established and is not tested here. |

**Steps**

1. Start from the signed-out state (the app may be running or stopped).
2. Stop and relaunch Icon Training without clearing app data.
3. Wait for the first stable screen.

**Expected Result**

- A *Start* control is visible.
- The text *Have an account?* is visible.
- A *Login* control is visible.

**Actual Result**

2026-10-02 (automated, Maestro 2.11.0): `launchApp` relaunched the app without clearing data. *Start*, *Have an account?* and *Login* were all visible: the three assertions completed and the flow exited with code 0. The app's runtime permissions were unchanged after the run.

**Execution history**

| Date | App version | Environment | Status | Evidence | Tester |
|---|---|---|---|---|---|
| 2026-10-02 | 2.5.0 | `ENV-001` | PASS | Maestro run, exit code 0; raw output local only | Maestro 2.11.0 (automated) |
