pageextension 50043 EXCCRIPostedSalesCrMemoSubf extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIVATPercentage; Rec."VAT %")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the VAT percentage applied to the posted sales credit memo line.';
            }
            field(EXCCRIVATBaseAmount; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the VAT base amount of the posted sales credit memo line.';
            }
            field(EXCCRIVATIdentifier; Rec."VAT Identifier")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the VAT identifier assigned to the posted sales credit memo line.';
            }
            field(EXCCRIVATDifference; Rec."VAT Difference")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the VAT difference recorded on the posted sales credit memo line.';
            }
            field(EXCCRILocationCode; Rec."Location Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the location code associated with the posted sales credit memo line.';
            }
            field(EXCCRIUnitCost; Rec."Unit Cost")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the unit cost recorded on the posted sales credit memo line.';
            }
            field(EXCRIDiscountType; Rec."Tipo Descuento FE")
            {
                ApplicationArea = All;
                DrillDown = true;
                DrillDownPageId = "Tipo Descuentos FE";
                Editable = false;
                Lookup = true;
                LookupPageId = "Tipo Descuentos FE";
                ToolTip = 'Specifies the electronic invoicing discount type assigned to the posted sales credit memo line.';
            }
        }
    }
}
