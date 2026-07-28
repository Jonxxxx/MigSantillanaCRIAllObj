# Codeunit Migration TODO Progress

## Baseline

- Date: 2026-07-28.
- AL codeunits: 138.
- TODO-bearing codeunits: 54.
- Initial `//TODO: Ver`: 356.
- Initial `// TODO: Manual review`: 0.
- Baseline `al_compile`: succeeded with 0 errors and 10,118 warnings.

## Batch 1

- Codeunits inspected and modified: 130410, 34002102, 34002104,
  34002108, 34002111, 34002112, 34002114, 34002115, 34002118, and
  34002119.
- TODOs safely resolved: 12 markers. Replaced six legacy two-line
  `InitSeries` calls with the verified consuming
  `No. Series.GetNextNo(NoSeriesCode, UsageDate)` API.
- TODOs converted to manual review: 20 markers represented by 11
  deduplicated comments.
- Existing manual-review comments resolved: 0.
- Original classification/confidence: event subscriber, web-client
  interaction, DotNet, email/file handling, No. Series, removed option/field,
  and payroll ambiguity across all confidence levels.
- Final classification: verified consuming No. Series migration, or
  unavailable company-open publisher, unsupported Dialog.INPUT, undefined
  public DateDiff interval contract, legacy SMTP/server-file flow, and
  unavailable payroll option/field semantics.
- Verification performed: complete current-codeunit loading and
  procedure-level inspection; repository search for every caller of
  `CalculoEntreFechaDotNet`; repository search for legacy `InitSeries`
  patterns; `al_symbolsearch` for all Business Central v27 No. Series methods,
  OnAfterCompanyOpen, Email, and Email Message.
- Public callers reviewed: `CalculoEntreFechaDotNet` callers in Codeunits
  34002118, 34002119, and 34002160; No. Series changes were local procedure
  statements and did not change public contracts.
- Event publishers reviewed: Codeunit 40 OnAfterCompanyOpen was not present in
  dependency symbols.
- Transaction risks reviewed: each restored `GetNextNo` consumes a number at
  the same point as legacy `InitSeries`; no COMMIT, lock, insert, modify,
  delete, validation, or posting boundary was changed.
- Compilation: `al_compile` succeeded with 0 errors.
- Errors introduced and corrected: 0.
- Remaining `//TODO: Ver`: 324.
- Total `// TODO: Manual review`: 11.
- Last successfully processed file:
  `src/Codeunits/Codeunit 34002119 - Registrar nomina RD -2.al`.

## Batch 2

- Codeunits inspected and modified: 34002124, 34002125, 34002126,
  34002135, 34002145, 34002160, 34002199, 34002500, 34002520, and
  34002521.
- TODOs safely resolved: 2 markers. Replaced the legacy payroll
  `InitSeries` call in Codeunit 34002160 with the verified consuming
  `No. Series.GetNextNo` API.
- TODOs converted to manual review: 197 markers represented by 133
  deduplicated procedure/block comments.
- Existing manual-review comments resolved: 0.
- Original classification/confidence: ADO/direct SQL, server-file payroll
  exports, legal-format Automation, SMTP, No. Series, removed virtual tables,
  client control add-in, Windows identity, and POS integration across all
  confidence levels.
- Final classification: verified No. Series migration, or workflows requiring
  SaaS stream/payment redesign, Email account/scenario decisions, unavailable
  metadata/deposit objects, disabled client add-in methods, unavailable
  Windows identity, and an undefined external POS cancellation contract.
- Verification performed: complete current-codeunit loading; procedure-level
  inspection of all 12 payroll/export procedures and four legal-format
  procedures; repository searches for Codeunits 34002500 and 34002521 and
  their callers; prior `al_symbolsearch` verification of No. Series and Email
  APIs.
- Public callers reviewed: repository callers of Codeunits 34002500 and
  34002521 were reviewed; no public procedure signature was changed.
- Event publishers reviewed: no event-subscriber marker occurred in this
  batch.
- Transaction risks reviewed: no payment, journal, metadata deletion, file
  generation, POS call, COMMIT, validation, record modification, or
  integration behavior was activated; the No. Series call remains at the
  original number-consumption point.
- Compilation: `al_compile` succeeded with 0 errors.
- Errors introduced and corrected: 0.
- Remaining `//TODO: Ver`: 125.
- Total `// TODO: Manual review`: 144.
- Last successfully processed file:
  `src/Codeunits/Codeunit 34002521 - Control TPV.al`.

## Batch 3

- Codeunits inspected and modified: 34002522, 34002523, 34002524,
  34002525, 50010, 50112, 50113, 50300, 52502, and 52504.
