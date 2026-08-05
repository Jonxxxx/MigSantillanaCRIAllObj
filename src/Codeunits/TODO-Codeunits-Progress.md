# Codeunit Migration TODO Progress

## Baseline

- Date: 2026-07-28.
- AL codeunits: 138.
- TODO-bearing codeunits: 54.
- Initial `//TODO: Ver`: 356.
- Initial `// TODO: Manual review`: 0.
- Baseline `al_compile`: succeeded with 0 errors and 10,118 warnings.

## Batch 1

- Codeunits inspected and modified: 55739, 34002102, 34002104,
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
  34002525, 55010, 55111, 55112, 55156, 55201, and 55202.
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
  and Codeunit 55202; `al_symbolsearch` for every Correct Posted Sales Invoice
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
  `src/Codeunits/Codeunit 55202 - Facturacion  Electronica NAV.al`.

## Batch 4

- Codeunits inspected and modified: 55204, 55002, 55225, 55228, 55233,
  55271, 55272, 55353, 55354, and 55355.
- TODOs safely resolved: 2. Restored the verified custom
  `EXCCRIReleaseSalesDocSub.SetIgnorarControles` state setter before running
  Codeunit 414, and restored the verified XMLport 55354 `SetInfo` call.
- TODOs converted to manual review: 20 markers represented by 17
  deduplicated comments.
- Existing manual-review comments resolved: 0.
- Original classification/confidence: server-file reporting, bank export,
  email, missing custom reports and implementations, reservation APIs,
  custom XMLport calls, DotNet HTTP/XML, and functional ambiguity across all
  confidence levels.
- Final classification: verified custom release-state and XMLport calls, or
  unsupported server-file workflows, removed payment/email fields, unavailable
  Report 55164, absent implementations, an unverified reservation direction,
  inaccessible XMLport procedures, and DotNet HTTP/XML redesign.
- Verification performed: complete codeunit/procedure inspection; repository
  searches for Report 55164, XMLports 55353/55354 and their procedures, and
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
  `src/Codeunits/Codeunit 55355 - MdE Management.al`.

## Batch 5

- Codeunits inspected and modified: 55359, 55422, 55468, 55469, 55681,
  55682, 55683, 55686, 55687, and 55688.
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
  searches for Table 55553 fields, Codeunit 55687 methods, and all affected
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
  `src/Codeunits/Codeunit 55688 - MdM Gen. Prod..al`.

## Batch 6

- Codeunits inspected and modified: 55690, EXCCRIGenJnlPostLineSub,
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
  insolvency values, Codeunits 55228, 55202, and 55156; `al_symbolsearch` for
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

# Manual-review re-evaluation

## Re-evaluation baseline

- Date: 2026-07-28.
- Current `// TODO: Manual review` comments: 206 across 45 codeunits.
- Candidate source of truth: current AL source and dependency symbols.
- Initial mutually exclusive heuristic grouping:

| Migration pattern | Comments |
|---|---:|
| Email and SMTP | 10 |
| Report output | 4 |
| File upload | 4 |
| File download | 31 |
| Server and network paths | 97 |
| Temp Blob | 1 |
| Compression | 0 |
| XML and JSON | 4 |
| DotNet with standard AL replacement | 2 |
| Automation with standard AL replacement | 1 |
| Standard obsolete APIs | 16 |
| Standard changed signatures | 3 |
| No. Series | 0 |
| Dimensions | 3 |
| Event subscribers | 1 |
| Missing custom objects | 5 |
| Missing custom fields | 4 |
| Missing custom procedures | 6 |
| Missing custom enum or option members | 3 |
| External integration contracts | 3 |
| Genuine functional ambiguity | 8 |
| **Total** | **206** |

- The grouping is prioritization guidance only; every logical block will be
  reclassified after complete procedure and dependency inspection.

## Manual-review batch 1

- Codeunits inspected and modified: 34002108, 34002145, 55156, 55204,
  55233, 55355, 55359, 55422, 55683, and 55690.
- Manual reviews resolved: 19.
- Email migrations: 4 complete synchronous Email/Email Message flows,
  including the payroll PDF stream attachment.
- Report-output migrations: 1 payroll report generated to Temp Blob and
  attached without server storage.
