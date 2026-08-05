# Page Field Normalization Progress

## Initial inventory

- Inventory date: 2026-07-29
- AL files inspected: 520
- Page objects found: 520
- Page extensions skipped: 0
- Field controls found: 6,054
- Fields missing `ApplicationArea`: 5,986
- Fields whose `ApplicationArea` is not `All`: 60
- Duplicate `ApplicationArea` properties: 0
- Direct SourceTable fields identified: 5,791
- Direct SourceTable fields missing `Rec.`: 5,784
- Direct SourceTable fields already correctly qualified: 7
- Direct SourceTable fields missing ToolTip: 5,760
- Direct SourceTable fields whose ToolTip differs from the exact field name: 30
- Variable-backed controls: 157
- Expression-backed controls: 106
- Existing invalid or unresolved `Rec.` qualifications: 0
- Duplicate ToolTip properties: 0
- SourceTable-less pages: 20
- Unresolved SourceTables: 0

## Symbol verification

- Custom SourceTables were verified against table declarations under `src/tables`.
- Standard SourceTables were verified from installed dependency `SymbolReference.json` data.
- Project table-extension fields were included from 108 tableextension objects outside the page scope.
- `al_symbolsearch` cross-checked standard Sales Header fields.

## Compilation baseline

- Whole-project errors: 391
- Errors under `src/pages`: 2
- Errors outside `src/pages`: 389
- Diagnostics truncated: no
- `src/pages/Page 34002134 - Histórico Préstamos.al:16:39` — `AL0118`: The name `No. Préstamo` does not exist in the current context.
- `src/pages/Page 34002138 - Lista Mov. CxC Empleados.al:3:18` — `AL0185`: Page `Historico Prestamos` is missing.

## Batches

### Batch 1

- Pages inspected: 10 (34002100, 34002101, 34002102, 34002103, 34002104, 34002105, 34002106, 34002109, 34002110, 34002111)
- Pages modified: 10
- Field controls inspected: 245
- Direct SourceTable fields found: 245
- `Rec.` qualifiers added: 245
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 245
- `ApplicationArea` properties normalized: 0
- ToolTips added: 245
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 501
- Remaining noncompliant controls: 5,808
- Last processed page: 34002111
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 2

- Pages inspected: 10 (34002112 through 34002122, current source order)
- Pages modified: 10
- Field controls inspected: 188
- Direct SourceTable fields found: 176
- `Rec.` qualifiers added: 176
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 188
- `ApplicationArea` properties normalized: 0
- ToolTips added: 176
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 11
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 491
- Remaining noncompliant controls: 5,620
- Last processed page: 34002122
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 3

- Pages inspected: 10 (34002123, 34002124, 34002125, 34002127, 34002128, 34002129, 34002130, 34002131, 34002132, 34002133)
- Pages modified: 10
- Field controls inspected: 78
- Direct SourceTable fields found: 74
- `Rec.` qualifiers added: 74
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 78
- `ApplicationArea` properties normalized: 0
- ToolTips added: 74
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 2
- Expression-backed controls skipped for `Rec.` qualification: 2
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 481
- Remaining noncompliant controls: 5,542
- Last processed page: 34002133
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 4

- Pages inspected: 10 (34002134, 34002136, 34002137, 34002138, 34002139, 34002140, 34002141, 34002143, 34002144, 34002146)
- Pages modified: 10
- Field controls inspected: 99
- Direct SourceTable fields found: 97
- `Rec.` qualifiers added: 97
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 99
- `ApplicationArea` properties normalized: 0
- ToolTips added: 97
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 2
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 471
- Remaining noncompliant controls: 5,443
- Last processed page: 34002146
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 5

- Pages inspected: 10 (34002147, 34002148, 34002151, 34002152, 34002153, 34002154, 34002155, 34002158, 34002159, 34002160)
- Pages modified: 10
- Field controls inspected: 138
- Direct SourceTable fields found: 138
- `Rec.` qualifiers added: 138
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 138
- `ApplicationArea` properties normalized: 0
- ToolTips added: 138
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 461
- Remaining noncompliant controls: 5,305
- Last processed page: 34002160
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 6

