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

## Standard SaaS migration policy

- Standard Business Central SaaS migration patterns are authorized and expected when the original functional purpose is clear.
- Do not leave a TODO as manual review merely because the implementation must change from an obsolete OnPrem API to a current standard Business Central SaaS API.
- Compilation alone is not sufficient, but a verified standard SaaS replacement should be implemented when it preserves the original functional outcome.
- Re-evaluate existing `// TODO: Manual review` comments and implement the migration when the blocked code uses a removed or obsolete standard Business Central API with a supported SaaS equivalent.
- Treat the complete logical flow as one migration. Update declarations, setup validations, calls, error handling, streams, generated filenames, and obsolete variables together.
- Remove obsolete setup-field validations only when repository analysis confirms that the fields were used exclusively by the replaced OnPrem implementation.
- Do not preserve requirements for SMTP passwords, server paths, Windows users, or server file access when those requirements exist only because of the obsolete technical implementation.
- Preserve recipient addresses, subjects, message bodies, report filters, report request settings, filenames, output formats, and functional error handling.

### Email migration

- Legacy SMTP codeunits and direct SMTP credential flows must be migrated to the standard `"Email Message"` and `"Email"` codeunits when recipients, subject, body, and send behavior are clear.
- Use `"Email Message".Create(...)` to construct the message.
- Use `"Email".Send(...)` when the original behavior is synchronous.
- Use `"Email".Enqueue(...)` only when the original behavior is asynchronous, background-oriented, or explicitly queues the message.
- When no custom sender-account requirement is present, use the default Business Central email account instead of requiring legacy sender-address and password fields.
- A missing custom Email Scenario is not by itself a reason for manual review. The standard default email account may be used when this preserves the original behavior.
- Do not invent a custom Email Scenario.
- Preserve To, CC, BCC, subject, body, HTML format, attachments, and Boolean send-result behavior.
- Replace legacy last-error APIs with clear AL error handling based on the Boolean result returned by the standard Email API.
- Do not leave commented SMTP declarations, password validations, sender-credential calls, or obsolete SMTP error handling after a complete standard Email migration.
- Search for all usages before removing custom credential-field validations.
- Never migrate or copy SMTP passwords into AL code.

### Report and file output migration

- Legacy report output to a server or network path must be migrated to streams when the functional purpose is to provide the generated file to the user.
- Use a `"Temp Blob"` OutStream as the report destination.
- Use the verified current `Report.SaveAs` API with the required report format.
- Create an InStream from `"Temp Blob"`.
- Use `DownloadFromStream` for an interactive browser download.
- Preserve the original report instance configuration, request-page parameters, filters, `SetTableView`, initialization procedures, filename, extension, and report format.
- Do not replace a report instance call with a static report call when doing so would lose configured request variables or filters.
- When the code can run interactively and in the background:

  - Use direct download only when `GuiAllowed` is true.
  - Do not attempt browser downloads when `GuiAllowed` is false.
  - Use an existing verified background destination when one is already defined.
  - Leave manual review only when the required background destination cannot be inferred.
- When one interactive operation generates multiple files, create one ZIP using the standard `"Data Compression"` codeunit and download the ZIP once.
- Do not call `DownloadFromStream` repeatedly inside a loop and assume every browser download will be retained.
- Use `File.ViewFromStream` only when the intended behavior is PDF preview rather than direct download.
- Do not retain network paths, server paths, `SaveAsPdf` file paths, `File.Download`, or server-side file operations after a complete SaaS stream migration.

### Upload and import migration

- Legacy client or server file imports must be migrated to `UploadIntoStream` when the user is expected to select a file interactively.
- Preserve file filters, encoding, delimiters, XML or CSV structure, and cancellation behavior.
- For background imports, use an existing verified Blob, Media, API, or external-storage source.
- Leave manual review only when no background input source or integration contract exists.

### Standard object and API replacements

- A removed standard object, method, codeunit, or table must be researched using `al_symbolsearch` and current dependency symbols.
- Implement the current standard replacement when semantic equivalence can be verified from:

  - The current standard API.
  - Current standard usages.
  - The complete surrounding custom logic.
- A changed method signature is not a reason for manual review when all required parameters can be derived safely.
- A changed standard storage mechanism is not a reason for manual review when the original output or input purpose remains clear.
- A removed standard API with a documented replacement must be migrated unless doing so changes the functional outcome.

### Manual-review threshold

- Manual review is a last resort, not the default outcome.
- Leave or create `// TODO: Manual review` only when at least one of the following is true:

  - A referenced custom object does not exist.
  - A referenced custom field does not exist.
  - A referenced custom procedure does not exist or its required contract cannot be established.
  - A required custom enum or option member does not exist.
  - The original business requirement cannot be inferred from the current repository.
  - Multiple possible replacements produce materially different business outcomes.
  - An external API contract, endpoint, authentication flow, or payload is unavailable.
  - An interactive file operation is executed in the background and no destination is defined.
  - A standard replacement would require changes outside the permitted scope.
- Do not leave manual review solely because:

  - The old implementation uses SMTP.
  - The old implementation writes to a server or network path.
  - The old implementation uses a legacy Temp Blob pattern.
  - The old implementation uses an obsolete standard codeunit.
  - The standard API signature has changed.
  - Business Central requires configured Email accounts.
  - A browser download replaces a server-file output.
- Every retained manual-review comment must state the exact missing custom dependency, functional decision, external contract, or execution-context decision.

### Continuous manual-review processing

- Process no more than 10 codeunit objects per compilation batch.
- The 10-object limit applies per batch, not to the complete task.
- After every successful compilation, continue automatically with the next batch.
- Re-evaluate all existing `// TODO: Manual review` comments under `src/Codeunits`.
- Stop only when every manual-review comment has either:

  - Been resolved through a verified standard SaaS migration, or
  - Been confirmed as requiring one of the permitted manual-review reasons above.

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
