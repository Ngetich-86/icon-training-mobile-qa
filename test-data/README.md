# Test Data

> **No test data sets have been created yet.**

## Principles

- **Synthetic only.** All data in this folder is invented for testing and does not describe a real person.
- **No credentials.** Test-account passwords, tokens and keys are never stored here. Automation will read them from environment variables or CI secrets.
- **No production data** and **no personal health information**.
- Use obviously fictitious values: reserved example domains (`example.com`, `example.org`) for emails and clearly fake names (e.g. `Test User 01`).

## Layout

| Path | Purpose |
|---|---|
| `synthetic/` | Synthetic data sets (profiles, workout inputs, boundary values, AI evaluation prompts) |

## Planned conventions

- Formats: JSON or CSV, one file per purpose (e.g. `synthetic/profiles.json`, `synthetic/boundary-values.json`).
- Each data set has a short header or accompanying note that explains its purpose and which test cases use it.
- Boundary and invalid values are documented with the reasoning behind them.