- Pages inspected: 10 (34002161, 34002162, 34002163, 34002164, 34002165, 34002166, 34002167, 34002168, 34002169, 34002170)
- Pages modified: 10
- Field controls inspected: 123
- Direct SourceTable fields found: 123
- `Rec.` qualifiers added: 123
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 123
- `ApplicationArea` properties normalized: 0
- ToolTips added: 123
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 451
- Remaining noncompliant controls: 5,182
- Last processed page: 34002170
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 7

- Pages inspected: 10 (34002172, 34002175, 34002176, 34002177, 34002178, 34002179, 34002180, 34002181, 34002183, 34002184)
- Pages modified: 10
- Field controls inspected: 156
- Direct SourceTable fields found: 143
- `Rec.` qualifiers added: 143
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 156
- `ApplicationArea` properties normalized: 0
- ToolTips added: 143
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 13
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 441
- Remaining noncompliant controls: 5,026
- Last processed page: 34002184
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 8

- Pages inspected: 10 (34002185, 34002187, 34002188, 34002190, 34002191, 34002192, 34002193, 34002194, 34002195, 34002196)
- Pages modified: 10
- Field controls inspected: 149
- Direct SourceTable fields found: 144
- `Rec.` qualifiers added: 144
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 149
- `ApplicationArea` properties normalized: 0
- ToolTips added: 144
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 4
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 431
- Remaining noncompliant controls: 4,877
- Last processed page: 34002196
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 9

- Pages inspected: 10 (34002197, 34002198, 34002199, 34002200, 34002201, 34002202, 34002203, 34002204, 34002205, 34002206)
- Pages modified: 10
- Field controls inspected: 137
- Direct SourceTable fields found: 135
- `Rec.` qualifiers added: 135
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 137
- `ApplicationArea` properties normalized: 0
- ToolTips added: 135
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 1
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 421
- Remaining noncompliant controls: 4,740
- Last processed page: 34002206
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 10

- Pages inspected: 10 (34002207, 34002208, 34002209, 34002210, 34002211, 34002212, 34002213, 34002214, 34002215, 34002216)
- Pages modified: 10
- Field controls inspected: 100
- Direct SourceTable fields found: 96
- `Rec.` qualifiers added: 96
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 78
- `ApplicationArea` properties normalized: 15
- ToolTips added: 78
- ToolTips normalized: 18
- Variable-backed controls skipped for `Rec.` qualification: 4
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 411
- Remaining noncompliant controls: 4,640
- Last processed page: 34002216
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 11

- Pages inspected: 10 (34002217, 34002218, 34002219, 34002220, 34002221, 34002222, 34002223, 34002224, 34002225, 34002226)
- Pages modified: 10
- Field controls inspected: 103
- Direct SourceTable fields found: 103
- `Rec.` qualifiers added: 103
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 103
- `ApplicationArea` properties normalized: 0
- ToolTips added: 103
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 401
- Remaining noncompliant controls: 4,537
- Last processed page: 34002226
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 12

- Pages inspected: 10 (34002227, 34002228, 34002229, 34002230, 34002231, 34002232, 34002233, 34002235, 34002237, 34002238)
- Pages modified: 10
- Field controls inspected: 91
- Direct SourceTable fields found: 85
- `Rec.` qualifiers added: 85
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 91
- `ApplicationArea` properties normalized: 0
- ToolTips added: 85
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 3
- Expression-backed controls skipped for `Rec.` qualification: 3
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 391
- Remaining noncompliant controls: 4,446
- Last processed page: 34002238
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 13

- Pages inspected: 10 (34002239, 34002240, 34002241, 34002242, 34002243, 34002244, 34002245, 34002246, 34002247, 34002249)
- Pages modified: 10
- Field controls inspected: 69
- Direct SourceTable fields found: 65
- `Rec.` qualifiers added: 65
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 67
- `ApplicationArea` properties normalized: 2
- ToolTips added: 65
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 3
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 381
- Remaining noncompliant controls: 4,377
- Last processed page: 34002249
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 14

