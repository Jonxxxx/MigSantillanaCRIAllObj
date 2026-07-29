# Report Request-Page Field Normalization Progress

## Initial inventory

- Inventory date: 2026-07-29
- AL files inspected: 281
- Report objects found: 281
- Reports containing request pages: 273
- Reports without request pages: 8
- Request pages without field controls: 167
- Request-page field controls found: 314
- Fields missing `ApplicationArea`: 250
- Fields whose `ApplicationArea` is not `All`: 22
- Duplicate `ApplicationArea` properties: 0
- Fields missing ToolTip: 258
- Fields whose ToolTip differs from the resolved value: 55
- Duplicate ToolTip properties: 0
- Fields with static Captions: 256
- Fields without Captions: 58
- Fields with CaptionClass or another dynamic Caption: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Initial noncompliant request-page fields: 313

## Compilation baseline

- Whole-project errors: 389
- Errors under `src/reports`: 373
- Errors outside `src/reports`: 16
- Report files containing baseline errors: 41
- Whole-project warnings: 4,581
- Diagnostics truncated: no

## Verification safeguards

- Request-page source expressions were snapshotted before modification.
- Dataset blocks were hashed before modification.
- Only fields inside `requestpage.layout` are candidates for normalization.

## Batches

### Batch 1

- Reports inspected: 10 (34002101 through 34002110)
- Reports modified: 5
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 19
- `ApplicationArea` properties added: 19
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 8
- ToolTips added from control names: 11
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 344
- New errors introduced: 0
- Remaining reports: 271
- Remaining noncompliant request-page fields: 294
- Last processed report: 34002110
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 2

- Reports inspected: 10 (34002111, 34002112, 34002113, 34002114, 34002115, 34002116, 34002117, 34002118, 34002119, 34002120)
- Reports modified: 5
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 14
- `ApplicationArea` properties added: 10
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 2
- ToolTips added from control names: 8
- Existing ToolTips normalized: 4
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 327
- New errors introduced: 0
- Remaining reports: 261
- Remaining noncompliant request-page fields: 280
- Last processed report: 34002120
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 3

- Reports inspected: 10 (34002121, 34002122, 34002123, 34002124, 34002125, 34002126, 34002127, 34002128, 34002129, 34002130)
- Reports modified: 9
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 31
- `ApplicationArea` properties added: 31
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 18
- ToolTips added from control names: 13
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 313
- New errors introduced: 0
- Remaining reports: 251
- Remaining noncompliant request-page fields: 249
- Last processed report: 34002130
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 4

- Reports inspected: 10 (34002131, 34002132, 34002133, 34002134, 34002135, 34002136, 34002137, 34002138, 34002139, 34002140)
- Reports modified: 6
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 17
- `ApplicationArea` properties added: 15
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 13
- ToolTips added from control names: 2
- Existing ToolTips normalized: 2
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 301
- New errors introduced: 0
- Remaining reports: 241
- Remaining noncompliant request-page fields: 232
- Last processed report: 34002140
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 5

- Reports inspected: 10 (34002141, 34002142, 34002143, 34002144, 34002145, 34002146, 34002147, 34002148, 34002149, 34002150)
- Reports modified: 7
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 20
- `ApplicationArea` properties added: 12
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 8
- ToolTips added from control names: 4
- Existing ToolTips normalized: 8
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 295
- New errors introduced: 0
- Remaining reports: 231
- Remaining noncompliant request-page fields: 212
- Last processed report: 34002150
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 6

- Reports inspected: 10 (34002151, 34002152, 34002153, 34002154, 34002155, 34002156, 34002157, 34002158, 34002159, 34002160)
- Reports modified: 3
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 11
- `ApplicationArea` properties added: 11
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 6
- ToolTips added from control names: 5
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 292
- New errors introduced: 0
- Remaining reports: 221
- Remaining noncompliant request-page fields: 201
- Last processed report: 34002160
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 7

- Reports inspected: 10 (34002161, 34002162, 34002163, 34002164, 34002165, 34002166, 34002167, 34002168, 34002169, 34002170)
- Reports modified: 1
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 1
- `ApplicationArea` properties added: 0
- `ApplicationArea` properties normalized: 1
- ToolTips added from static Captions: 0
- ToolTips added from control names: 0
- Existing ToolTips normalized: 1
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 281
- New errors introduced: 0
- Remaining reports: 211
- Remaining noncompliant request-page fields: 200
- Last processed report: 34002170
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 8

- Reports inspected: 10 (34002180, 34002181, 34002182, 34002183, 34002502, 34002503, 34002504, 34002505, 34002506, 34002507)
- Reports modified: 3
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 10
- `ApplicationArea` properties added: 4
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 4
- ToolTips added from control names: 0
- Existing ToolTips normalized: 6
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 263
- New errors introduced: 0
- Remaining reports: 201
- Remaining noncompliant request-page fields: 190
- Last processed report: 34002507
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 9

