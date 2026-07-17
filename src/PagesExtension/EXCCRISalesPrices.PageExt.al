pageextension 50138 EXCCRISalesPrices extends "Sales Prices"
{
    trigger OnOpenPage()
    var
        EXCCRIItem: Record Item;
    begin
        if EXCCRIItem.Get(Rec."Item No.") then
            EXCCRIEditable :=
                EXCCRIMdMFunctions.GetEditableP(EXCCRIItem, true)
        else
            EXCCRIEditable := EXCCRIMdMFunctions.GetEditable();

        CurrPage.Editable(EXCCRIEditable);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EXCCRIValidateEditable();
        exit(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        EXCCRIValidateEditable();
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        EXCCRIValidateEditable();
        exit(true);
    end;

    local procedure EXCCRIValidateEditable()
    begin
        if not EXCCRIEditable then
            EXCCRIMdMFunctions.SetEditableError(Rec.TableCaption());
    end;

    var
        EXCCRIMdMFunctions: Codeunit 75000;
        EXCCRIEditable: Boolean;
}