- Pages inspected: 10 (34002250, 34002251, 34002253, 34002260, 34002500, 34002501, 34002502, 34002503, 34002504, 34002505)
- Pages modified: 10
- Field controls inspected: 134
- Direct SourceTable fields found: 98
- `Rec.` qualifiers added: 98
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 96
- `ApplicationArea` properties normalized: 38
- ToolTips added: 96
- ToolTips normalized: 2
- Variable-backed controls skipped for `Rec.` qualification: 5
- Expression-backed controls skipped for `Rec.` qualification: 31
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 371
- Remaining noncompliant controls: 4,243
- Last processed page: 34002505
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 15

- Pages inspected: 10 (34002506, 34002507, 34002508, 34002509, 34002510, 34002511, 34002512, 34002513, 34002514, 34002515)
- Pages modified: 10
- Field controls inspected: 52
- Direct SourceTable fields found: 51
- `Rec.` qualifiers added: 51
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 52
- `ApplicationArea` properties normalized: 0
- ToolTips added: 51
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 1
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 361
- Remaining noncompliant controls: 4,191
- Last processed page: 34002515
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 16

- Pages inspected: 10 (34002516, 34002517, 34002518, 34002519, 34002520, 34002521, 34002522, 34002523, 34002524, 34002525)
- Pages modified: 10
- Field controls inspected: 41
- Direct SourceTable fields found: 40
- `Rec.` qualifiers added: 40
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 41
- `ApplicationArea` properties normalized: 0
- ToolTips added: 40
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 351
- Remaining noncompliant controls: 4,150
- Last processed page: 34002525
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 17

- Pages inspected: 10 (34002526, 34002531, 34002532, 34002533, 34002534, 34002535, 34002536, 34002537, 34002538, 34002539)
- Pages modified: 10
- Field controls inspected: 140
- Direct SourceTable fields found: 130
- `Rec.` qualifiers added: 130
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 140
- `ApplicationArea` properties normalized: 0
- ToolTips added: 130
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 10
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 341
- Remaining noncompliant controls: 4,010
- Last processed page: 34002539
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 18

- Pages inspected: 10 (34002540, 34002541, 34002542, 34002543, 34002544, 34002545, 34002546, 34002547, 34002548, 34002549)
- Pages modified: 10
- Field controls inspected: 102
- Direct SourceTable fields found: 97
- `Rec.` qualifiers added: 97
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 102
- `ApplicationArea` properties normalized: 0
- ToolTips added: 97
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 5
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 331
- Remaining noncompliant controls: 3,908
- Last processed page: 34002549
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 19

- Pages inspected: 10 (34002550, 34002551, 34002552, 34002553, 34002554, 34002555, 34002556, 34002557, 34002558, 34002559)
- Pages modified: 10
- Field controls inspected: 273
- Direct SourceTable fields found: 271
- `Rec.` qualifiers added: 271
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 273
- `ApplicationArea` properties normalized: 0
- ToolTips added: 270
- ToolTips normalized: 1
- Variable-backed controls skipped for `Rec.` qualification: 2
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 321
- Remaining noncompliant controls: 3,635
- Last processed page: 34002559
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 20

- Pages inspected: 10 (34002560, 34003000, 34003001, 34003002, 34003003, 34003004, 34003005, 34003006, 34003007, 34003009)
- Pages modified: 10
- Field controls inspected: 109
- Direct SourceTable fields found: 109
- `Rec.` qualifiers added: 109
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 109
- `ApplicationArea` properties normalized: 0
- ToolTips added: 109
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 311
- Remaining noncompliant controls: 3,526
- Last processed page: 34003009
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 21

- Pages inspected: 10 (34003010, 34003011, 34003012, 34003015, 34003020, 34003021, 34003022, 34003023, 34003024, 34003025)
- Pages modified: 10
- Field controls inspected: 105
- Direct SourceTable fields found: 99
- `Rec.` qualifiers added: 99
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 105
- `ApplicationArea` properties normalized: 0
- ToolTips added: 99
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 6
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 301
- Remaining noncompliant controls: 3,421
- Last processed page: 34003025
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 22