- Reports inspected: 10 (34002508, 34002509, 34002510, 34002511, 34002512, 34002513, 34002514, 34002515, 34002516, 34002517)
- Reports modified: 1
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 4
- `ApplicationArea` properties added: 4
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 3
- ToolTips added from control names: 0
- Existing ToolTips normalized: 1
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 263
- New errors introduced: 0
- Remaining reports: 191
- Remaining noncompliant request-page fields: 186
- Last processed report: 34002517
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 10

- Reports inspected: 10 (34002518, 34002519, 34002521, 34002522, 34002530, 34002531, 34003000, 34003001, 34003002, 34003003)
- Reports modified: 2
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 6
- `ApplicationArea` properties added: 6
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 6
- ToolTips added from control names: 0
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 263
- New errors introduced: 0
- Remaining reports: 181
- Remaining noncompliant request-page fields: 180
- Last processed report: 34003003
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 11

- Reports inspected: 10 (34003004, 34003005, 34003006, 34003007, 34003008, 34003009, 34003010, 34003012, 34003013, 34003014)
- Reports modified: 3
- Reports with request pages: 9
- Reports without request pages: 1
- Request-page fields inspected: 9
- `ApplicationArea` properties added: 7
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 7
- ToolTips added from control names: 0
- Existing ToolTips normalized: 2
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 171
- Remaining noncompliant request-page fields: 171
- Last processed report: 34003014
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 12

- Reports inspected: 10 (34003015, 34003016, 50000, 50001, 50002, 50003, 50004, 50006, 50007, 50016)
- Reports modified: 3
- Reports with request pages: 9
- Reports without request pages: 1
- Request-page fields inspected: 8
- `ApplicationArea` properties added: 5
- `ApplicationArea` properties normalized: 3
- ToolTips added from static Captions: 5
- ToolTips added from control names: 0
- Existing ToolTips normalized: 3
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 161
- Remaining noncompliant request-page fields: 163
- Last processed report: 50016
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 13

- Reports inspected: 10 (50045, 50047, 50048, 51006, 51007, 51009, 51020, 52500, 52501, 52502)
- Reports modified: 7
- Reports with request pages: 9
- Reports without request pages: 1
- Request-page fields inspected: 24
- `ApplicationArea` properties added: 23
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 23
- ToolTips added from control names: 0
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 151
- Remaining noncompliant request-page fields: 140
- Last processed report: 52502
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 14

- Reports inspected: 10 (52503, 52504, 52505, 52542, 52543, 52544, 52545, 52546, 52548, 52549)
- Reports modified: 8
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 21
- `ApplicationArea` properties added: 6
- `ApplicationArea` properties normalized: 15
- ToolTips added from static Captions: 6
- ToolTips added from control names: 0
- Existing ToolTips normalized: 15
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 141
- Remaining noncompliant request-page fields: 119
- Last processed report: 52549
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 15

- Reports inspected: 10 (54010, 55020, 56000, 56001, 56002, 56004, 56006, 56007, 56008, 56010)
- Reports modified: 2
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 4
- `ApplicationArea` properties added: 1
- `ApplicationArea` properties normalized: 3
- ToolTips added from static Captions: 0
- ToolTips added from control names: 1
- Existing ToolTips normalized: 3
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 131
- Remaining noncompliant request-page fields: 115
- Last processed report: 56010
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 16

- Reports inspected: 10 (56012, 56014, 56017, 56018, 56019, 56021, 56023, 56024, 56025, 56026)
- Reports modified: 0
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 0
- `ApplicationArea` properties added: 0
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 0
- ToolTips added from control names: 0
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 121
- Remaining noncompliant request-page fields: 115
- Last processed report: 56026
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 17

- Reports inspected: 10 (56027, 56029, 56030, 56031, 56032, 56033, 56034, 56035, 56036, 56037)
- Reports modified: 3
- Reports with request pages: 9
- Reports without request pages: 1
- Request-page fields inspected: 20
- `ApplicationArea` properties added: 12
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 12
- ToolTips added from control names: 0
- Existing ToolTips normalized: 8
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 111
- Remaining noncompliant request-page fields: 95
- Last processed report: 56037
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 18

- Reports inspected: 10 (56038, 56039, 56040, 56041, 56050, 56056, 56073, 56074, 56075, 56076)
- Reports modified: 3
- Reports with request pages: 9
- Reports without request pages: 1
- Request-page fields inspected: 6
- `ApplicationArea` properties added: 6
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 2
- ToolTips added from control names: 4
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 101
- Remaining noncompliant request-page fields: 89
- Last processed report: 56076
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 19

- Reports inspected: 10 (56077, 56078, 56079, 56080, 56081, 56082, 56083, 56084, 56085, 56086)
- Reports modified: 0
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 0
- `ApplicationArea` properties added: 0
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 0
- ToolTips added from control names: 0
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 91
- Remaining noncompliant request-page fields: 89
- Last processed report: 56086
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 20

