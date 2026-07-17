pageextension 50076 EXCCRIVATBusPostingGroups extends "VAT Business Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIExportCustomer; Rec."Cliente de Exportacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the VAT business posting group is used for export customers.';
            }
        }
    }
}
