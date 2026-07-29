## Reports

* Preserve report IDs, report names, captions, report types, dataset structure, dataitems, columns, request-page structure, rendering layouts, triggers, procedures, variables, permissions, and existing business logic.
* Do not convert reports to report extensions.
* Do not modify report extensions as part of this task.
* Do not rename request-page controls or their source expressions.
* Do not modify dataset fields, filters, dataitem links, sorting, request filters, calculations, report layouts, Word layouts, RDLC layouts, Excel layouts, or processing logic.
* Do not perform unrelated formatting or refactoring.

## Request-page field normalization

For every `field(ControlName; SourceExpression)` declared inside:

```al
requestpage
{
    layout
    {
        ...
    }
}
```

ensure the field contains exactly:

```al
ApplicationArea = All;
ToolTip = '<Resolved tooltip>';
```

Only process field controls inside the report request-page layout.

Do not process:

* Dataset columns.
* Dataitem fields.
* Request-page actions.
* Groups.
* Areas.
* Labels.
* Fixed controls.
* User controls.
* Report layouts.
* Report extensions.

## ApplicationArea

Every request-page field control must contain exactly:

```al
ApplicationArea = All;
```

Rules:

* Add it when missing.
* Replace any existing `ApplicationArea` value with `All`.
* Do not create duplicate `ApplicationArea` properties.
* Do not add `ApplicationArea` to request-page groups, areas, labels, actions, or other controls during this task.

## ToolTip resolution

Every request-page field control must contain exactly one `ToolTip`.

Determine its value using this priority:

1. When the field contains a static string `Caption`, use the exact Caption text.
2. When no static Caption exists, use the exact request-page control name.
3. Do not derive the ToolTip from the source expression when the control name is available.

Example with Caption:

```al
field(NoOfCopies; NoOfCopies)
{
    ApplicationArea = All;
    Caption = 'No. of Copies';
    ToolTip = 'No. of Copies';
}
```

Example without Caption:

```al
field(PostingDate; PostingDate)
{
    ApplicationArea = All;
    ToolTip = 'PostingDate';
}
```

Example with a quoted control name:

```al
field("Posting Date"; PostingDate)
{
    ApplicationArea = All;
    ToolTip = 'Posting Date';
}
```

## Static Caption handling

A static Caption includes:

```al
Caption = 'No. of Copies';
```

or:

```al
Caption = 'No. of Copies', Comment = 'ESP=No. de copias';
```

For these cases:

* Copy the exact Caption text into the ToolTip.
* Preserve capitalization.
* Preserve spaces.
* Preserve accents.
* Preserve punctuation.
* Preserve abbreviations.
* Preserve spelling mistakes.
* Do not translate, improve, normalize, or reinterpret the Caption.
* Preserve the existing Caption property unchanged.
* Preserve the Caption `Comment` property unchanged.
* Escape apostrophes correctly inside the ToolTip string.

Example:

```al
Caption = 'Employee''s Code';
```

must use:

```al
ToolTip = 'Employee''s Code';
```

## Fields without a static Caption

When a field has no Caption property, derive the ToolTip from the request-page control name.

Rules:

* Remove surrounding double quotes from a quoted control name.
* Preserve the exact identifier text.
* Preserve spelling, capitalization, spaces, accents, punctuation, and abbreviations.
* Escape apostrophes by doubling them in the AL string.
* Do not add a Caption property as part of this task.

Example:

```al
field("Fecha hasta"; EndDate)
{
}
```

must become:

```al
field("Fecha hasta"; EndDate)
{
    ApplicationArea = All;
    ToolTip = 'Fecha hasta';
}
```

## Dynamic captions and CaptionClass

When a field uses a dynamic caption, label variable, expression, or `CaptionClass` and no static Caption string can be copied safely:

* Preserve the dynamic caption or CaptionClass unchanged.
* Use the exact request-page control name as the ToolTip.
* Do not attempt to evaluate the dynamic caption.
* Do not invent a translated or expanded ToolTip.

Example:

```al
field(DateFilter; DateFilter)
{
    CaptionClass = DateCaptionClass;
}
```

must become:

```al
field(DateFilter; DateFilter)
{
    ApplicationArea = All;
    ToolTip = 'DateFilter';
    CaptionClass = DateCaptionClass;
}
```

## Existing ToolTips

When a ToolTip already exists:

* Replace its text with the resolved ToolTip value.
* Preserve an existing ToolTip `Comment` property unchanged.
* Do not create a second ToolTip property.

Example:

```al
ToolTip = 'Old text', Comment = 'ESP=No. de copias';
```

with:

```al
Caption = 'No. of Copies';
```

must become:

```al
ToolTip = 'No. of Copies', Comment = 'ESP=No. de copias';
```

## Source expressions

Preserve every request-page field source expression unchanged.

Do not add `Rec.`.

Do not change:

* Variables.
* Dataitem fields.
* Filter variables.
* Boolean variables.
* Integer variables.
* Date variables.
* Enum variables.
* Option variables.
* Expressions.
* Procedure calls.
* Record fields.
* Temporary-record fields.

Examples that must preserve their source expression:

```al
field(NoOfCopies; NoOfCopies)
```

```al
field(ShowInternalInfo; ShowInternalInfo)
```

```al
field("Posting Date"; PostingDate)
```

```al
field(CustomerFilter; Customer."No.")
```

```al
field(DisplayValue; Format(SomeValue))
```

Do not convert any of them to `Rec.<Field>`.

## Existing properties and triggers

Preserve all existing request-page field properties and triggers, including:

* Caption.
* CaptionClass.
* Comment.
* Editable.
* Enabled.
* Visible.
* ShowMandatory.
* Importance.
* QuickEntry.
* BlankZero.
* DecimalPlaces.
* MultiLine.
* ExtendedDatatype.
* OptionCaption.
* ValuesAllowed.
* MinValue.
* MaxValue.
* TableRelation.
* Obsolete properties.
* `OnValidate`.
* `OnLookup`.
* `OnAssistEdit`.
* `OnDrillDown`.

The only authorized changes are:

* Add or normalize `ApplicationArea = All;`.
* Add or normalize the request-page field ToolTip.

Do not reorder unrelated existing properties.

Preferred order:

```al
ApplicationArea = All;
Caption = '<Existing caption>';
ToolTip = '<Resolved tooltip>';
```

When the Caption already appears before ApplicationArea, minimal movement is preferred over broad reformatting.

## Object scope

* Process only objects declared as `report` under `src/reports`.
* Do not modify:

  * `reportextension`.
  * `page`.
  * `pageextension`.
  * `table`.
  * `tableextension`.
  * `codeunit`.
  * `query`.
  * `xmlport`.
  * `enum`.
  * `interface`.
* Leave other object types unchanged and record them as skipped.

## Compilation and diagnostics

* Record baseline compilation diagnostics before modifying the first report.
* Pre-existing compilation errors outside the modified reports do not block this task.
* Process no more than 10 report objects per compilation batch.
* The 10-report limit applies per batch, not to the complete task.
* After every successful batch, continue automatically with the next batch.
* Do not wait for user confirmation.
* Run `al_compile` after every batch.
* Use scoped diagnostics for modified report files when available.
* A batch is successful when it introduces no new compilation errors.
* Fix only errors introduced by the current request-page metadata changes.
* Do not correct unrelated warnings or errors.
* Do not build, publish, commit, push, or create a pull request.

## Completion condition

Stop only when:

* Every `report` object under `src/reports` has been inspected.
* Every request-page field has exactly one `ApplicationArea = All;`.
* Every request-page field has exactly one resolved ToolTip.
* Every static Caption-based ToolTip exactly matches its Caption.
* Every field without a static Caption uses its exact control name as ToolTip.
* No field source expression was changed.
* No duplicate ApplicationArea or ToolTip property exists.
* No report extension or other object type was modified.
* The task introduces no new compilation errors compared with the baseline.
