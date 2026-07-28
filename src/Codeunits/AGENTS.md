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

## Codeunits

- Preserve the existing functional behavior, procedure flow, validations, filters, calculations, record modifications, and transaction boundaries.
- Preserve the codeunit ID, name, subtype, `TableNo`, `Permissions`, `SingleInstance`, and event-subscriber structure unless an explicit task requires a change.
- Do not change public procedure names, parameter order, parameter types, `var` modifiers, return types, or accessibility unless required by a verified Business Central v27 API change.
- Before modifying a public procedure, search the complete repository for all callers and subscribers.
- Preserve `OnRun`, `OnCheckPreconditionsPerCompany`, `OnInstallAppPerCompany`, upgrade triggers, and any other special triggers.
- Preserve existing `COMMIT`, `LOCKTABLE`, `FINDSET`, `MODIFY`, `INSERT`, `DELETE`, `VALIDATE`, `TRANSFERFIELDS`, `CHANGECOMPANY`, and `TryFunction` behavior unless the task explicitly requires a reviewed functional change.
- Never add, remove, or move a `COMMIT` without documenting the transactional impact.
- Do not replace `VALIDATE(Field, Value)` with direct assignment unless equivalent behavior is proven.
- Do not replace `INSERT(TRUE)`, `MODIFY(TRUE)`, `DELETE(TRUE)`, or `RENAME` with alternatives that bypass table triggers.
- Preserve temporary-record semantics and verify whether multiple temporary record variables require independent buffers.
- Preserve record filters, keys, sorting, marked records, security filters, and company context.
- Verify `SetRange`, `SetFilter`, `SetCurrentKey`, `FindFirst`, `FindSet`, `FindLast`, `Next`, `Get`, and `IsEmpty` changes against the surrounding loop and business logic.
- Preserve posting, document numbering, dimensions, item tracking, reservations, VAT, taxes, withholding, currency, inventory costing, and financial behavior.
- Treat posting codeunits and subscribers to posting events as high-risk.
- Do not invent standard events, integration events, business events, object IDs, methods, fields, enums, interfaces, or APIs.
- Before changing an event subscriber, verify:

  - The publisher object.
  - The exact event name.
  - The current parameter list.
  - `var` parameters.
  - `SkipOnMissingLicense`.
  - `SkipOnMissingPermission`.
  - Whether the event is obsolete or replaced.
- Preserve subscriber idempotency and ensure that repeated event execution does not duplicate records, dimensions, payments, entries, notifications, or external calls.
- Do not subscribe to a broader or earlier event merely to make the code compile.
- Do not remove an event subscriber because its publisher cannot be found without first checking Business Central v27 dependency symbols.
- Replace obsolete standard APIs only when the current replacement and its behavior are verified through `al_symbolsearch`.
- Prefer Business Central SaaS-compatible APIs and patterns.
- Do not restore or introduce:

  - DotNet.
  - Automation.
  - ADO.
  - Direct SQL access.
  - Windows-client APIs.
  - `[RunOnClient]`.
  - Server file-system paths.
  - Server-side file access.
  - OnPrem-only APIs.
- For file handling, verify supported `InStream`, `OutStream`, `Temp Blob`, `UploadIntoStream`, and `DownloadFromStream` patterns.
- For external integrations, preserve payload structure, authentication requirements, idempotency, timeout handling, error handling, and response processing.
- Do not introduce secrets, tokens, connection strings, client secrets, certificates, or real customer-sensitive information.
- Do not change integration endpoints or payload contracts unless explicitly requested.
- For `HttpClient`, verify that requests are SaaS-compatible and that the extension is expected to have outbound HTTP access enabled.
- Do not silently replace synchronous integration behavior with asynchronous behavior, or vice versa.
- For obsolete No. Series functionality, use the current `"No. Series"` APIs only after verifying whether the original code consumes, previews, or tests the next number.
- Preserve the difference between generating a number and previewing the next number.
- For dimension API changes, verify the current `Dimension Management` signatures and preserve all original dimension sources.
- For posting buffer and posting API changes, verify the exact current standard codeunit, temporary table, and procedure signature.
- For removed standard tables or codeunits, do not select a similarly named replacement without confirming semantic equivalence.
- Do not suppress compiler errors or warnings by commenting out executable business logic.
- Do not create empty procedures, placeholder return values, or unconditional success responses merely to make the project compile.
- When a TODO cannot be resolved safely, preserve the original code and replace the marker with:
  `// TODO: Manual review - <specific technical or functional reason>`
- All new comments must be written in English.
- Process no more than 10 AL codeunit objects per compilation batch.
- The 10-object limit applies per batch, not to the complete task.
- After every successful batch, continue automatically with the next batch.
- Stop only when no `//TODO: Ver` remains under `src/Codeunits`; every original marker must have been either safely resolved or explicitly converted to manual review.

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
- Stop only when no `//TODO: Ver` remains under `src/Codeunits`; every original marker must have been either safely resolved or explicitly converted to manual review.
