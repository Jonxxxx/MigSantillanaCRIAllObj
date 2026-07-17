pageextension 50151 EXCCRISalesInvoiceList extends "Sales Invoice List"
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
