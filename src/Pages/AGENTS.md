## Page field control normalization

* Preserve page IDs, page names, page types, source tables, captions, layouts, actions, parts, triggers, procedures, variables, visibility, editability, permissions, and existing business logic.
* Do not convert pages to page extensions.
* Do not modify page extensions as part of this task.
* Do not rename controls or source-table fields.
* Do not modify field data types, table fields, table relations, filters, validations, calculations, actions, or page behavior.
* Do not perform unrelated formatting or refactoring.

### Direct SourceTable fields

For every `field(ControlName; SourceExpression)` control in a `page` object under `src/pages`, determine whether `SourceExpression` is a direct field of the page `SourceTable`.

When the source expression is a direct field of `Rec`, normalize it to:

```al
field("<Field Name>"; Rec."<Field Name>")
{
    ApplicationArea = All;
    ToolTip = '<Field Name>';
}
```

Example:

```al
field("Object Type"; "Object Type")
{
}
```

must become:

```al
field("Object Type"; Rec."Object Type")
{
    ApplicationArea = All;
    ToolTip = 'Object Type';
}
```

Example with an unquoted field identifier:

```al
field(Code; Code)
{
}
```

must become:

```al
field(Code; Rec.Code)
{
    ApplicationArea = All;
    ToolTip = 'Code';
}
```

### Rec qualification

* Add the `Rec.` qualifier only when the source expression is a direct field of the page `SourceTable`.
* Use `Rec."<Field Name>"` for quoted field identifiers.
* Use `Rec.FieldName` for valid unquoted field identifiers.
* Do not add a second qualifier when the source expression already begins with `Rec.`.
* Do not change an existing correct `Rec.` qualification.
* Do not qualify a field with `Rec.` solely because the control name matches the source expression.
* Verify the field against the page `SourceTable` or available AL symbols before changing it.

Do not add `Rec.` to:

* Variables.
* Procedure calls.
* Expressions.
* `Format(...)`.
* `StrSubstNo(...)`.
* Boolean expressions.
* Totals or calculated controls.
* Fields belonging to another record variable.
* Temporary records other than the page `Rec`.
* `xRec`.
* Enum expressions.
* Option expressions.
* Control add-ins.
* Parts.
* Groups.
* Labels.
* User controls.

Examples that must remain unchanged:

```al
field(TotalAmount; TotalAmount)
{
}
```

when `TotalAmount` is a page variable and not a SourceTable field.

```al
field(DisplayText; Format(Rec.Amount))
{
}
```

```al
field(CustomerName; Customer.Name)
{
}
```

```al
field(IsEditable; CanEditRecord)
{
}
```

### ApplicationArea

* Every page field control must contain exactly one:

```al
ApplicationArea = All;
```

* Add it when missing.
* Replace another existing `ApplicationArea` value with `All`.
* Do not create duplicate `ApplicationArea` properties.
* Apply this rule to:

  * Direct SourceTable fields.
  * Variable-backed fields.
  * Expression-backed fields.
  * FlowFields displayed on pages.
  * FlowFilters displayed on pages.
* Do not add `ApplicationArea` to groups, repeaters, areas, parts, labels, or user controls unless explicitly requested by another task.

### ToolTip

For direct SourceTable fields:

* Every field control must contain exactly one English `ToolTip`.
* The ToolTip must be the exact source-table field identifier without:

  * The `Rec.` prefix.
  * Surrounding double quotes.
* Preserve capitalization, spaces, accents, punctuation, abbreviations, and spelling exactly as defined by the field identifier.
* Do not translate, improve, reinterpret, or correct the field name.
* Escape apostrophes inside the AL string by doubling them.
* Replace an existing ToolTip value with the exact field name.
* Preserve an existing ToolTip `Comment` property unchanged.
* Do not create duplicate ToolTip properties.

Examples:

```al
field("Read Permission"; Rec."Read Permission")
{
    ApplicationArea = All;
    ToolTip = 'Read Permission';
}
```

```al
field("Cod. empleado"; Rec."Cod. empleado")
{
    ApplicationArea = All;
    ToolTip = 'Cod. empleado';
}
```

```al
field("Employee's Code"; Rec."Employee's Code")
{
    ApplicationArea = All;
    ToolTip = 'Employee''s Code';
}
```

For variable-backed or expression-backed fields:

* Add `ApplicationArea = All;`.
* Preserve an existing ToolTip unchanged.
* Do not invent a ToolTip from the control name when the functional purpose cannot be inferred safely.
* Add a ToolTip only when the source expression or surrounding logic makes its purpose unambiguous.

### Existing field properties and triggers

Preserve all existing properties and triggers, including:

* Caption.
* CaptionClass.
* Comment.
* Editable.
* Enabled.
* Visible.
* Style.
* StyleExpr.
* BlankZero.
* DecimalPlaces.
* ShowMandatory.
* Importance.
* QuickEntry.
* AssistEdit.
* DrillDown.
* Lookup.
* MultiLine.
* ExtendedDatatype.
* AutoFormatType.
* AutoFormatExpression.
* ValuesAllowed.
* Obsolete properties.
* `OnValidate`.
* `OnLookup`.
* `OnDrillDown`.
* `OnAssistEdit`.
* `OnControlAddIn`.

The only authorized changes are:

* Qualifying direct SourceTable field expressions with `Rec.`.
* Adding or normalizing `ApplicationArea = All;`.
* Adding or normalizing exact-field-name ToolTips for direct SourceTable fields.

### Object scope

* Process only objects declared as `page` under `src/pages`.
* Do not modify:

  * `pageextension`.
  * `table`.
  * `tableextension`.
  * `report`.
  * `codeunit`.
  * `query`.
  * `xmlport`.
  * `enum`.
  * `interface`.
* Leave files containing other object types unchanged and record them as skipped.

### Compilation batches

* Process no more than 10 page objects per compilation batch.
* The 10-page limit applies per batch, not to the complete task.
* After every successful batch, continue automatically with the next batch.
* Do not wait for user confirmation.
* Do not stop after one batch.
* Record the baseline compilation diagnostics before the first modification.
* Pre-existing errors outside the modified pages do not block this task.
* A batch is successful when it introduces no new compilation errors.
* Run `al_compile` after every batch.
* Use scoped diagnostics for the changed page files when available.
* Fix only errors introduced by the current task.
* Do not correct unrelated warnings.
* Do not build, publish, commit, push, or create a pull request.

### Completion condition

Stop only when:

* Every `page` object under `src/pages` has been inspected.
* Every page field control contains exactly one `ApplicationArea = All;`.
* Every direct SourceTable field expression is correctly qualified with `Rec.`.
* Every direct SourceTable field has exactly one ToolTip matching the exact field identifier.
* No variable or expression was incorrectly qualified with `Rec.`.
* No duplicate ApplicationArea or ToolTip properties exist.
* No page extension or other object type was modified.
* The task introduces no new compilation errors compared with the baseline.
