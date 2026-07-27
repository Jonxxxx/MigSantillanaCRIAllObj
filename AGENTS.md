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

## Batch size

- Modify no more than 8 objects in one task.
- Keep each batch reviewable.
- Stop when a structural or functional ambiguity is detected.