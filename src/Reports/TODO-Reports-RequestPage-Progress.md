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

- Reports inspected: 10 (55742 through 55751)
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
- Last processed report: 55751
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 2

- Reports inspected: 10 (55752, 55753, 55754, 55755, 55756, 55757, 55758, 55759, 55760, 55761)
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
- Last processed report: 55761
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 3

- Reports inspected: 10 (55762, 55763, 55764, 55765, 55766, 55767, 55768, 55769, 55770, 55771)
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
- Last processed report: 55771
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 4

- Reports inspected: 10 (55772, 55773, 55774, 55775, 55776, 55777, 55778, 55779, 55780, 55781)
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
- Last processed report: 55781
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 5

- Reports inspected: 10 (55782, 55783, 55784, 55785, 55786, 55787, 55788, 55789, 55790, 55791)
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
- Last processed report: 55791
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 6

- Reports inspected: 10 (55792, 55793, 55794, 55795, 55796, 55797, 55798, 55799, 55800, 55801)
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
- Last processed report: 55801
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 7

- Reports inspected: 10 (55802, 55803, 55804, 55805, 55806, 55807, 55808, 55809, 55810, 55811)
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
- Last processed report: 55811
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 8

- Reports inspected: 10 (55821, 55822, 55823, 55824, 55896, 55897, 55898, 55899, 55900, 55901)
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
- Last processed report: 55901
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 9

- Reports inspected: 10 (55902, 55903, 55904, 55905, 55906, 55907, 55908, 55909, 55910, 55911)
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
- Last processed report: 55911
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 10

- Reports inspected: 10 (55912, 55913, 55915, 55916, 55924, 55925, 34003000, 34003001, 34003002, 34003003)
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

- Reports inspected: 10 (34003015, 34003016, 55000, 55001, 55002, 55003, 55004, 55006, 55007, 55016)
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
- Last processed report: 55016
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 13

- Reports inspected: 10 (55045, 55047, 55048, 55167, 55168, 55170, 55180, 55199, 55200, 55201)
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
- Last processed report: 55201
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 14

- Reports inspected: 10 (55212, 55202, 55203, 55213, 55214, 55215, 55216, 55217, 55218, 55219)
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
- Last processed report: 55219
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 15

- Reports inspected: 10 (55224, 55020, 55225, 55226, 55227, 55229, 55231, 55232, 55233, 55235)
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
- Last processed report: 55235
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 16

- Reports inspected: 10 (55237, 55239, 55242, 55243, 55244, 55246, 55248, 55249, 55250, 55251)
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
- Last processed report: 55251
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 17

- Reports inspected: 10 (55252, 55254, 55255, 55256, 55257, 55258, 55259, 55260, 55261, 55262)
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
- Last processed report: 55262
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 18

- Reports inspected: 10 (55263, 55264, 55265, 55266, 55271, 55277, 55293, 55294, 55295, 55296)
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
- Last processed report: 55296
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 19

- Reports inspected: 10 (55297, 55298, 55299, 55300, 55301, 55302, 55303, 55304, 55305, 55306)
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
- Last processed report: 55306
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 20

- Reports inspected: 10 (55307, 55308, 55309, 55310, 55311, 55312, 55313, 55314, 55315, 55316)
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
- Last processed report: 55316
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 21

- Reports inspected: 10 (55317, 55318, 55319, 55320, 55321, 55323, 55324, 55325, 55326, 55327)
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
- Last processed report: 55327
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 22

- Reports inspected: 10 (55328, 55329, 55330, 55331, 55332, 55333, 55334, 55335, 55336, 55337)
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
- Last processed report: 55337
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 23

- Reports inspected: 10 (55338, 55339, 55340, 55341, 55342, 55343, 55344, 55345, 55346, 55347)
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
- Last processed report: 55347
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 24

- Reports inspected: 10 (55348, 55349, 55350, 55351, 55352, 55353, 55423, 55424, 55425, 55426)
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
- Last processed report: 55426
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 25

- Reports inspected: 10 (55427, 55428, 55429, 55430, 55431, 55432, 55433, 55467, 55468, 55469)
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
- Last processed report: 55469
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 26

- Reports inspected: 10 (55470, 55471, 55472, 55473, 55474, 55475, 55476, 55477, 55478, 55479)
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
- Last processed report: 55479
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 27

- Reports inspected: 10 (55480, 55481, 55482, 55483, 55484, 55485, 55486, 55487, 55488, 55489)
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
- Last processed report: 55489
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 28

- Reports inspected: 10 (55490, 55491, 55492, 55493, 55494, 55495, 55497, 55511, 55665, 55681)
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
- Last processed report: 55681
- Preservation verification: request-page source expressions and dataset blocks unchanged.

### Batch 29

- Reports inspected: 1 (55682)
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
- Last processed report: 55682
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
- Last processed report: 55682
- Stop condition: every report object was inspected, every request-page field is compliant, source expressions and datasets are unchanged, and the task introduced zero new compilation errors.
