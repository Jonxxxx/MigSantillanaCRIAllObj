pageextension 50041 EXCCRIPostedSalesInvSubform extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRISharingCode; Rec.Compartir)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the sharing classification assigned to the posted sales invoice line.';
            }
            field(EXCCRILocationCode; Rec."Location Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the location code associated with the posted sales invoice line.';
            }
            field(EXCRIDiscountType; Rec."Tipo Descuento FE")
            {
                ApplicationArea = All;
                DrillDown = true;
                DrillDownPageId = "Tipo Descuentos FE";
                Editable = false;
                Lookup = true;
                LookupPageId = "Tipo Descuentos FE";
                ToolTip = 'Specifies the electronic invoicing discount type assigned to the posted sales invoice line.';
            }
            field(EXCCRIGenBusPostingGroup; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the general business posting group assigned to the posted sales invoice line.';
            }
            field(EXCCRIGenProdPostingGroup; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the general product posting group assigned to the posted sales invoice line.';
            }
            field(EXCCRILineNo; Rec."Line No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the line number of the posted sales invoice line.';
            }
        }
    }
}