- File-upload migrations: 1 Excel upload migrated to UploadIntoStream and
  Excel Buffer.OpenBookStream.
- File-download migrations: 0.
- Temp Blob migrations: 1.
- Standard API migrations: HttpClient SOAP posting, Record Link
  Management.WriteNote, Type Helper.HtmlEncode, and current Record Link URL1.
- Event subscriber migrations: 0.
- Manual reviews retained for missing custom objects/fields/procedures: 0.
- Manual reviews retained for external contracts: 0.
- Manual reviews retained for genuine functional ambiguity: 3. Two timed
  background cost-report processes have no SaaS delivery/storage destination;
  the MdM importer requires disabled Page 55697 actions outside this scope and
  migration of its disabled custom multi-sheet body.
- Compilation: first `al_compile` found one introduced
  HttpClient.DefaultRequestHeaders overload error; the verified zero-argument
  accessor was applied and repeat compilation succeeded with 0 errors.
- Remaining manual-review comments: 187.
- Last processed file: `src/Codeunits/Codeunit 55690 - MdM Macros.al`.

## Manual-review batch 2

- Codeunits inspected and modified: 34002125, 34002126, and 34002135.
- Manual-review comments resolved or deduplicated: 98.
- Email migrations: 0.
- Report-output migrations: 0.
- File-upload migrations: 0.
- File-download migrations: 5 interactive text-export flows. The active
  Dominican Republic and Costa Rica payroll-bank exports and the three legal
  export procedures now write Windows-encoded text to `Temp Blob` streams and
  download the original logical filename through `DownloadFromStream`.
- Temp Blob migrations: 3 codeunits.
- Standard API migrations: server temporary paths, `File.CREATE`,
  `File.WRITE`, `File.CLOSE`, Automation, Windows-client branching, and
  `File Management.DownloadToFile` were removed from the active export flows.
- Event subscriber migrations: 0.
- Manual reviews retained for missing custom fields: bank-provider procedures
  require unavailable E-Pay metadata fields, `Vendor Bank Account."Banco RED
  ACH"`, `Gen. Journal Line."Export File Name"`, and legacy Employee position
  or nationality fields.
- Manual reviews retained for missing custom procedures/objects: legacy
  payment codeunits 10090 and 10091 are unavailable.
- Manual reviews retained for external contracts: 0.
- Manual reviews retained for genuine functional ambiguity: disabled
  salary-change, variable-salary, journal-bank, and vendor-email bodies have
  no current activation contract; their exact dependency reasons remain in
  source.
- Compilation: `al_compile` succeeded with 0 errors on the first batch
  validation.
- Remaining manual-review comments: 89.
- Last processed file:
  `src/Codeunits/Codeunit 34002135 - Genera formatos elect. legales.al`.

## Manual-review batch 3

- Codeunits inspected: 55201, 55002, 34002199,
  EXCCRISalesPostYesNoSub, 34002522, EXCCRIGenJnlPostLineSub, 34002118,
  55225, 55682, and 55353.
- Codeunits modified: 55201, 34002522, 55682, and 55353.
- Manual reviews resolved: 6.
- Email migrations: 0.
- Report-output migrations: 0.
- File-upload migrations: 0.
- File-download migrations: the MdM initial-product XML export now writes
  directly to a UTF-8 `Temp Blob` and downloads through
  `DownloadFromStream`.
- Temp Blob migrations: 1.
- Standard API migrations: `AllObjWithCaption` replaces the numeric virtual
  object reference; `Copy Document Mgt.CopySalesDocForCrMemoCancelling`
  replaces the removed credit-memo correction copy call; current list-based
  `CreateDim` APIs and `DimensionManagement.AddDimSource` replace the legacy
  POS header and line dimension signatures.
- Event subscriber migrations: 0.
- Manual reviews retained for missing custom objects/procedures: electronic
  invoicing codeunits are empty, payment codeunits and report 55164 are
  absent, MdE XMLport methods are absent, and the compiled POS helper
  codeunits do not expose `TraerUsuarioWindows` or `Pais`.
- Manual reviews retained for missing custom fields/options: legacy deposit
  table 10144, payroll option 6, `Tipo pago OLD`, and country-specific bank
  metadata remain unavailable.