- TODOs safely resolved: 2. Migrated two calls from removed
  `CreateCreditMemoCopyDocument2` to the verified v27
  `CreateCreditMemoCopyDocument` method with matching `var` record types.
- TODOs converted to manual review: 36 markers represented by 22
  deduplicated comments.
- Existing manual-review comments resolved: 0.
- Original classification/confidence: Windows identity, dimensions,
  corrective posting, custom declaration, electronic invoicing, SMTP,
  virtual tables, and data-correction utilities across all confidence levels.
- Final classification: verified corrective-credit-memo method, or disabled
  Windows/POS country helpers, unverified multi-source dimension semantics,
  unavailable reverse credit-memo-to-invoice API, empty electronic-invoicing
  dependency, undefined Email scenario, and removed virtual/deposit objects.
- Verification performed: complete current-codeunit and procedure inspection;
  repository searches for CduPOS, cfComunes, cuFE, corrective-posting callers,
  and Codeunit 52504; `al_symbolsearch` for every Correct Posted Sales Invoice
  method, CreateSalesInvoice methods, and Dimension Management.
- Public callers reviewed: no public signature changed; the restored standard
  calls use the existing local variables and exact record types.
- Event publishers reviewed: no event-subscriber marker occurred in this
  batch.
- Transaction risks reviewed: corrective-document creation remains at the
  original call sites; no surrounding MODIFY(TRUE), posting, dimension,
  COMMIT, or filter behavior changed. All unverifiable posting/integration
  logic remained disabled.
- Compilation: initial `al_compile` found AL0132 because `Pais` exists only in
  disabled source. That single restoration was converted to manual review;
  repeat `al_compile` succeeded with 0 errors.
- Errors introduced and corrected: 1.
- Remaining `//TODO: Ver`: 87.
- Total `// TODO: Manual review`: 166.
- Last successfully processed file:
  `src/Codeunits/Codeunit 52504 - Facturacion  Electronica NAV.al`.

## Batch 4

- Codeunits inspected and modified: 52506, 55002, 56000, 56003, 56008,
  56050, 56051, 56200, 56201, and 56202.
- TODOs safely resolved: 2. Restored the verified custom
  `EXCCRIReleaseSalesDocSub.SetIgnorarControles` state setter before running
  Codeunit 414, and restored the verified XMLport 56201 `SetInfo` call.
- TODOs converted to manual review: 20 markers represented by 17
  deduplicated comments.
- Existing manual-review comments resolved: 0.
- Original classification/confidence: server-file reporting, bank export,
  email, missing custom reports and implementations, reservation APIs,
  custom XMLport calls, DotNet HTTP/XML, and functional ambiguity across all
  confidence levels.
- Final classification: verified custom release-state and XMLport calls, or
  unsupported server-file workflows, removed payment/email fields, unavailable
  Report 51003, absent implementations, an unverified reservation direction,
  inaccessible XMLport procedures, and DotNet HTTP/XML redesign.
- Verification performed: complete codeunit/procedure inspection; repository
  searches for Report 51003, XMLports 56200/56201 and their procedures, and
  `EXCCRIReleaseSalesDocSub`; `al_symbolsearch` for `FilterReservFor`,
  Reservation Management, and all Sales Line-Reserve methods.
- Public callers reviewed: no public procedure signature was changed; custom
  procedure calls use their existing verified parameters.
- Event publishers reviewed: the release subscriber's existing
  OnBeforeReleaseSalesDoc subscriber was inspected; no subscriber declaration
  was changed.
- Transaction risks reviewed: no COMMIT, report output, bank-file write,
  reservation close, HTTP request, XML mutation, or email send behavior was
  newly activated. The SingleInstance release flag is set immediately before
  the existing release run.
- Compilation: the first `al_compile` found seven introduced AL0132/AL0118
  errors from missing email configuration fields and inaccessible XMLport
  procedures. Only those restorations were reverted to manual review; repeat
  `al_compile` succeeded with 0 errors.
- Errors introduced and corrected: 7.
- Remaining `//TODO: Ver`: 65.
- Total `// TODO: Manual review`: 183.
- Last successfully processed file:
  `src/Codeunits/Codeunit 56202 - MdE Management.al`.

## Batch 5

- Codeunits inspected and modified: 56206, 56300, 67001, 67002, 75000,
  75001, 75002, 75005, 75006, and 75007.
- TODOs safely resolved: 19. Restored two ranking calculations using the
  verified current custom field names, migrated two Item Cross Reference
  read blocks to Item Reference, and migrated the complete barcode
  create/update block to the verified Item Reference fields and enum.
- TODOs converted to manual review: 25 markers represented by 14
  deduplicated comments.