- Pages inspected: 10 (34003026, 34003027, 34003028, 55001, 55025, 55026, 55029, 55030, 55037, 55110)
- Pages modified: 10
- Field controls inspected: 86
- Direct SourceTable fields found: 84
- `Rec.` qualifiers added: 83
- Existing correct qualifiers retained: 1
- `ApplicationArea` properties added: 83
- `ApplicationArea` properties normalized: 2
- ToolTips added: 82
- ToolTips normalized: 1
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 2
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 291
- Remaining noncompliant controls: 3,336
- Last processed page: 55110
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 23

- Pages inspected: 10 (55198, 55111, 55112, 55113, 55164, 55165, 55166, 55168, 55169, 55171)
- Pages modified: 10
- Field controls inspected: 112
- Direct SourceTable fields found: 112
- `Rec.` qualifiers added: 112
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 112
- `ApplicationArea` properties normalized: 0
- ToolTips added: 112
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 281
- Remaining noncompliant controls: 3,224
- Last processed page: 55171
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 24

- Pages inspected: 10 (55172, 55173, 55199, 55200, 55201, 55212, 55202, 55203, 55204, 55208)
- Pages modified: 10
- Field controls inspected: 55
- Direct SourceTable fields found: 40
- `Rec.` qualifiers added: 40
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 55
- `ApplicationArea` properties normalized: 0
- ToolTips added: 40
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 15
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 271
- Remaining noncompliant controls: 3,169
- Last processed page: 55208
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 25

- Pages inspected: 10 (55221, 55225, 55226, 55227, 55228, 55229, 55230, 55231, 55232, 55233)
- Pages modified: 10
- Field controls inspected: 150
- Direct SourceTable fields found: 146
- `Rec.` qualifiers added: 146
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 147
- `ApplicationArea` properties normalized: 3
- ToolTips added: 146
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 4
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 261
- Remaining noncompliant controls: 3,019
- Last processed page: 55233
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 26

- Pages inspected: 10 (55234, 55235, 55236, 55237, 55238, 55239, 55240, 55241, 55242, 55243)
- Pages modified: 10
- Field controls inspected: 119
- Direct SourceTable fields found: 119
- `Rec.` qualifiers added: 119
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 119
- `ApplicationArea` properties normalized: 0
- ToolTips added: 119
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 251
- Remaining noncompliant controls: 2,900
- Last processed page: 55243
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 27

- Pages inspected: 10 (55244, 55245, 55246, 55247, 55249, 55250, 55251, 55252, 55253, 55254)
- Pages modified: 10
- Field controls inspected: 302
- Direct SourceTable fields found: 293
- `Rec.` qualifiers added: 293
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 302
- `ApplicationArea` properties normalized: 0
- ToolTips added: 293
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 7
- Expression-backed controls skipped for `Rec.` qualification: 2
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 241
- Remaining noncompliant controls: 2,598
- Last processed page: 55254
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 28

- Pages inspected: 10 (55255, 55256, 55257, 55258, 55259, 55260, 55261, 55262, 55263, 55265)
- Pages modified: 10
- Field controls inspected: 148
- Direct SourceTable fields found: 143
- `Rec.` qualifiers added: 141
- Existing correct qualifiers retained: 2
- `ApplicationArea` properties added: 148
- `ApplicationArea` properties normalized: 0
- ToolTips added: 143
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 4
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 231
- Remaining noncompliant controls: 2,450
- Last processed page: 55265
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 29

- Pages inspected: 10 (55266, 55267, 55268, 55270, 55271, 55273, 55274, 55280, 55281, 55282)
- Pages modified: 10
- Field controls inspected: 72
- Direct SourceTable fields found: 57
- `Rec.` qualifiers added: 57
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 72
- `ApplicationArea` properties normalized: 0
- ToolTips added: 57
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 14
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 221
- Remaining noncompliant controls: 2,378
- Last processed page: 55282
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 30

- Pages inspected: 10 (55283, 55284, 55285, 55286, 55287, 55288, 55289, 55290, 55291, 55297)
- Pages modified: 10
- Field controls inspected: 103
- Direct SourceTable fields found: 96
- `Rec.` qualifiers added: 96
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 103
- `ApplicationArea` properties normalized: 0
- ToolTips added: 96
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 2
- Expression-backed controls skipped for `Rec.` qualification: 5
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 211
- Remaining noncompliant controls: 2,275
- Last processed page: 55297
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 31

