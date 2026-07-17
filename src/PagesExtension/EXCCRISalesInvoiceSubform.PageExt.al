pageextension 50025 EXCCRISalesInvoiceSubform extends "Sales Invoice Subform"
{
    layout
    {
        modify("Unit Price")
        {
            Editable = EXCCRIUnitPriceEditable;
        }
    }

    trigger OnOpenPage()
    var
        EXCCRIUserConfiguration: Record 56000;
    begin
        EXCCRIUnitPriceEditable := false;
        if EXCCRIUserConfiguration.Get(UserId()) then
            EXCCRIUnitPriceEditable :=
                EXCCRIUserConfiguration."Allow to mod. Sales Price Docs";
    end;

    procedure SplitIC()
    var
        EXCCRISalesLine: Record "Sales Line";
    begin
        CurrPage.SetSelectionFilter(EXCCRISalesLine);
        //TODO: Ver 
        /*
        Report.Run(
            Report::"Split Sales Item Charge.",
            false,
            false,
            EXCCRISalesLine);*/
    end;

    var
        EXCCRIUnitPriceEditable: Boolean;
}