- Manual reviews retained for external contracts: the disabled bank
  transmission contract in codeunit 55002 remains unavailable.
- Manual reviews retained for genuine functional ambiguity: insolvency
  posting remains tied to a disabled report outside `src/Codeunits`.
- Compilation: the first validation found four introduced errors. The two
  apparently present POS helper procedures were confirmed unavailable in the
  compiled object and restored as specific reviews; the removed Customer
  Template dimension source was omitted from the current standard source
  list. Repeat `al_compile` succeeded with 0 errors.
- Remaining manual-review comments: 83.
- Last processed file: `src/Codeunits/Codeunit 55353 - Web Service MdE.al`.

## Manual-review batch 4

- Codeunits inspected: 55688, 55112, 55111,
  EXCCRITableMigrationHandler, 55272, 55683, 55687, 55686, 55354, and
  55468.
- Codeunits modified: 55688, 55111, EXCCRITableMigrationHandler, and 55272.
- Manual reviews resolved: 5.
- Email migrations: the Job Queue `OnAfterFinalizeRun` subscriber was restored
  to run codeunit 55156, whose Email/Email Message implementation was
  completed in batch 1.
- Report-output migrations: 0.
- File-upload migrations: 0.
- File-download migrations: the duplicate MdM product XML exporter now uses a
  UTF-8 `Temp Blob` and `DownloadFromStream`.
- Temp Blob migrations: 1.
- Standard API migrations: `AllObjWithCaption` replaces the numeric virtual
  object reference; `Sales Line.SetReservationFilters` replaces the removed
  `Sales Line-Reserve.FilterReservFor` call.
- Event subscriber migrations: 1.
- Manual reviews retained for missing custom objects/procedures: electronic
  invoicing codeunit 55202, MdM sender codeunit 55687, and complementary MdE
  codeunit 55354 do not implement the required contracts.
- Manual reviews retained for missing custom fields: 0.
- Manual reviews retained for external contracts: the asynchronous MdM
  endpoint/payload/authentication/retry contract is absent.
- Manual reviews retained for genuine functional ambiguity: the disabled
  multi-sheet import requires Page 55697 changes outside this scope; the
  legacy Word Automation merge has no current document-generation contract.
- Compilation: `al_compile` succeeded with 0 errors on the first validation.
- Remaining manual-review comments: 78.
- Last processed file:
  `src/Codeunits/Codeunit 55468 - Generacion Words APS.al`.

## Manual-review batch 5

- Codeunits inspected: 55739, 34002102, 34002104, 34002124, 34002500,
  34002520, 34002521, 34002523, 34002524, and 34002525.
- Codeunits modified: 55739, 34002102, 34002104, 34002520, 34002523,
  34002524, and 34002525.
- Manual reviews resolved: 8.
- Email migrations: 0.
- Report/file migrations: 0.
- Temp Blob migrations: 0.
- Standard API migrations: the payroll cancellation choices now use
  browser-compatible `Confirm`; the visible `DateDiff` contracts (`YYYY` and
  `d`) now use AL date operations; POS user filters now use `UserId`; and the
  warmup subscriber uses `Company Triggers.OnCompanyOpenCompleted` plus
  `Environment Information.IsSaaS`.
- Event subscriber migrations: 1.
- Manual reviews retained for missing custom procedures: the DsPOS add-in
  initialization and invoice-cancellation implementations are absent from
  their compiled codeunits.
- Manual reviews retained for external contracts: the proprietary POS
  cancellation transaction contract and direct-SQL/ADO replacement contract
  are unavailable.
- Manual reviews retained for genuine functional ambiguity: 0.
- Compilation: the first validation found the removed
  `Permission Manager.SoftwareAsAService` method. Symbol search verified
  `Environment Information.IsSaaS`; repeat `al_compile` succeeded with 0
  errors.
- Remaining manual-review comments: 70.
- Last processed file:
  `src/Codeunits/Codeunit 34002525 - Notas Credito Pdtes POS.al`.

## Manual-review batch 6

- Codeunits inspected: 55010, 55202, 55228, plus dependency-reopened or
  retained-review entries in 34002522, 55002, 34002126, 34002199, and 55201.