- Pages inspected: 10 (55301, 55306, 55310, 55339, 55342, 55343, 55353, 55354, 55355, 55467)
- Pages modified: 10
- Field controls inspected: 148
- Direct SourceTable fields found: 122
- `Rec.` qualifiers added: 122
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 148
- `ApplicationArea` properties normalized: 0
- ToolTips added: 122
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 6
- Expression-backed controls skipped for `Rec.` qualification: 20
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 201
- Remaining noncompliant controls: 2,127
- Last processed page: 55467
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 32

- Pages inspected: 10 (55468, 55469, 55470, 55471, 55472, 55473, 55474, 55475, 55476, 55477)
- Pages modified: 10
- Field controls inspected: 89
- Direct SourceTable fields found: 89
- `Rec.` qualifiers added: 87
- Existing correct qualifiers retained: 2
- `ApplicationArea` properties added: 89
- `ApplicationArea` properties normalized: 0
- ToolTips added: 89
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 191
- Remaining noncompliant controls: 2,038
- Last processed page: 55477
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 33

- Pages inspected: 10 (55478, 55479, 55480, 55481, 55482, 55483, 55484, 55485, 55486, 55487)
- Pages modified: 10
- Field controls inspected: 139
- Direct SourceTable fields found: 136
- `Rec.` qualifiers added: 135
- Existing correct qualifiers retained: 1
- `ApplicationArea` properties added: 139
- `ApplicationArea` properties normalized: 0
- ToolTips added: 136
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 3
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 181
- Remaining noncompliant controls: 1,899
- Last processed page: 55487
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 34

- Pages inspected: 10 (55488, 55489, 55490, 55491, 55492, 55493, 55494, 55495, 55496, 55497)
- Pages modified: 10
- Field controls inspected: 124
- Direct SourceTable fields found: 124
- `Rec.` qualifiers added: 124
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 124
- `ApplicationArea` properties normalized: 0
- ToolTips added: 124
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 171
- Remaining noncompliant controls: 1,775
- Last processed page: 55497
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 35

- Pages inspected: 10 (55498, 55499, 55500, 67034, 67035, 67036, 67037, 67038, 67039, 67040)
- Pages modified: 10
- Field controls inspected: 114
- Direct SourceTable fields found: 113
- `Rec.` qualifiers added: 113
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 114
- `ApplicationArea` properties normalized: 0
- ToolTips added: 113
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 161
- Remaining noncompliant controls: 1,661
- Last processed page: 67040
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 36

- Pages inspected: 10 (67041, 67042, 67043, 67044, 67045, 67046, 67047, 67048, 67049, 67050)
- Pages modified: 10
- Field controls inspected: 115
- Direct SourceTable fields found: 115
- `Rec.` qualifiers added: 114
- Existing correct qualifiers retained: 1
- `ApplicationArea` properties added: 115
- `ApplicationArea` properties normalized: 0
- ToolTips added: 115
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 151
- Remaining noncompliant controls: 1,546
- Last processed page: 67050
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 37

- Pages inspected: 10 (67051, 67052, 67053, 67054, 67055, 67056, 67057, 67058, 67059, 67060)
- Pages modified: 10
- Field controls inspected: 91
- Direct SourceTable fields found: 89
- `Rec.` qualifiers added: 89
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 91
- `ApplicationArea` properties normalized: 0
- ToolTips added: 89
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 1
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 141
- Remaining noncompliant controls: 1,455
- Last processed page: 67060
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 38

- Pages inspected: 10 (67061, 67062, 67063, 67064, 67065, 67066, 67067, 67068, 67069, 67070)
- Pages modified: 10
- Field controls inspected: 144
- Direct SourceTable fields found: 142
- `Rec.` qualifiers added: 142
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 144
- `ApplicationArea` properties normalized: 0
- ToolTips added: 142
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 2
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 131
- Remaining noncompliant controls: 1,311
- Last processed page: 67070
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 39

