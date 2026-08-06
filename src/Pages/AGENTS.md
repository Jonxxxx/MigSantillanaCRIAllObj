## Page part ApplicationArea normalization

### Scope

* Process only objects declared as `page` under `src/pages`.
* Process every control declared with:

```al
part(ControlName; PageReference)
{
}
```

* Do not process:

  * `pageextension` objects.
  * `systempart(...)`.
  * `usercontrol(...)`.
  * `field(...)`.
  * `group(...)`.
  * `repeater(...)`.
  * `action(...)`.
  * `actionref(...)`.
  * Reports, tables, codeunits, queries, XMLports, enums, interfaces, or permission sets.
* Do not modify files outside `src/pages`, except the progress Markdown file created by this task.

### Required ApplicationArea

Every `part(...)` control must contain exactly:

```al
ApplicationArea = All;
```

Rules:

* Add `ApplicationArea = All;` when it is missing.
* Replace another existing `ApplicationArea` value with `All`.
* Do not create duplicate `ApplicationArea` properties.
* When duplicate ApplicationArea properties already exist, retain one normalized property and remove only the duplicates.
* Place `ApplicationArea = All;` after the existing part properties and before the closing brace.
* Do not add ApplicationArea outside the `part(...)` block.

Example:

```al
part(PageLin; 55226)
{
    SubPageLink = "No." = FIELD("No.");
    SubPageView = SORTING("No.")
                  ORDER(Ascending);
    ApplicationArea = All;
}
```

Example:

```al
part(SalesLines; 46)
{
    SubPageLink = "Document No." = FIELD("No.");
    ApplicationArea = All;
}
```

Example:

```al
part(PageItemWare; 9109)
{
    Provider = SalesLines;
    SubPageLink = "No." = FIELD("No.");
    Visible = false;
    ApplicationArea = All;
}
```

### Existing part properties

Preserve all existing part properties and their values, including:

* `Caption`.
* `CaptionClass`.
* `SubPageLink`.
* `SubPageView`.
* `Provider`.
* `Visible`.
* `Enabled`.
* `Editable`.
* `UpdatePropagation`.
* `ApplicationArea`.
* `ObsoleteState`.
* `ObsoleteReason`.
* `ObsoleteTag`.

Do not change:

* The part control name.
* The referenced page object.
* Numeric page IDs.
* Symbolic page references.
* `SubPageLink` fields or filters.
* `SubPageView`.
* `Provider`.
* Visibility expressions.
* Editability.
* Update propagation.
* Page layout structure.
* Page SourceTable.
* PageType.
* Page actions.
* Page fields.
* Business logic.

The only authorized change is adding, replacing, or deduplicating the part-level `ApplicationArea` property.

### Page-reference handling

Preserve the second parameter of the part declaration exactly.

Examples that must retain their reference:

```al
part(SalesLines; 46)
```

```al
part(PageLin; 55226)
```

```al
part(CustomerDetails; Page::"Customer Details FactBox")
```

Do not:

* Convert numeric page IDs to symbolic names.
* Convert symbolic names to numeric IDs.
* Renumber referenced pages.
* Verify or replace unavailable page objects as part of this task.
* Change a `part` into a `systempart`, `usercontrol`, or another control type.

A missing or invalid referenced page does not prevent adding `ApplicationArea = All;`.

### Formatting

Use minimal formatting changes.

Preferred result:

```al
part(PagePartLinCupon; 55165)
{
    SubPageLink = "No. Cupon" = FIELD("No. Cupon");
    SubPageView = SORTING("No. Cupon", "Cod. Producto")
                  ORDER(Ascending);
    ApplicationArea = All;
}
```

Do not broadly reformat:

* Multiline `SubPageLink` properties.
* Multiline `SubPageView` properties.
* Sorting expressions.
* Filters.
* Existing indentation unrelated to the inserted property.
* Other controls in the same page.

### Compilation and diagnostics

* Record baseline diagnostics before modifying the first page.
* Pre-existing project compilation errors do not block this task.
* Process no more than 10 page objects per compilation batch.
* The 10-page limit applies per batch, not to the complete task.
* After each batch:

  1. Run `al_compile`.
  2. Compare diagnostics with the baseline and previous successful batch.
  3. Fix only errors introduced by the part normalization.
  4. Update the progress file.
  5. Continue automatically with the next batch.
* Do not wait for user confirmation between batches.
* Do not stop after one batch.
* Use scoped diagnostics for modified page files when available.
* A batch succeeds when it introduces no new compilation errors.
* Do not correct unrelated warnings or pre-existing errors.

### Progress tracking

Create or update:

```text
src/pages/TODO-Pages-Part-ApplicationArea-Progress.md
```

Record after every batch:

* Batch number.
* Pages inspected.
* Pages modified.
* Pages without parts.
* Part controls inspected.
* ApplicationArea properties added.
* Existing ApplicationArea properties normalized.
* Duplicate ApplicationArea properties removed.
* Numeric page references preserved.
* Symbolic page references preserved.
* System parts skipped.
* User controls skipped.
* Page extensions skipped.
* Baseline compilation errors.
* Current compilation errors.
* New errors introduced.
* Remaining pages.
* Remaining noncompliant parts.
* Last processed page.

### Completion condition

Stop only when:

* Every `page` object under `src/pages` has been inspected.
* Every `part(...)` control contains exactly one:

```al
ApplicationArea = All;
```

* No duplicate part-level ApplicationArea property remains.
* No `part(...)` reference, `SubPageLink`, `SubPageView`, `Provider`, visibility, editability, or page behavior was changed.
* No `systempart`, `usercontrol`, page extension, or other object type was modified.
* The task introduced no new compilation errors compared with the baseline.

The following are not valid stop reasons:

* Reaching 10 pages.
* Completing one batch.
* Finding a page without parts.
* Finding a numeric page reference.
* Finding a missing or invalid referenced page.
* Finding a part with Provider.
* Finding multiline SubPageLink or SubPageView properties.
* Finding existing compilation errors outside the current scope.
* More than one thousand page controls remain.

Continue automatically until every qualifying page part is compliant.