- Codeunits modified: 55010, 34002522, 55002, 34002126, 34002199, and 55201.
- Manual reviews resolved or deduplicated: 9.
- Email migrations: 0.
- Report/file migrations: 0.
- Temp Blob migrations: 0.
- Standard API migrations:
  `Copy Document Mgt.CopySalesDocForCrMemoCancelling` replaces the removed
  posted-credit-memo correction call; the POS TPV filter now uses `UserId`.
- Event subscriber migrations: 0.
- Manual reviews retained for missing custom objects/procedures: codeunits
  55202 and 55228 are empty and provide no electronic-invoicing procedures;
  codeunit 34002503 does not expose `Pais`; table 10144 and virtual table
  2000000071 are unavailable.
- Manual reviews retained for external contracts: both empty electronic
  invoicing codeunits require an endpoint, payload, authentication, response,
  and error contract.
- Manual reviews retained for genuine functional ambiguity: 0.
- Compilation: both the batch validation and the retained-review cleanup
  validation succeeded with 0 errors.
- Remaining manual-review comments: 61.
- Last processed file:
  `src/Codeunits/Codeunit 55228 - Factura Electronica.al`.

# Retained manual-review inventory after re-evaluation

Every remaining source comment was re-evaluated against the current repository, dependency symbols, and compilation result. The exact retained inventory is:

| Permitted exclusion category | Count |
|---|---:|
| Missing custom object / field / procedure | 38 |
| External contract / SaaS redesign | 8 |
| Undefined background destination | 2 |
| Functional ambiguity / outside scope | 11 |
| Genuine functional ambiguity | 2 |
| **Total** | **61** |

