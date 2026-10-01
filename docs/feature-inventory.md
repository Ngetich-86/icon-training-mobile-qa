# Feature Inventory

> **Status:** DRAFT. Exploration in progress. Entries record only what was observed on `ENV-001` running Icon Training 2.5.0 on the dates shown. Nothing here is a test result.

| Field | Value |
|---|---|
| Related issue | #8 (Milestone M1) |
| Application | Icon Training |
| Application version | 2.5.0 (build/version code not exposed in Android App info) |
| Environment | `ENV-001` (see [test-environments.md](test-environments.md)) |
| Observation period | 2026-10-01 – ongoing |
| Observer | Gideon Ngetich (@Ngetich-86) |

## 1. Purpose

Record the features of Icon Training that have been **directly observed** on `ENV-001` running version 2.5.0. Risk analysis (#11) and test design (M2) build on this inventory.

This is **product exploration, not test execution**:

- An entry records that a screen, control or navigation path **exists and was seen**. It does not mean the feature works correctly.
- No `PASS` / `FAIL` results, test cases or bug reports are recorded here.
- Marketing material, store listings and non-public knowledge from the maintainer's role at Icon Train Smarter are **not** used as evidence.

## 2. Methodology

### 2.1 Observation workflow

1. The observer opens Icon Training 2.5.0 on `ENV-001`.
2. The observer supplies a screenshot or direct description of the current screen.
3. Only what is actually visible is recorded: screen identity, visible text, visible controls, visible navigation, obvious purpose and relevant state.
4. The observer performs **one** controlled navigation action.
5. The resulting screen is observed and recorded.
6. The navigation relationship is logged.
7. Exploration continues systematically from step 3.

The app is explored step by step, not by tapping through it quickly, so every entry can be traced to a specific observation.

### 2.2 Exploration order

The order below is a framework taken from the planned QA scope. **An area appearing in this list does not mean Icon Training 2.5.0 has it.** An area enters the inventory only when it is observed.

| Step | Area | Feature ID prefix |
|---|---|---|
| A | Application launch | `FEAT-LCH-` |
| B | Authentication / account entry | `FEAT-AUTH-` |
| C | Onboarding, if presented | `FEAT-ONB-` |
| D | Primary navigation | `FEAT-NAV-` |
| E | Home / dashboard | `FEAT-HOME-` |
| F | Workout / training areas | `FEAT-WKT-`, `FEAT-TRK-` (workout tracking) |
| G | AI-related areas, if present | `FEAT-AIC-` |
| H | Recovery-related areas, if present | `FEAT-REC-` |
| I | Nutrition-related areas, if present | `FEAT-NUT-` |
| J | Profile / account / settings | `FEAT-SET-` |
| K | Permission-related UI | `FEAT-PRM-` |
| L | Health Connect-related UI, if present | `FEAT-HC-` |
| M | Other features discovered | `FEAT-OTH-` (or a new prefix once the area is understood) |
| — | Premium / subscription (discovered 2026-10-01) | `FEAT-SUB-` |

`FEAT-` IDs are **feature inventory IDs, not test case IDs**. They follow the numbering rules in [CONTRIBUTING.md](../CONTRIBUTING.md#ids): three digits, zero-padded, sequential and never reused. The `TC-` convention is unchanged.

### 2.3 Observation statuses

| Status | Meaning |
|---|---|
| `OBSERVED` | Directly seen or reached on `ENV-001` running Icon Training 2.5.0. |
| `OBSERVED NAVIGATION` | A navigation relationship the observer personally followed on `ENV-001` (used in the navigation log). |
| `NOT EXPLORED` | Visible or referenced, but not yet opened enough to document. |
| `REQUIRES STATE` | Appears to need a prerequisite: a specific account, subscription, permission, workout state, historical data or similar. |
| `EXTERNAL` | The action visibly leaves the app or hands off to something outside it (e.g. browser, store, system settings, another app). |
| `UNKNOWN` | Not enough evidence yet to classify. |

For the acceptance criteria of #8, **only `OBSERVED` and `OBSERVED NAVIGATION` count as verified**. `NOT EXPLORED`, `REQUIRES STATE`, `EXTERNAL` and `UNKNOWN` entries are explicitly unverified.

`PASS` and `FAIL` are never used in this inventory. Visibility does not prove correctness.

## 3. Schema

### 3.1 Feature entries

| Field | Description |
|---|---|
| Feature ID | `FEAT-<AREA>-NNN` |
| Feature Area | Area from the exploration order |
| Screen / Feature | Name as shown in the app, or a neutral description if no title is shown |
| Observed Entry Point | Where it was reached from (screen + control) |
| Observable Purpose | What the screen visibly offers, without assumptions about internal behavior |
| Key Visible Controls | Buttons, tabs, fields and links actually visible |
| Observed Navigation / Destination | Destinations actually followed (see navigation log) |
| Required State / Preconditions | Account, permission, subscription or data state observed or visibly indicated |
| Observation Status | One status from section 2.3 |
| Environment | `ENV-001` |
| App Version | 2.5.0 |
| Date Observed | `YYYY-MM-DD` |
| Evidence Reference | `Textual observation`, or a link to sanitized evidence |
| Notes | Open questions, ambiguities, follow-ups |

### 3.2 Navigation log

| Field | Description |
|---|---|
| Nav ID | `NAV-LOG-NNN` (sequential) |
| From | Feature ID / screen |
| Action | The single action performed (e.g. "Tapped *<label>*") |
| To | Feature ID / screen reached, or the external destination |
| Status | `OBSERVED NAVIGATION` or `EXTERNAL` |
| Date Observed | `YYYY-MM-DD` |
| Notes | |

## 4. Evidence and privacy

- **Textual observations are the default.** Screenshots supplied during exploration are working material and are **not committed automatically**.
- A screenshot is published only when it adds value. Before that, it must pass the [evidence sanitization checklist](../CONTRIBUTING.md#evidence-sanitization-checklist) and follow [evidence naming and storage](../CONTRIBUTING.md#evidence-naming-and-storage).
- Treat the following as sensitive and redact or omit it: real name, email, profile photo, health information, weight, height, age or date of birth, workout history linked to the tester, nutrition, sleep or heart-rate data, location, notifications, tokens, account identifiers and any other personal information.
- Textual entries must not contain any of the above either. Describe the field ("a weight field is shown"), not the value.
- Potential security or privacy issues seen during exploration are not recorded here. Follow [responsible disclosure](../CONTRIBUTING.md#responsible-disclosure).

## 5. Feature inventory

| Feature ID | Feature Area | Screen / Feature | Observed Entry Point | Observable Purpose | Key Visible Controls | Observed Navigation / Destination | Required State / Preconditions | Observation Status | Environment | App Version | Date Observed | Evidence Reference | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `FEAT-LCH-001` | Application launch | Launch from existing app state | App icon on the device launcher, after the app was removed from Recent Apps | Normal launch of the installed app | _None recorded_ | `FEAT-SUB-001` (see `NAV-LOG-001`) | Existing app state on `ENV-001`: no cache or data cleared, no reinstall, no deliberate logout or reset. Account/session state: not shown at launch. An existing session was later indicated by the logout UI (`FEAT-AUTH-001`, `NAV-LOG-002`) | `OBSERVED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | The first stable screen shown after launch/loading was *Unlock Icon Premium*. The launch alone does not show the session state. Onboarding status is not established. |
| `FEAT-AUTH-001` | Authentication / account entry | *Log out* confirmation modal | Top-right arrow on *Unlock Icon Premium* (`FEAT-SUB-007`) | Asks for confirmation before ending the current session | Title *Log out*; message *Are you sure you want to log out? Your session will be ended.*; *Cancel*; *Log out* | *Cancel* → *Unlock Icon Premium*, `FEAT-SUB-001` (`NAV-LOG-003`); *Log out* → login screen, `FEAT-AUTH-002` (`NAV-LOG-004`) | An existing app session sufficient for the logout action to be presented | `OBSERVED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | Shown as a modal over the dimmed *Unlock Icon Premium* screen. A logout action is available in the observed current session, and the UI indicates an existing session. *Cancel* (tapped once, 2026-10-01) dismisses the modal and returns to the *Unlock Icon Premium* screen. *Log out* (tapped once, 2026-10-01) moved the app to the login screen (`FEAT-AUTH-002`): the app went from the existing-session UI to a signed-out login UI. Only this UI transition was observed. Not verified: server-side session invalidation, token revocation, or the effect on other sessions or devices. Not established: how or when the user originally authenticated, the authentication method used, or onboarding status. |
| `FEAT-AUTH-002` | Authentication / account entry | Login screen | *Log out* confirmation (`FEAT-AUTH-001`) → *Log out* (`NAV-LOG-004`) | Provides visible controls for signing in to an account | Icon branding/logo; text *Let's train smarter. Let's be Iconic*; text *Log in to your account*; *Email* input; *Password* input with a password-visibility icon; *Forgot password?*; *Log in*; separator *Or*; *Continue with Google* | *Forgot password?* → Forgot Password screen, `FEAT-AUTH-003` (`NAV-LOG-005`); *Continue with Google* → Google account selection, `FEAT-AUTH-004` (`NAV-LOG-007`) | Signed-out UI, reached by logging out | `OBSERVED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed (screen). Password-visibility interaction: direct user observation, no screenshot | Login options presented: email/password and Google. Seeing these options does not establish that either method authenticates. Password-visibility control (interaction observed 2026-10-01): with the Password field empty, tapping it changed the control's visible hide/show state. Whether entered characters are actually masked or revealed is unverified, because no text was entered. Not yet explored: email/password authentication; email, password and empty-field validation; invalid-credential handling; masking/unmasking of entered text; successful login behavior; Google authentication beyond account selection. *Continue with Google* (tapped once, 2026-10-01) opens a Google account-selection interface (`FEAT-AUTH-004`). *Forgot password?* (tapped once, 2026-10-01) opens the Forgot Password screen (`FEAT-AUTH-003`). No credentials were entered in any observation. |
| `FEAT-AUTH-003` | Authentication / account entry | *Forgot Password* screen | *Forgot password?* on the login screen (`FEAT-AUTH-002`, `NAV-LOG-005`) | Presents an email field and a *Send OTP* control for password recovery | Back arrow (upper left); heading *Forgot Password*; instruction *Just enter the Email address associated with your account*; *Email* input; *Send OTP* | Back arrow → login screen, `FEAT-AUTH-002` (`NAV-LOG-006`) | Signed-out login UI | `OBSERVED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | The password-recovery UI presents an email-based OTP recovery option. Back arrow (tapped once, 2026-10-01): returns to the login screen (`FEAT-AUTH-002`). Email input: visible, input and validation behavior `NOT EXPLORED`. *Send OTP*: visible, behavior `NOT EXPLORED`. No email was entered and no OTP request was submitted. Not observed: whether an OTP is sent or how it is delivered, account-matching requirements, OTP format, expiry, resend or rate limiting, account enumeration, invalid-email handling, what follows *Send OTP*, and successful password reset. |
| `FEAT-AUTH-004` | Authentication / account entry | Google account selection | *Continue with Google* on the login screen (`FEAT-AUTH-002`, `NAV-LOG-007`) | Presents a Google account-selection interface for continuing toward Google-based authentication | Text *Choose an account*; text *to continue to Icon Training*; multiple selectable Google account entries | Android Back → login screen, `FEAT-AUTH-002` (`NAV-LOG-008`) | Signed-out login screen, and Google accounts available on the Android device | `OBSERVED` | `ENV-001` | 2.5.0 | 2026-10-01 | Sensitive private observation screenshot — NOT COMMITTED | **System boundary:** this interface is provided by Google, not by Icon Training's own login UI. Account-specific details shown on screen are deliberately not recorded. No account was selected, no consent was granted, and authentication was not completed. Return path (observed 2026-10-01): pressing Android Back once closes the interface and returns to the Icon Training login screen without selecting an account; nothing is inferred about OAuth cancellation, token handling or backend state. For #8, the entry and return path is considered sufficiently discovered; the rest is deferred to later testing. Not observed: successful Google authentication, account creation or linking, requested permissions/scopes, consent, cancellation and error behavior, token exchange, backend authentication, and what follows account selection. Underlying OAuth/OpenID implementation details are not claimed. Relevant later to #10 (external dependencies). |
| `FEAT-SUB-001` | Premium / subscription | *Unlock Icon Premium* (one scrollable screen, captured in two screenshots) | First stable screen after launch (`NAV-LOG-001`) | Presents a Premium subscription offer | Heading *Unlock Icon Premium*; text *Get the most out of your training journey.*; list of Premium benefit descriptions; plan selection (`FEAT-SUB-002`); *Subscribe* (`FEAT-SUB-003`); *Promo Code* (`FEAT-SUB-004`); *Restore Purchases* (`FEAT-SUB-005`); *Terms* and *Privacy* (`FEAT-SUB-006`); top-right arrow icon (`FEAT-SUB-007`) | Top-right arrow → `FEAT-AUTH-001` (`NAV-LOG-002`) | A message on screen states: *An active Premium subscription is required to use Icon Training.* | `OBSERVED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | Benefit descriptions displayed: *Unlimited AI coach messages*; *Personalised workout & recovery plans*; *Advanced fitness reports & insights*; *Priority support*. This is promotional text on the screen. It is **not** evidence that these features exist or work, and no AI, recovery or reporting entries are created from it. |
| `FEAT-SUB-002` | Premium / subscription | Plan selection | `FEAT-SUB-001` | Choice between subscription plans | *Yearly* and *Monthly* options; *Monthly* appears visually selected | Not interacted with | — | `OBSERVED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | Displayed with *Monthly* selected (observation data on 2026-10-01 only, not canonical pricing): offer *Founding Member Monthly*; *43% Off*; previous price *KES 2,688.99/month* shown with strikethrough; current price *Ksh 1,518.99/month*; *7 days free trial included*; *Limited time to join*. Currency labels recorded exactly as shown. Selecting *Yearly* has not been tried, so its effect on the display is unknown. |
| `FEAT-SUB-003` | Premium / subscription | *Subscribe* control | `FEAT-SUB-001` | Visible subscribe action | *Subscribe* | Not followed | — | `NOT EXPLORED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | Visible only. What it opens or does has not been observed. |
| `FEAT-SUB-004` | Premium / subscription | *Promo Code* control | `FEAT-SUB-001` | Visible promo code entry point | *Promo Code* | Not followed | — | `NOT EXPLORED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | Visible only. |
| `FEAT-SUB-005` | Premium / subscription | *Restore Purchases* control | `FEAT-SUB-001` | Visible restore purchases entry point | *Restore Purchases* | Not followed | — | `NOT EXPLORED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | Visible only. |
| `FEAT-SUB-006` | Premium / subscription | *Terms* and *Privacy* links | `FEAT-SUB-001` | Visible links labelled Terms and Privacy | *Terms*; *Privacy* | Not followed | — | `NOT EXPLORED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | Destinations not observed. Whether they open inside or outside the app is unknown. |
| `FEAT-SUB-007` | Premium / subscription | Top-right arrow icon | `FEAT-SUB-001` | Tapping it opens a *Log out* confirmation modal | Arrow icon, top right | *Log out* confirmation modal, `FEAT-AUTH-001` (`NAV-LOG-002`) | — | `OBSERVED` | `ENV-001` | 2.5.0 | 2026-10-01 | Private observation screenshot — not committed | Previously `UNKNOWN`. Updated 2026-10-01 after one tap. Only the opening of the modal was observed. |

## 6. Navigation log

| Nav ID | From | Action | To | Status | Date Observed | Notes |
|---|---|---|---|---|---|---|
| `NAV-LOG-001` | Device launcher (`FEAT-LCH-001`) | Removed the app from Recent Apps, then launched it from the app icon | *Unlock Icon Premium* (`FEAT-SUB-001`) | `OBSERVED NAVIGATION` | 2026-10-01 | First stable screen after launch/loading. Session state not shown at launch (see `NAV-LOG-002`). |
| `NAV-LOG-002` | *Unlock Icon Premium* (`FEAT-SUB-001`) | Tapped the top-right arrow once (`FEAT-SUB-007`) | *Log out* confirmation modal (`FEAT-AUTH-001`) | `OBSERVED NAVIGATION` | 2026-10-01 | Modal opened over the dimmed Premium screen. Neither *Cancel* nor *Log out* was tapped. Logout itself is not recorded. |
| `NAV-LOG-003` | *Log out* confirmation modal (`FEAT-AUTH-001`) | Tapped *Cancel* once | *Unlock Icon Premium* (`FEAT-SUB-001`) | `OBSERVED NAVIGATION` | 2026-10-01 | The modal closed and the previously observed Premium screen was shown again, with no other visible change reported. No additional screenshot taken because the destination matched the documented screen. |
| `NAV-LOG-004` | *Log out* confirmation modal (`FEAT-AUTH-001`), opened again via the top-right arrow on `FEAT-SUB-001` | Tapped *Log out* once, then waited for a stable screen with no further interaction | Login screen (`FEAT-AUTH-002`) | `OBSERVED NAVIGATION` | 2026-10-01 | Observed: the modal closed and the app moved from the existing-session UI to a signed-out login UI. Not verified: server-side session invalidation. This deliberately changed the app state on `ENV-001` from the original launch state. |
| `NAV-LOG-005` | Login screen (`FEAT-AUTH-002`) | Tapped *Forgot password?* once | *Forgot Password* screen (`FEAT-AUTH-003`) | `OBSERVED NAVIGATION` | 2026-10-01 | In-app screen. No email entered and no OTP requested. |
| `NAV-LOG-006` | *Forgot Password* screen (`FEAT-AUTH-003`) | Tapped the top-left back arrow once | Login screen (`FEAT-AUTH-002`) | `OBSERVED NAVIGATION` | 2026-10-01 | Direct user observation. No additional screenshot taken because the destination matched the documented login screen. No email entered, no OTP requested, no recovery validation performed. |
| `NAV-LOG-007` | Login screen (`FEAT-AUTH-002`) | Tapped *Continue with Google* once | Google account-selection interface (`FEAT-AUTH-004`) | `OBSERVED NAVIGATION` | 2026-10-01 | Crosses from Icon Training's login UI into a Google-provided interface. No account was selected and authentication was not completed. |
| `NAV-LOG-008` | Google account selection (`FEAT-AUTH-004`) | Pressed Android Back once | Login screen (`FEAT-AUTH-002`) | `OBSERVED NAVIGATION` | 2026-10-01 | Direct user observation. No additional screenshot taken because the destination matched the documented login screen. No Google account selected, no authentication completed. |

## 7. Provisional area reconciliation

The `test-cases/` folders were created from the planned scope. Each one will be confirmed, revised or marked not observed once exploration is complete.

| Provisional folder | Outcome | Related Feature IDs | Notes |
|---|---|---|---|
| `authentication/` | _Pending exploration_ (partially observed) | `FEAT-AUTH-001` – `FEAT-AUTH-004` | Observed 2026-10-01: logout confirmation, login screen, Forgot Password screen and Google account selection. Password-visibility toggle state observed (masking of entered text unverified). Not yet observed: email/password authentication, email/password/empty-field validation, invalid-credential handling, masking/unmasking of entered text, password-recovery behavior beyond the Forgot Password screen (email input and validation, *Send OTP* and anything after it), Google authentication beyond account selection, successful login behavior, and any other account-entry functionality not yet discovered. |
| `onboarding/` | _Pending exploration_ | | |
| `navigation/` | _Pending exploration_ | | |
| `workouts/` | _Pending exploration_ | | |
| `workout-tracking/` | _Pending exploration_ | | |
| `ai-coaching/` | _Pending exploration_ | | |
| `recovery/` | _Pending exploration_ | | |
| `nutrition/` | _Pending exploration_ | | |
| `permissions/` | _Pending exploration_ | | |
| `health-connect/` | _Pending exploration_ | | |
| _No folder_: Premium / subscription | **Candidate**: observed, not yet reconciled | `FEAT-SUB-001` – `FEAT-SUB-007` | Area observed on 2026-10-01 with no matching provisional folder. Decide when #8 is finalized. No `test-cases/` folder created yet. |

Outcomes will be one of: **Confirmed** (area observed), **Revised** (renamed, merged or split to match the app), **Not observed** (not found in 2.5.0 on `ENV-001`), or **Unverified** (could not be accessed, e.g. requires a subscription). Areas discovered during exploration without a provisional folder are listed as **Candidate** until #8 is finalized.
