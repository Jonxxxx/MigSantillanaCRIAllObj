# Jonxsoft Business Central Development Rules

## Project context

- This repository contains a migration from Dynamics NAV / Business Central 14 C/AL to Business Central SaaS v27 AL.
- Preserve existing business logic unless the task explicitly requests a functional change.
- Prefer minimal and safe modifications.
- Avoid unnecessary refactoring.
- All code must be compatible with Business Central SaaS.
- Do not use DotNet, Automation, File system paths, direct SQL access, or OnPrem-only APIs.
- Do not invent Microsoft object IDs, object names, fields, methods, events, or APIs.

## Naming

- Use the existing object names and IDs unless explicitly requested otherwise.
- New custom objects, variables, procedures, and fields must follow the project naming convention.
- Use the JX prefix for genuinely new custom objects unless the surrounding project uses a more specific approved prefix.
- Do not use spaces in new AL identifiers.
- All code comments must be written in English.

## Business logic

- Preserve validations, filters, posting behavior, dimensions, permissions, and transaction boundaries.
- Do not remove COMMIT statements unless explicitly instructed.
- Do not replace custom fields or objects with standard objects without confirming semantic equivalence.
- Do not alter document posting, numbering, inventory, tax, or financial behavior without highlighting the risk.

## TODO review workflow

When processing comments matching `//TODO: Ver`:

1. Inspect the complete object and surrounding logic.
2. Determine whether the TODO is:
   - A deterministic AL syntax issue.
   - An obsolete Business Central API.
   - A renamed standard object, field, enum, or method.
   - An OnPrem-only dependency.
   - A functional ambiguity requiring manual review.
3. Use AL symbol search before assuming that a standard object or method was removed.
4. Modify only deterministic cases.
5. Do not remove a TODO unless the issue was resolved and the project compiles.
6. For unresolved cases, replace it with:
   `// TODO: Manual review - <specific reason>`
7. Do not create placeholder logic merely to make the project compile.
8. Do not suppress compiler warnings without explaining why.

## TODO processing

- `TODO-Pages-Audit.md` is an initial inventory, not an authoritative final
  classification.
- Re-evaluate every TODO against the current source and dependency symbols.
- A TODO initially classified as Custom dependency or Missing page property may
  be resolved automatically when all referenced symbols and fields are
  verified.
- Skip ambiguous TODOs and continue processing later candidates.
- A single ambiguous TODO must never stop the complete batch.
- Treat adjacent TODO comments that form one AL statement or block as one
  logical correction.
- Deduplicate audit entries that refer to the same file, line, and TODO marker.
Count the actual current source occurrences, not duplicated audit entries.

## Pages

- Preserve page type, source table, layout structure, actions, visibility, editability, and business logic.
- Add `ApplicationArea = All;` to fields and actions when missing and appropriate.
- Add an English `ToolTip` only when its purpose can be inferred safely.
- Do not invent captions, permissions, RunObject targets, RunPageLink filters, or SubPageLink values.
- Do not convert a page to a page extension unless explicitly requested.
- Do not change UsageCategory without reviewing how the page is opened.

## Validation

After every batch:

1. Compile the modified AL project.
2. Review all new errors and warnings caused by the changes.
3. Fix only issues introduced by the batch.
4. Do not modify unrelated objects.
5. Report:
   - Files changed.
   - TODOs resolved.
   - TODOs requiring manual review.
   - Compilation errors remaining.
   - Assumptions made.

## Continuous TODO batch processing

For page TODO migration tasks, this section overrides any object-per-task limit
defined in the repository root `AGENTS.md`.

- Process a maximum of 10 AL objects per compilation batch, with no total object limit for the complete task.
- After every successful compilation batch, continue automatically with the next batch without waiting for user confirmation.
- Process all remaining `//TODO: Ver` comments regardless of their original High, Medium, or Low confidence classification.
- Re-evaluate every TODO against the current repository, dependency symbols, object definitions, procedure signatures, and compiler results.
- Safely resolvable TODOs must be corrected and removed.
- TODOs that cannot be resolved without inventing business logic or unsupported semantics must be converted to `// TODO: Manual review - <specific reason>`.
- One unresolved, ambiguous, missing, obsolete, or SaaS-incompatible candidate must never stop the complete task.
- Stop only when no `//TODO: Ver` remains under `src/Pages`; every original marker must have been either safely resolved or explicitly converted to manual review.