- Pages inspected: 10 (67071, 67072, 67073, 67074, 67075, 67076, 67077, 67078, 67079, 67080)
- Pages modified: 10
- Field controls inspected: 196
- Direct SourceTable fields found: 184
- `Rec.` qualifiers added: 184
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 196
- `ApplicationArea` properties normalized: 0
- ToolTips added: 184
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 2
- Expression-backed controls skipped for `Rec.` qualification: 10
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 121
- Remaining noncompliant controls: 1,115
- Last processed page: 67080
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 40

- Pages inspected: 10 (67081, 67082, 67083, 67084, 67085, 67086, 67087, 67088, 67089, 67090)
- Pages modified: 10
- Field controls inspected: 77
- Direct SourceTable fields found: 77
- `Rec.` qualifiers added: 77
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 77
- `ApplicationArea` properties normalized: 0
- ToolTips added: 77
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 111
- Remaining noncompliant controls: 1,038
- Last processed page: 67090
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 41

- Pages inspected: 10 (67091, 67092, 67093, 67094, 67095, 67096, 67097, 67098, 67099, 67100)
- Pages modified: 10
- Field controls inspected: 47
- Direct SourceTable fields found: 47
- `Rec.` qualifiers added: 47
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 47
- `ApplicationArea` properties normalized: 0
- ToolTips added: 47
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 101
- Remaining noncompliant controls: 991
- Last processed page: 67100
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 42

- Pages inspected: 10 (67101, 67102, 67103, 67104, 67105, 67106, 67107, 67108, 67109, 67110)
- Pages modified: 10
- Field controls inspected: 133
- Direct SourceTable fields found: 128
- `Rec.` qualifiers added: 128
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 133
- `ApplicationArea` properties normalized: 0
- ToolTips added: 128
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 4
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 91
- Remaining noncompliant controls: 858
- Last processed page: 67110
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 43

- Pages inspected: 10 (67111, 67112, 67113, 67114, 67115, 67116, 67117, 67118, 67119, 67120)
- Pages modified: 10
- Field controls inspected: 109
- Direct SourceTable fields found: 83
- `Rec.` qualifiers added: 83
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 109
- `ApplicationArea` properties normalized: 0
- ToolTips added: 83
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 25
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 81
- Remaining noncompliant controls: 749
- Last processed page: 67120
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 44

- Pages inspected: 10 (67121, 67122, 67123, 67124, 67125, 67126, 67127, 67128, 67129, 67130)
- Pages modified: 10
- Field controls inspected: 85
- Direct SourceTable fields found: 84
- `Rec.` qualifiers added: 84
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 85
- `ApplicationArea` properties normalized: 0
- ToolTips added: 84
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 1
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 71
- Remaining noncompliant controls: 664
- Last processed page: 67130
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 45

- Pages inspected: 10 (67131, 67132, 67133, 67134, 67135, 67136, 67137, 67138, 67139, 67140)
- Pages modified: 10
- Field controls inspected: 57
- Direct SourceTable fields found: 56
- `Rec.` qualifiers added: 56
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 57
- `ApplicationArea` properties normalized: 0
- ToolTips added: 56
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 1
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 61
- Remaining noncompliant controls: 607
- Last processed page: 67140
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 46

- Pages inspected: 10 (67141, 67142, 67143, 67144, 67145, 67146, 67147, 67148, 67149, 67150)
- Pages modified: 10
- Field controls inspected: 98
- Direct SourceTable fields found: 97
- `Rec.` qualifiers added: 97
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 98
- `ApplicationArea` properties normalized: 0
- ToolTips added: 97
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 1
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 51
- Remaining noncompliant controls: 509
- Last processed page: 67150
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 47

- Pages inspected: 10 (67151, 67152, 67153, 67154, 67155, 67156, 67157, 67158, 67159, 67160)
- Pages modified: 10
- Field controls inspected: 158
- Direct SourceTable fields found: 156
- `Rec.` qualifiers added: 156
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 158
- `ApplicationArea` properties normalized: 0
- ToolTips added: 156
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 2
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 41
- Remaining noncompliant controls: 351
- Last processed page: 67160
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 48