| Source | Category | Exact retained reason |
|---|---|---|
| `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:250` | Missing custom object / field / procedure | Payroll type option value 6 is not defined in the current source field, so the automatic-vacation branch cannot be restored without selecting or adding a business option. |
| `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:540` | Missing custom object / field / procedure | Employee field Tipo pago OLD is unavailable, so the conditional salary-profile validation cannot be restored without a verified replacement field. |
| `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:3037` | Missing custom object / field / procedure | Employee field Tipo pago OLD is unavailable, so the retroactive-pay divisor rule cannot be restored without a verified replacement field and payroll decision. |
| `src\Codeunits\Codeunit 34002124 - ADO Connection Mgmt.al:3` | External contract / SaaS redesign | The complete ADO/direct-SQL implementation is unsupported in Business Central Online and no repository API replacement exists. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:594` | Functional ambiguity / outside scope | This entire salary-change export remains disabled and still depends on legacy server-path setup and obsolete employee-field assumptions. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:688` | Functional ambiguity / outside scope | This entire variable-salary export remains disabled and its source-field and activation requirements are not defined. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:865` | Functional ambiguity / outside scope | This entire journal-bank export remains disabled and requires an activation decision before its file flow can be migrated. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:883` | Missing custom object / field / procedure | Standard codeunits 10090 and 10091 referenced by the disabled payment-export implementations are unavailable in Business Central v27. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:919` | Missing custom object / field / procedure | Bank Account field "E-Pay Export File Path" is unavailable; the provider-export procedures also require missing payment metadata fields. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:963` | Missing custom object / field / procedure | Check Ledger Entry fields "Trace No." and "Transmission File Name" and Gen. Journal Line field "Export File Name" are unavailable. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:975` | Functional ambiguity / outside scope | This entire vendor-payment email body remains disabled and depends on removed custom setup and payment fields; activating it requires a business decision. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:1167` | Functional ambiguity / outside scope | RenameFile has no remaining active caller that is free of missing payment-export dependencies. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:1195` | Missing custom object / field / procedure | Banco Popular export requires missing Bank Account fields "E-Pay Export File Path", "Last Remittance Advice No.", and "Last E-Pay Export File Name", Vendor Bank Account field "Banco RED ACH", and Gen. Journal Line field "Export File Name". |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:1547` | Missing custom object / field / procedure | Banco BHD export requires missing Bank Account fields "E-Pay Export File Path", "Last Remittance Advice No.", and "Last E-Pay Export File Name", Vendor Bank Account field "Banco RED ACH", and Gen. Journal Line field "Export File Name". |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:1756` | Missing custom object / field / procedure | Banco Reservas export requires missing Bank Account field "E-Pay Export File Path" and Vendor Bank Account field "Banco RED ACH"; the destination routing cannot be produced without them. |
| `src\Codeunits\Codeunit 34002125 - Genera Formatos  E. Nomina RD.al:1941` | Missing custom object / field / procedure | Scotiabank export requires missing Bank Account fields "E-Pay Export File Path", "Last Remittance Advice No.", and "Last E-Pay Export File Name", Vendor Bank Account field "Banco RED ACH", and Gen. Journal Line field "Export File Name". |
| `src\Codeunits\Codeunit 34002135 - Genera formatos elect. legales.al:409` | Missing custom object / field / procedure | Employee fields "Puesto Segun MT" and its related legacy position value are not present in the current repository. |
| `src\Codeunits\Codeunit 34002135 - Genera formatos elect. legales.al:549` | Missing custom object / field / procedure | Employee field "Puesto Segun MT" is not present in the current repository. |
| `src\Codeunits\Codeunit 34002135 - Genera formatos elect. legales.al:559` | Missing custom object / field / procedure | Employee field "Cod. Nacionalidad MT" is not present in the current repository. |
| `src\Codeunits\Codeunit 34002126 - Genera Formatos  E. Nomina CR.al:554` | Functional ambiguity / outside scope | This entire salary-change export remains disabled and still depends on legacy server-path setup and obsolete employee-field assumptions. |
| `src\Codeunits\Codeunit 34002126 - Genera Formatos  E. Nomina CR.al:648` | Functional ambiguity / outside scope | This entire variable-salary export remains disabled and its source-field and activation requirements are not defined. |
| `src\Codeunits\Codeunit 34002126 - Genera Formatos  E. Nomina CR.al:825` | Functional ambiguity / outside scope | This entire journal-bank export remains disabled and requires an activation decision before its file flow can be migrated. |
| `src\Codeunits\Codeunit 34002126 - Genera Formatos  E. Nomina CR.al:843` | Missing custom object / field / procedure | Standard codeunits 10090 and 10091 referenced by the disabled payment-export implementations are unavailable in Business Central v27. |
| `src\Codeunits\Codeunit 34002126 - Genera Formatos  E. Nomina CR.al:879` | Missing custom object / field / procedure | Bank Account field "E-Pay Export File Path" is unavailable; the disabled provider-export procedures also require missing payment metadata fields. |
| `src\Codeunits\Codeunit 34002126 - Genera Formatos  E. Nomina CR.al:919` | Missing custom object / field / procedure | Check Ledger Entry fields "Trace No." and "Transmission File Name" and Gen. Journal Line field "Export File Name" are unavailable. |
| `src\Codeunits\Codeunit 34002126 - Genera Formatos  E. Nomina CR.al:931` | Functional ambiguity / outside scope | This entire vendor-payment email body remains disabled and depends on removed custom setup and payment fields; activating it requires a business decision. |
| `src\Codeunits\Codeunit 34002126 - Genera Formatos  E. Nomina CR.al:1235` | Missing custom object / field / procedure | The complete BCR provider-payment implementation is disabled and depends on removed payment metadata fields. |
| `src\Codeunits\Codeunit 34002126 - Genera Formatos  E. Nomina CR.al:1577` | Missing custom object / field / procedure | The complete BHD provider-payment implementation is disabled and depends on removed payment metadata fields. |
| `src\Codeunits\Codeunit 34002500 - Lanzador DsPOS.al:12` | External contract / SaaS redesign | The DsPOS control-add-in initialization methods are disabled in the referenced codeunit and the legacy client add-in is not SaaS-compatible. |
| `src\Codeunits\Codeunit 34002199 - Utilitario para corr. datos no.al:9` | Missing custom object / field / procedure | Table 10144 is unavailable, so its historical-deposit data permission cannot be restored. |
| `src\Codeunits\Codeunit 34002199 - Utilitario para corr. datos no.al:31` | Missing custom object / field / procedure | Table 10144 is unavailable, so the HistDeposits record dependency cannot be restored. |
| `src\Codeunits\Codeunit 34002199 - Utilitario para corr. datos no.al:38` | Missing custom object / field / procedure | Virtual table 2000000071 is unavailable, and deleting compiled object metadata is unsupported in Business Central Online. |
| `src\Codeunits\Codeunit 34002522 - Registrar Ventas en Lote DsPOS.al:1073` | Missing custom object / field / procedure | Codeunit 34002503 does not expose Pais in the compiled object, so the country-specific integrity branches cannot be selected. |
| `src\Codeunits\Codeunit 34002521 - Control TPV.al:19` | External contract / SaaS redesign | The invoice-cancellation call targets disabled legacy POS integration behavior and its external transaction contract is unavailable. |
| `src\Codeunits\Codeunit 55202 - Facturacion  Electronica NAV.al:3` | External contract / SaaS redesign | The complete electronic-invoicing implementation is absent and requires an external integration contract; no executable replacement exists in the repository. |
| `src\Codeunits\Codeunit 55204 - Registro de costo.al:46` | Undefined background destination | This codeunit runs as a timed background process, but no SaaS-compatible storage or delivery destination is defined for the generated cost-report PDF or its duplicate-prevention state. |
| `src\Codeunits\Codeunit 55201 - Utilitario para corregir cosas.al:9` | Missing custom object / field / procedure | Table 10144 is unavailable, so its historical-deposit data permission cannot be restored. |
| `src\Codeunits\Codeunit 55201 - Utilitario para corregir cosas.al:32` | Missing custom object / field / procedure | Table 10144 is unavailable, so the HistDeposits record dependency cannot be restored. |
| `src\Codeunits\Codeunit 55201 - Utilitario para corregir cosas.al:48` | Missing custom object / field / procedure | Virtual table 2000000071 is unavailable, and deleting compiled object metadata is unsupported in Business Central Online. |
| `src\Codeunits\Codeunit 55201 - Utilitario para corregir cosas.al:77` | Missing custom object / field / procedure | Table 10144 is unavailable, so the historical-deposit external-document correction cannot be restored. |
| `src\Codeunits\Codeunit 55112 - Sales-Post + Print SIC_BC.al:271` | Missing custom object / field / procedure | The electronic-invoicing calls target procedures absent from the empty Codeunit 55202, so posting-side behavior cannot be restored. |
| `src\Codeunits\Codeunit 55112 - Sales-Post + Print SIC_BC.al:280` | Missing custom object / field / procedure | The electronic-invoicing calls target procedures absent from the empty Codeunit 55202, so posting-side behavior cannot be restored. |
| `src\Codeunits\Codeunit 55225 - Funciones Santillana.al:580` | Missing custom object / field / procedure | The current Config. Usuarios Empresa table does not contain the email opt-in, recipient, or address fields required by this confirmation workflow. |
| `src\Codeunits\Codeunit 55225 - Funciones Santillana.al:816` | Missing custom object / field / procedure | Report 55164 is not present in the current repository, so the original POS sales registration cannot be restored. |
| `src\Codeunits\Codeunit 55228 - Factura Electronica.al:3` | External contract / SaaS redesign | The complete legacy electronic-invoicing implementation is absent and cannot be reconstructed from this empty codeunit. |
| `src\Codeunits\Codeunit 55002 - Export Payments Formato EC.al:83` | Missing custom object / field / procedure | The bank export cannot be activated because Company Information."Federal ID No." and Bank Account fields "Export Format", "Transit No.", "E-Pay Export File Path", "Last E-Pay Export File Name", and "E-Pay Trans. Program Path" are unavailable. |
| `src\Codeunits\Codeunit 55002 - Export Payments Formato EC.al:383` | Missing custom object / field / procedure | Field "Last ACH File ID Modifier" is unavailable on the current Bank Account table. |
| `src\Codeunits\Codeunit 55233 - Registro de costos.al:60` | Undefined background destination | This timed background process has no SaaS-compatible storage or delivery destination for the generated cost-report PDF. |
| `src\Codeunits\Codeunit 55353 - Web Service MdE.al:21` | Missing custom object / field / procedure | XMLport Web Service MdE does not expose the GetInfo, GetOutStrm, or SendAsyncResponse procedures in the compiled object. |
| `src\Codeunits\Codeunit 55354 - Informacion Complementaria MDE.al:3` | External contract / SaaS redesign | The complete legacy complementary-message implementation is absent and cannot be reconstructed from this empty codeunit. |
| `src\Codeunits\Codeunit 55468 - Generacion Words APS.al:481` | External contract / SaaS redesign | The complete Word-generation block depends on temporary server files, legacy Word Automation, and client file transfer; it requires a SaaS document-generation redesign. |
| `src\Codeunits\Codeunit 55683 - Imp Excel MdM.al:25` | Functional ambiguity / outside scope | Activating this import requires changes to disabled actions on Page 55697 outside src/Codeunits and migration of the disabled custom multi-sheet workbook body to stream APIs. |
| `src\Codeunits\Codeunit 55687 - MdM Async Sender.al:4` | External contract / SaaS redesign | The complete asynchronous MdM sender implementation is absent, including its endpoint, payload, authentication, retry, and error contracts. |
| `src\Codeunits\Codeunit 55686 - MdM Async Manager.al:138` | Missing custom object / field / procedure | Codeunit 55687 is empty and does not expose BuildXMLError, BuildXMLRequest, or Send; the asynchronous response contract is unavailable. |
| `src\Codeunits\EXCCRIGenJnlPostLineSub.Codeunit.al:87` | Functional ambiguity / outside scope | The insolvency posting context cannot be activated safely while the journal-producing report remains disabled outside src/Codeunits and the end-to-end posting transaction has not been validated. |
| `src\Codeunits\EXCCRIGenJnlPostLineSub.Codeunit.al:139` | Genuine functional ambiguity | Restoring the custom insolvency account types after posting requires end-to-end validation with the disabled journal-producing report and its transaction semantics. |
| `src\Codeunits\EXCCRIGenJnlPostLineSub.Codeunit.al:159` | Genuine functional ambiguity | Enabling recognition of the custom insolvency account types would activate high-risk financial posting while its journal source remains disabled and unvalidated. |
| `src\Codeunits\EXCCRISalesPostYesNoSub.Codeunit.al:95` | Missing custom object / field / procedure | Codeunit 55228 is empty and does not expose Factura for the posted sales-invoice record. |
| `src\Codeunits\EXCCRISalesPostYesNoSub.Codeunit.al:104` | Missing custom object / field / procedure | Codeunit 55228 is empty and does not expose NotaCR for the posted sales-credit-memo record. |
| `src\Codeunits\EXCCRISalesPostYesNoSub.Codeunit.al:124` | Missing custom object / field / procedure | Codeunit 55202 is empty and does not expose the Costa Rica invoice, export-invoice, or electronic-ticket procedures required by this posting branch. |
| `src\Codeunits\EXCCRISalesPostYesNoSub.Codeunit.al:152` | Missing custom object / field / procedure | Codeunit 55202 is empty and does not expose NotaCreditoElectronica for the posted credit-memo number. |

# Manual-review re-evaluation completion

- Batches completed: 6.
- Codeunits inspected: 45.
- Unique AL codeunits modified: 31.
- Manual-review comments resolved or deduplicated: 145.
- Email migrations completed: 4 synchronous Email/Email Message flows; the
  Job Queue failure subscriber was also restored to the migrated notification
  codeunit.
- Report and file migrations completed: 1 PDF report attachment, 1 Excel
  upload, and 7 browser-download text/XML export flows.
- Standard API migrations completed: Temp Blob streams, UploadIntoStream,
  DownloadFromStream, Email/Email Message, HttpClient, Record Link
  Management, Type Helper HTML encoding, Copy Document Mgt., list-based
  dimensions, sales-line reservation filters, AllObjWithCaption, AL date
  arithmetic, UserId, and Environment Information.
- Event subscribers migrated: 2.
- Manual reviews retained: 61.
- Retained by permitted exclusion:
  - Missing custom object / field / procedure: 38.
  - External contract / SaaS redesign: 8.
  - Functional ambiguity / outside scope: 11.
  - Undefined background destination: 2.
  - Genuine functional ambiguity: 2.
- Final `al_compile`: succeeded with 0 errors and 10,118 warnings.
- New warnings introduced by this re-evaluation: 0. The final warning count
  equals the 10,118-warning baseline.
- Exact stop condition: every current manual-review comment under
  `src/Codeunits` was re-evaluated; every verified direct standard Business
  Central v27 SaaS migration was implemented; every one of the 61 retained
  reviews is listed above under a permitted exclusion; final compilation
  succeeded.