- Existing manual-review comments resolved: 0.
- Original classification/confidence: DotNet encoding, Record Link overflow,
  SMTP, Word Automation, custom calculation fields, Item Cross Reference,
  virtual metadata, client/server file handling, and missing asynchronous
  integration across all confidence levels.
- Final classification: verified custom-field spelling and standard Item
  Reference migration, or unavailable URL2/metadata tables, byte-format
  ambiguity, undefined Email and asynchronous integration contracts, and
  unsupported Windows/server-file workflows.
- Verification performed: complete codeunit/procedure inspection; repository
  searches for Table 67094 fields, Codeunit 75006 methods, and all affected
  custom objects; `al_symbolsearch` for Item Reference, all Item Reference
  fields, Item Reference Type, and its Bar Code value.
- Public callers reviewed: no public procedure signature changed; GetBarCode
  retains its Code[20] contract by explicitly copying at most 20 characters.
- Event publishers reviewed: no event-subscriber marker occurred in this
  batch.
- Transaction risks reviewed: the Item Reference delete/insert sequence,
  filters, trigger invocation, and original ordering were preserved exactly
  while renaming only the standard table and fields. No COMMIT or file,
  email, integration, or metadata behavior was activated.
- Compilation: `al_compile` succeeded with 0 errors.
- Errors introduced and corrected: 0.
- Remaining `//TODO: Ver`: 21.
- Total `// TODO: Manual review`: 197.
- Last successfully processed file:
  `src/Codeunits/Codeunit 75007 - MdM Gen. Prod..al`.

## Batch 6

- Codeunits inspected and modified: 75009, EXCCRIGenJnlPostLineSub,
  EXCCRISalesPostYesNoSub, and EXCCRITableMigrationHandler.
- TODOs safely resolved: 4. Migrated the barcode-description bulk update
  from Item Cross Reference to the verified Item Reference table, Reference
  Type field, and Bar Code enum value.
- TODOs converted to manual review: 17 markers represented by 9
  deduplicated comments.
- Existing manual-review comments resolved: 0.
- Original classification/confidence: Item Cross Reference, Windows Excel
  import, insolvency journal posting, sales-post electronic invoicing, and
  job-queue notification across all confidence levels.
- Final classification: verified Item Reference migration, or unsupported
  Windows upload flow, unvalidated high-risk financial posting with a
  disabled journal source, empty electronic-invoicing codeunits, and a
  notification codeunit whose email implementation remains disabled.
- Verification performed: complete codeunit and procedure inspection;
  repository searches for the insolvency enum extension, all usages of both
  insolvency values, Codeunits 56003, 52504, and 50300; `al_symbolsearch` for
  OnBeforePostGenJnlLine, OnAfterPostGenJnlLine, OnAfterPostSalesDoc, and
  OnBeforeConfirmSalesPost, plus the Item Reference symbols verified in
  Batch 5.
- Public callers reviewed: no public procedure signature changed.
- Event publishers reviewed: the current v27 signatures exactly match the
  existing Gen. Jnl.-Post Line and Sales-Post subscriber declarations. The
  marked financial and integration logic was still left disabled because its
  end-to-end behavior or dependency implementation is unavailable.
- Transaction risks reviewed: no insolvency posting, customer-ledger update,
  electronic-invoice request, job-queue email, upload, COMMIT, lock, or
  integration behavior was activated. The Item Reference MODIFYALL retains
  the original Bar Code filter and requested field update.
- Compilation: `al_compile` succeeded with 0 errors.
- Errors introduced and corrected: 0.
- Remaining `//TODO: Ver`: 0.
- Total `// TODO: Manual review`: 206.
- Last successfully processed file:
  `src/Codeunits/EXCCRITableMigrationHandler.Codeunit.al`.

## Completion

- Batches completed: 6.
- Codeunits inspected: 54.
- AL codeunits modified: 54.
- TODO markers safely resolved: 41.
- TODO markers converted to manual review: 315.
- Existing manual-review comments resolved in the dependency second pass: 0.
- Second-pass verification: rechecked manual-review entries potentially
  affected by restored No. Series, Item Reference, ranking, release, and
  XMLport logic. The only matching XMLport entry remains unavailable in the
  compiled XMLport contract.
- Fresh final `//TODO: Ver` search: 0 occurrences in `.al` files under
  `src/Codeunits`.
- Final `// TODO: Manual review` count: 206.
- Final `al_compile`: succeeded with 0 errors and 10,118 warnings.
- New warnings introduced by the current changes: 0; final and baseline
  warning counts are both 10,118.
- Exact stop condition: no `//TODO: Ver` occurrences remain under
  `src/Codeunits`.