- Pages inspected: 10 (67161, 67162, 67163, 67164, 67165, 67166, 67167, 67168, 67169, 67170)
- Pages modified: 10
- Field controls inspected: 82
- Direct SourceTable fields found: 80
- `Rec.` qualifiers added: 80
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 82
- `ApplicationArea` properties normalized: 0
- ToolTips added: 80
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 1
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 31
- Remaining noncompliant controls: 269
- Last processed page: 67170
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 49

- Pages inspected: 10 (67171, 67172, 67173, 67174, 67175, 67176, 67177, 67178, 67179, 67180)
- Pages modified: 10
- Field controls inspected: 111
- Direct SourceTable fields found: 108
- `Rec.` qualifiers added: 108
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 111
- `ApplicationArea` properties normalized: 0
- ToolTips added: 108
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 3
- Expression-backed controls skipped for `Rec.` qualification: 0
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 21
- Remaining noncompliant controls: 158
- Last processed page: 67180
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 50

- Pages inspected: 10 (67181, 67182, 67183, 67184, 75000, 75001, 75002, 75003, 75004, 75005)
- Pages modified: 10
- Field controls inspected: 87
- Direct SourceTable fields found: 85
- `Rec.` qualifiers added: 85
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 87
- `ApplicationArea` properties normalized: 0
- ToolTips added: 77
- ToolTips normalized: 8
- Variable-backed controls skipped for `Rec.` qualification: 1
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 11
- Remaining noncompliant controls: 71
- Last processed page: 75005
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 51

- Pages inspected: 10 (75006, 75007, 75008, 75009, 75010, 75011, 75012, 75013, 75014, 75016)
- Pages modified: 10
- Field controls inspected: 60
- Direct SourceTable fields found: 57
- `Rec.` qualifiers added: 57
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 60
- `ApplicationArea` properties normalized: 0
- ToolTips added: 57
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 1
- Expression-backed controls skipped for `Rec.` qualification: 2
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 1
- Remaining noncompliant controls: 11
- Last processed page: 75016
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

### Batch 52

- Pages inspected: 1 (75017)
- Pages modified: 1
- Field controls inspected: 11
- Direct SourceTable fields found: 10
- `Rec.` qualifiers added: 10
- Existing correct qualifiers retained: 0
- `ApplicationArea` properties added: 11
- `ApplicationArea` properties normalized: 0
- ToolTips added: 10
- ToolTips normalized: 0
- Variable-backed controls skipped for `Rec.` qualification: 0
- Expression-backed controls skipped for `Rec.` qualification: 1
- Page extensions skipped: 0
- Compilation baseline errors: 391
- Current compilation errors: no increase from baseline
- New errors introduced: 0
- Scoped errors in `src/pages`: 0
- Remaining page objects with noncompliant controls: 0
- Remaining noncompliant controls: 0
- Last processed page: 75017
- Compilation result: batch passed scoped validation; all reported project errors are pre-existing and outside the modified files.

## Final verification

- Compilation batches completed: 52
- Page objects inspected: 520
- Page objects modified: 511
- Page objects already compliant or without field controls: 9
- Field controls inspected: 6,054
- Direct SourceTable fields identified: 5,791
- `Rec.` qualifiers added: 5,784
- Existing correct `Rec.` qualifiers retained: 7
- `ApplicationArea` properties added: 5,986
- `ApplicationArea` properties normalized to `All`: 60
- ToolTips added to direct fields: 5,760
- ToolTips normalized on direct fields: 30
- Variable-backed controls left without `Rec.`: 157
- Expression-backed controls left without `Rec.`: 106
- Page extensions skipped: 0
- Final noncompliant controls: 0
- Final invalid `Rec.` qualifications: 0
- Final duplicate `ApplicationArea` properties: 0
- Final duplicate ToolTip properties: 0
- Compilation baseline errors: 391
- Final compilation errors: 389
- Errors under `src/pages`: 0
- New compilation errors introduced: 0
- Final warnings: 4,581
- Last processed page: 75017
- Stop condition: every page object was inspected, every field control is compliant, no pageextension was modified, and the task introduced zero new compilation errors.
