# Exploratory Testing

> **No exploratory sessions have been conducted yet.** Charters will be defined in Milestone M4, informed by the feature inventory and risk assessment.

## What is exploratory testing?

Exploratory testing means learning about the application, designing tests and executing them at the same time. The tester uses what each test reveals to decide on the next one. It is especially good at finding unexpected behavior that scripted test cases miss.

## Session-based testing

Exploratory work here follows **session-based test management (SBTM)**:

- Each session has a **charter**: a mission that states what to explore and why.
- Each session is **time-boxed**.
- Each session ends with a **session report** that records what was covered, observed and found.

## Session duration

| Session type | Duration |
|---|---|
| Short | 30 minutes |
| Normal | 60 minutes |
| Long | 90 minutes |

Record the actual time spent split into **test design & execution**, **bug investigation & reporting**, and **setup**.

## Folder layout

| Path | Purpose |
|---|---|
| `charters/` | Charter definitions (`CH-XXX-short-title.md`) |
| `session-reports/` | Completed session reports (`SR-XXX-YYYY-MM-DD-short-title.md`) |

## Charter structure

A charter uses this format:

> **Explore** _<target area>_
> **with** _<resources, tools, data, conditions>_
> **to discover** _<information sought / risks>_

## Charter template

Copy [charters/charter-template.md](charters/charter-template.md).

## Session report contents

Each session report records:

- **Charter**: the charter ID and mission
- **Session details**: date, duration, tester, app version, environment ID
- **Areas investigated**: what was actually covered
- **Observations**: notable behavior seen, stated factually
- **Questions**: open questions about intended behavior
- **Defects discovered**: links to bug reports (only real, observed defects)
- **Issues / blockers**: anything that impeded testing
- **Follow-up testing**: new charters or test cases suggested by the session
- **Evidence**: links to sanitized evidence

## Rules

- Record only what was actually observed during the session.
- Sanitize all evidence before committing.
- Do not use exploratory testing as a reason to probe private APIs or reverse engineer the app.
