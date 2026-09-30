# AI Feature Testing Strategy

> **Status:** PLANNED. No AI evaluation has been performed. Whether and how AI features exist in the tested application version will be confirmed during product exploration (M1). Evaluation is scheduled for Milestone M7.

## 1. Purpose

Define how any AI-driven features (for example, AI coaching) will be evaluated in a structured, repeatable and fair way, even though their outputs are nondeterministic.

## 2. Key principle: nondeterminism

AI-generated outputs can vary between runs for the same input. Therefore:

- **Exact-match assertions are often not appropriate.** Evaluation uses rubrics, criteria and human judgment instead.
- The same prompt may be run **multiple times** to assess consistency.
- Results are recorded against the app version, date and environment, because model behavior may change server-side without an app update.
- Findings describe what was observed in a sample. They are not guarantees about all outputs.

## 3. Evaluation dimensions

| Dimension | Question it answers |
|---|---|
| Relevance | Does the response address the user's request and fitness context? |
| Instruction following | Does it respect explicit constraints (e.g. duration, equipment, format)? |
| Context retention | Does it correctly use information given earlier in the session or profile? |
| Consistency | Are repeated responses to equivalent inputs materially consistent? |
| Personalization | Does it adapt appropriately to the (synthetic) user profile and goals? |
| Invalid-input handling | How does it handle empty, nonsensical, contradictory or out-of-range input? |
| Unsupported claims | Does it avoid stating unverifiable facts or overconfident medical/nutritional claims? |
| Safety (where applicable) | Does it respond appropriately to inputs that suggest injury, health risk or unsafe exercise? |
| Recovery behavior | Does it recover gracefully from errors, timeouts or user corrections? |

## 4. Planned rubric (draft)

Each dimension is scored per response:

| Score | Meaning |
|---|---|
| 2 | Fully meets the criterion |
| 1 | Partially meets the criterion |
| 0 | Does not meet the criterion |
| N/A | Not applicable to this prompt |

The rubric will be finalized in M7 (issue: *Define AI evaluation rubric*).

## 5. Evaluation dataset (planned)

- A versioned set of **synthetic** prompts and profiles stored in `test-data/synthetic/`
- Categories: typical requests, constrained requests, multi-turn context, invalid input, edge cases and safety-relevant input
- No real personal or health data

## 6. Evaluation record format (planned)

| Field | Description |
|---|---|
| Eval ID | Unique ID |
| App version / date / environment | Recorded context |
| Input / prompt | Synthetic input used |
| Run # | Repetition number |
| Observed output (summary or sanitized excerpt) | What was actually returned |
| Dimension scores | Per rubric |
| Notes | Observations and follow-up |

## 7. Limitations

- Small samples cannot establish statistical guarantees.
- Server-side model changes may invalidate earlier observations.
- Human scoring has subjectivity. The rubric and examples aim to reduce it.
- This evaluation is not a medical, nutritional or safety certification.
