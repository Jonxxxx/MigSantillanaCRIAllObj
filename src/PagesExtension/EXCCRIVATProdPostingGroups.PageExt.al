pageextension 50077 EXCCRIVATProdPostingGroups extends "VAT Product Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIItemServiceType; Rec."Tipo de bien-servicio")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the VAT product posting group represents a good or a service.';
            }
            field(EXCCRIITBIS; Rec."_ ITBIS")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ITBIS percentage associated with the VAT product posting group.';
            }
            field(EXCCRIFECategoryCode; Rec."Codigo Tarifa FE")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the electronic invoicing tax rate code associated with the VAT product posting group.';
            }
        }
    }
}
