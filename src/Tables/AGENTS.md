## Tables

* Preserve table IDs, table names, captions, data classification, table type, data per company behavior, permissions, fields, keys, field groups, triggers, procedures, and existing business logic.
* Do not convert a table to a table extension or a table extension to a table.
* Do not renumber fields.
* Do not rename fields.
* Do not change field data types, lengths, decimal places, option members, enum types, field classes, or table relations.
* Do not modify primary keys, secondary keys, clustered keys, `SumIndexFields`, or key ordering.
* Do not modify field groups.
* Do not add, remove, or change table or field triggers.
* Do not change `InitValue`, `NotBlank`, `BlankZero`, `Editable`, `Enabled`, `MinValue`, `MaxValue`, `ValuesAllowed`, `TableRelation`, `CalcFormula`, `FieldClass`, `ObsoleteState`, `ObsoleteReason`, or `ObsoleteTag`.
* Do not replace option fields with enums unless explicitly requested.
* Preserve every existing field property and trigger exactly as implemented unless the current task explicitly targets that property.

## Field metadata normalization

For every field declared in a `table` object under `src/tables`, first inspect
the complete field block and determine its `FieldClass`.

### Normal fields

A field is considered Normal when:

* It has no `FieldClass` property, or
* It explicitly contains `FieldClass = Normal;`.

Every Normal field must contain exactly:

```al
DataClassification = CustomerContent;
Caption = '<Exact Field Name>';
```

Rules:

* Place `DataClassification` before `Caption`.
* Add `DataClassification = CustomerContent;` when missing.
* Replace another existing field-level `DataClassification` value with
  `CustomerContent`.
* Do not create duplicate properties.

### FlowFields and FlowFilters

A field is considered virtual when it contains either:

```al
FieldClass = FlowField;
```

or:

```al
FieldClass = FlowFilter;
```

For FlowFields and FlowFilters:

* Add or normalize the `Caption`.
* Do not add `DataClassification`.
* Remove `DataClassification` only when it was introduced by this metadata
  normalization task and causes compiler error AL0223.
* Preserve `FieldClass`, `CalcFormula`, filters, data type, and every other
  existing property unchanged.

Expected FlowField example:

```al
field(20; "Importe calculado"; Decimal)
{
    Caption = 'Importe calculado';
    FieldClass = FlowField;
    CalcFormula = Sum(...);
}
```

Expected FlowFilter example:

```al
field(21; "Filtro fecha"; Date)
{
    Caption = 'Filtro fecha';
    FieldClass = FlowFilter;
}
```

### Caption rules

Every declared field, including Normal fields, FlowFields, and FlowFilters,
must have:

```al
Caption = '<Exact Field Name>';
```

The Caption must be the exact AL field identifier without surrounding double
quotes.

* Preserve capitalization.
* Preserve spaces.
* Preserve accents.
* Preserve punctuation.
* Preserve abbreviations.
* Preserve spelling mistakes.
* Do not translate, improve, normalize, or reinterpret the field name.
* Escape apostrophes by doubling them inside the AL string.
* Preserve an existing `Comment` property unchanged.
* Do not create duplicate Caption properties.

### Existing properties and logic

Preserve unchanged:

* Field number.
* Field name.
* Data type and length.
* FieldClass.
* CalcFormula.
* TableRelation.
* OptionMembers and OptionCaption.
* Enum type.
* DecimalPlaces.
* InitValue.
* MinValue and MaxValue.
* NotBlank and BlankZero.
* Editable and Enabled.
* ValuesAllowed.
* Obsolete properties.
* Field triggers.
* Existing comments.
* Existing business logic.

The only authorized changes are:

* Add or normalize `DataClassification = CustomerContent;` on Normal fields.
* Add or normalize an exact-name `Caption` on every declared field.

## Compilation and diagnostics

* Record the complete baseline compilation diagnostics before modifying the
  first remaining table.
* Pre-existing compilation errors outside `src/tables` do not block this task.
* Run `al_compile` after every batch.
* Compare each compilation result with the baseline and the previous successful
  batch.
* The batch is successful when it introduces no new compilation errors.
* Use `al_getdiagnostics` filtered to `src/tables` or the modified files when
  available.
* Fix only errors introduced by the current table metadata changes.
* Do not modify objects outside `src/tables` to fix pre-existing project errors.
* Do not require the complete workspace to have zero errors when those errors
  existed before this task.
* Continue automatically after a batch that introduces no new errors.

## Continuous table processing

* Process no more than 10 table objects per compilation batch.
* The 10-table limit applies per batch, not to the complete task.
* Continue automatically after every successful batch.
* Do not stop because a FlowField or FlowFilter cannot have
  `DataClassification`.
* Do not stop because the project contains pre-existing errors outside
  `src/tables`.
* Stop only after every `table` object under `src/tables` has been processed
  using the compiler-compatible Normal, FlowField, and FlowFilter rules.


## Object scope

* Process only AL objects whose declaration begins with `table`.
* Do not process `tableextension`, `page`, `pageextension`, `report`, `codeunit`, `query`, `xmlport`, `enum`, `interface`, or permission-set objects.
* When a file contains something other than a `table` object, leave it unchanged and record it in the progress report.

## Compilation batches

* Process no more than 10 table objects per compilation batch.
* The 10-object limit applies per batch, not to the complete task.
* After every successful compilation batch, continue automatically with the next batch.
* Do not wait for user confirmation between batches.
* Do not stop after completing one batch.
* Stop only after every field in every `table` object under `src/tables` has the required `DataClassification` and `Caption`.
* Run `al_compile` after every batch.
* Fix only compilation errors introduced by the current batch.
* Do not correct unrelated warnings.
* Do not build, publish, commit, push, or create a pull request.

## Valid completion condition

Stop only when all these conditions are satisfied:

* Every `table` object under `src/tables` has been inspected.
* Every Normal field contains exactly one
  `DataClassification = CustomerContent;`.
* No FlowField or FlowFilter contains a `DataClassification` added by this
  task.
* Every declared field has exactly one Caption matching its exact AL field
  identifier.
* No duplicate Caption or DataClassification property exists.
* No tableextension or other object type has been modified.
* The task introduces no new compilation errors compared with the recorded
  baseline.

Pre-existing compilation errors outside the task scope do not prevent
successful completion.

