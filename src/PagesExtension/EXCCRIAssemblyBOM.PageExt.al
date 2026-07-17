pageextension 50015 EXCCRIAssemblyBOM extends "Assembly BOM"
{
    trigger OnOpenPage()
    var
        EXCCRIItem: Record Item;
        EXCCRIEditable: Boolean;
        EXCCRIMdMFunctions: Codeunit 75000;
    begin
        if EXCCRIItem.Get(Rec."Parent Item No.") then
            EXCCRIEditable := EXCCRIMdMFunctions.GetEditableP(EXCCRIItem, false)
        else
            EXCCRIEditable := EXCCRIMdMFunctions.GetEditable();

        if not EXCCRIEditable then
            CurrPage.Editable(false);
    end;
}
