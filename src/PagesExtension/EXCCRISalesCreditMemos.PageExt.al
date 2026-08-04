pageextension 55151 EXCCRISalesCreditMemos extends "Sales Credit Memos"
{
    trigger OnOpenPage()
    var
        EXCCRIOldFilterGroup: Integer;
    begin
        EXCCRIOldFilterGroup := Rec.FilterGroup();
        Rec.FilterGroup(2);
        Rec.SetRange("Venta TPV", false);
        Rec.FilterGroup(EXCCRIOldFilterGroup);
    end;
}