- Reports inspected: 10 (56087, 56088, 56089, 56090, 56091, 56092, 56093, 56094, 56095, 56096)
- Reports modified: 2
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 5
- `ApplicationArea` properties added: 5
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 3
- ToolTips added from control names: 2
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 81
- Remaining noncompliant request-page fields: 84
- Last processed report: 56096
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 21

- Reports inspected: 10 (56097, 56098, 56099, 56100, 56101, 56103, 56105, 56106, 56107, 56109)
- Reports modified: 1
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 1
- `ApplicationArea` properties added: 1
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 1
- ToolTips added from control names: 0
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 71
- Remaining noncompliant request-page fields: 83
- Last processed report: 56109
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 22

- Reports inspected: 10 (56110, 56111, 56112, 56115, 56117, 56119, 56120, 56121, 56122, 56123)
- Reports modified: 6
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 22
- `ApplicationArea` properties added: 22
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 21
- ToolTips added from control names: 1
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 61
- Remaining noncompliant request-page fields: 61
- Last processed report: 56123
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 23

- Reports inspected: 10 (56124, 56125, 56128, 56129, 56130, 56131, 56133, 56134, 56135, 56136)
- Reports modified: 2
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 13
- `ApplicationArea` properties added: 13
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 13
- ToolTips added from control names: 0
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 51
- Remaining noncompliant request-page fields: 48
- Last processed report: 56136
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 24

- Reports inspected: 10 (56137, 56138, 56144, 56186, 56187, 56200, 56524, 56525, 56526, 56527)
- Reports modified: 9
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 18
- `ApplicationArea` properties added: 18
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 16
- ToolTips added from control names: 2
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 41
- Remaining noncompliant request-page fields: 30
- Last processed report: 56527
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 25

- Reports inspected: 10 (56528, 56529, 56531, 56532, 56533, 56534, 56535, 67000, 67001, 67002)
- Reports modified: 8
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 20
- `ApplicationArea` properties added: 11
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 20
- ToolTips added from control names: 0
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 31
- Remaining noncompliant request-page fields: 10
- Last processed report: 67002
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 26

- Reports inspected: 10 (67003, 67004, 67005, 67006, 67007, 67008, 67009, 67010, 67011, 67012)
- Reports modified: 2
- Reports with request pages: 7
- Reports without request pages: 3
- Request-page fields inspected: 3
- `ApplicationArea` properties added: 3
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 3
- ToolTips added from control names: 0
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 21
- Remaining noncompliant request-page fields: 7
- Last processed report: 67012
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 27

- Reports inspected: 10 (67013, 67014, 67015, 67016, 67017, 67018, 67019, 67020, 67021, 67022)
- Reports modified: 2
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 2
- `ApplicationArea` properties added: 2
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 0
- ToolTips added from control names: 2
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 11
- Remaining noncompliant request-page fields: 5
- Last processed report: 67022
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 28

- Reports inspected: 10 (67023, 67024, 67025, 67026, 67027, 67028, 67030, 67044, 70500, 75000)
- Reports modified: 3
- Reports with request pages: 10
- Reports without request pages: 0
- Request-page fields inspected: 5
- `ApplicationArea` properties added: 3
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 1
- ToolTips added from control names: 2
- Existing ToolTips normalized: 2
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 1
- Remaining noncompliant request-page fields: 0
- Last processed report: 75000
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 29

- Reports inspected: 1 (75001)
- Reports modified: 0
- Reports with request pages: 1
- Reports without request pages: 0
- Request-page fields inspected: 0
- `ApplicationArea` properties added: 0
- `ApplicationArea` properties normalized: 0
- ToolTips added from static Captions: 0
- ToolTips added from control names: 0
- Existing ToolTips normalized: 0
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Baseline compilation errors: 389
- Current compilation errors: 260
- New errors introduced: 0
- Remaining reports: 0
- Remaining noncompliant request-page fields: 0
- Last processed report: 75001
- Preservation verification: request-page source expressions and dataset blocks unchanged.

## Final verification

- Compilation batches completed: 29
- Report objects inspected: 281
- Reports modified: 106
- Reports containing request pages: 273
- Reports without request pages: 8
- Request pages without field controls: 167
- Request-page fields inspected: 314
- `ApplicationArea` properties added: 250
- `ApplicationArea` properties normalized to `All`: 22
- ToolTips added from static Captions: 201
- ToolTips added from control names: 57
- Existing ToolTips normalized: 55
- Dynamic-caption fields handled: 0
- Report extensions skipped: 0
- Other object types skipped: 0
- Final noncompliant request-page fields: 0
- Final duplicate `ApplicationArea` properties: 0
- Final duplicate ToolTip properties: 0
- Source-expression preservation failures: 0
- Dataset preservation failures: 0
- Baseline compilation errors: 389
- Final compilation errors: 260
- Errors under `src/reports`: 244
- New compilation errors introduced: 0
- Baseline warnings: 4,581
- Final warnings: 4,576
- Last processed report: 75001
- Stop condition: every report object was inspected, every request-page field is compliant, source expressions and datasets are unchanged, and the task introduced zero new compilation errors.
