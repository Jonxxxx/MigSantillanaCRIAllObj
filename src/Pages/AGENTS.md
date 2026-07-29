## Pages

* Preserve page IDs, page names, page types, source tables, source-table temporary behavior, captions, layouts, actions, parts, triggers, procedures, variables, permissions, visibility, editability, and existing business logic.
* Do not convert pages to page extensions.
* Do not modify page extensions unless explicitly requested.
* Do not rename controls, fields, groups, actions, or variables.
* Do not modify page IDs, object names, `PageType`, `SourceTable`, `SourceTableTemporary`, `UsageCategory`, `CardPageId`, `Editable`, `InsertAllowed`, `ModifyAllowed`, or `DeleteAllowed`.
* Do not perform unrelated formatting or refactoring.
* Preserve all existing comments and version markers unless they are duplicates created by the current task.
* All new code comments must be written in English.

## Page action normalization

Process every control declared as:

```al
action(ActionName)
{
}
```

inside the `actions` section of a `page` object under `src/pages`.

Do not process:

* `actionref(...)`.
* Action groups.
* Action areas.
* Separators.
* Fields.
* Parts.
* User controls.
* `pageextension` objects.
* Actions outside a `page` object.

Every page action must contain exactly:

```al
ApplicationArea = All;
Caption = '<Resolved action text>';
ToolTip = '<Resolved action text>';
```

The Caption and ToolTip must contain the same resolved text.

## Action text resolution

Determine the action text using this exact priority:

### 1. Existing static Caption

When the action already has a static Caption:

```al
Caption = 'Create Invoice';
```

use that exact text for both Caption and ToolTip:

```al
ApplicationArea = All;
Caption = 'Create Invoice';
ToolTip = 'Create Invoice';
```

Preserve the existing Caption unchanged.

Replace an existing different ToolTip with the Caption text.

### 2. Existing static ToolTip and no Caption

When the action does not have a Caption but has a static ToolTip:

```al
ToolTip = '&Gift';
```

use the exact ToolTip text as the new Caption and preserve it as ToolTip:

```al
ApplicationArea = All;
Caption = '&Gift';
ToolTip = '&Gift';
```

Do not remove ampersands, punctuation, capitalization, accents, abbreviations,
or spelling mistakes.

### 3. No Caption and no ToolTip

When the action has neither Caption nor ToolTip, derive both values from the
exact action identifier.

Example:

```al
action(PrintDocument)
{
}
```

must become:

```al
action(PrintDocument)
{
    ApplicationArea = All;
    Caption = 'PrintDocument';
    ToolTip = 'PrintDocument';
}
```

Example with a quoted action identifier:

```al
action("Print Document")
{
}
```

must become:

```al
action("Print Document")
{
    ApplicationArea = All;
    Caption = 'Print Document';
    ToolTip = 'Print Document';
}
```

Remove only the surrounding double quotes from the identifier.

Do not split PascalCase identifiers into words.

For example:

```al
action(CreateSalesInvoice)
```

must use:

```al
Caption = 'CreateSalesInvoice';
ToolTip = 'CreateSalesInvoice';
```

Do not change it to `Create Sales Invoice`.

## Exact-text preservation

When deriving or copying Caption and ToolTip text:

* Preserve exact capitalization.
* Preserve spaces.
* Preserve accents.
* Preserve punctuation.
* Preserve ampersands.
* Preserve abbreviations.
* Preserve spelling mistakes.
* Do not translate.
* Do not improve or reinterpret the text.
* Escape apostrophes by doubling them inside AL string literals.

Example:

```al
ToolTip = 'Customer''s Documents';
```

must produce:

```al
Caption = 'Customer''s Documents';
ToolTip = 'Customer''s Documents';
```

## Caption and ToolTip comments

Preserve existing `Comment` properties.

Example:

```al
Caption = 'Create Invoice', Comment = 'ESP=Crear factura';
```

must remain unchanged.

The ToolTip must become:

```al
ToolTip = 'Create Invoice';
```

Do not automatically copy the Caption Comment to a newly created ToolTip.

When an existing ToolTip has a Comment:

```al
ToolTip = 'Old tooltip', Comment = 'ESP=Crear factura';
```

and the resolved action text is `Create Invoice`, normalize it to:

```al
ToolTip = 'Create Invoice', Comment = 'ESP=Crear factura';
```

Preserve the existing ToolTip Comment unchanged.

## ApplicationArea

Every page action must contain exactly:

```al
ApplicationArea = All;
```

Rules:

* Add it when missing.
* Replace another existing `ApplicationArea` value with `All`.
* Do not create duplicate `ApplicationArea` properties.
* Do not add `ApplicationArea` to action groups, action areas, separators, or `actionref` controls during this task.

## Existing action properties

Preserve every existing action property, including:

* `Image`.
* `Promoted`.
* `PromotedCategory`.
* `PromotedIsBig`.
* `PromotedOnly`.
* `Visible`.
* `Enabled`.
* `InFooterBar`.
* `Ellipsis`.
* `Gesture`.
* `ShortcutKey`.
* `RunObject`.
* `RunPageLink`.
* `RunPageView`.
* `RunPageMode`.
* `RunObject`.
* `RunPageOnRec`.
* `Scope`.
* `AboutTitle`.
* `AboutText`.
* `ObsoleteState`.
* `ObsoleteReason`.
* `ObsoleteTag`.

Do not change existing property values.

Do not change:

* `OnAction`.
* `OnBeforeAction`.
* Procedure calls.
* Record filters.
* `RunObject` targets.
* `RunPageLink` filters.
* `RunPageView`.
* `CurrPage` calls.
* Confirmations.
* Error handling.
* Posting logic.
* External integrations.
* Transaction behavior.

The only authorized action changes are:

1. Add or normalize `ApplicationArea = All;`.
2. Add or normalize Caption using the action-text resolution rules.
3. Add or normalize ToolTip using the same resolved action text.

## Property order

Use this preferred order for the targeted properties:

```al
ApplicationArea = All;
Caption = '<Resolved action text>';
ToolTip = '<Resolved action text>';
```

Place these properties before other existing action properties when possible.

Example:

```al
action(Atenciones)
{
    ApplicationArea = All;
    Caption = '&Gift';
    ToolTip = '&Gift';
    Image = CreateWarehousePick;
    Promoted = true;
    PromotedCategory = Category5;
    RunObject = Page 67165;
    RunPageLink = "Cod. Colegio" = FIELD("No.");
}
```

Do not reorder unrelated properties relative to each other.

## Dynamic or non-static text

When Caption or ToolTip does not contain a static AL string literal:

* Preserve the existing dynamic property unchanged.
* Do not attempt to evaluate a Label variable, expression, or `CaptionClass`.
* Use the static Caption when one exists.
* Otherwise use the static ToolTip when one exists.
* When neither static value exists, derive the missing property from the exact action identifier.
* Do not replace a dynamic Caption solely to make Caption and ToolTip textually equal.
* Record the action in the progress file as requiring preserved dynamic text.

Dynamic text must not stop processing of later actions or pages.

## Duplicate properties

For every action:

* Ensure exactly one `ApplicationArea`.
* Ensure at most one `Caption`.
* Ensure at most one `ToolTip`.
* Remove only duplicates created by migration or normalization.
* Preserve the property that follows the resolved action-text rule.
* Do not remove unrelated properties.

## Object scope

* Process only AL objects declared as `page` under `src/pages`.
* Do not modify:

  * `pageextension`.
  * `report`.
  * `reportextension`.
  * `table`.
  * `tableextension`.
  * `codeunit`.
  * `query`.
  * `xmlport`.
  * `enum`.
  * `interface`.
* Leave files containing other object types unchanged and record them as skipped.

## Compilation and diagnostics

* Record baseline compilation diagnostics before modifying the first page.
* Pre-existing compilation errors do not block this task.
* Process no more than 10 page objects per compilation batch.
* The 10-page limit applies per batch, not to the complete task.
* After each batch, run `al_compile`.
* Compare diagnostics with the baseline and the previous successful batch.
* Use scoped diagnostics for modified page files when available.
* A batch is successful when it introduces no new compilation errors.
* Fix only errors introduced by the current action normalization.
* Do not modify objects outside `src/pages` to fix pre-existing errors.
* Do not correct unrelated warnings.
* Continue automatically after every successful batch.
* Do not wait for user confirmation.
* Do not stop after one batch.

## Completion condition

Stop only when:

* Every `page` object under `src/pages` has been inspected.
* Every `action(...)` has exactly one `ApplicationArea = All;`.
* Every action has a Caption resolved according to these rules.
* Every action has a ToolTip resolved according to these rules.
* Every static Caption and ToolTip contains the same resolved text.
* No duplicate targeted properties exist.
* No `actionref`, action group, action area, or page extension was modified.
* No action behavior or business logic was changed.
* The task introduced no new compilation errors compared with the baseline.
