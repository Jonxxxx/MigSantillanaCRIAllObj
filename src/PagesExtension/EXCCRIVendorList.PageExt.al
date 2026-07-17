pageextension 50011 EXCCRIVendorList extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field(EXCCRIBalance; Rec.Balance)
            {
                ApplicationArea = All;
                Caption = 'Balance';
                ToolTip = 'Specifies the current balance for the vendor.';
            }
            field(EXCCRIBalanceLCY; Rec."Balance (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Balance (LCY)';
                ToolTip = 'Specifies the current vendor balance in local currency.';
            }
            field(EXCCRINetChange; Rec."Net Change")
            {
                ApplicationArea = All;
                Caption = 'Net Change';
                ToolTip = 'Specifies the net change for the vendor within the current filters.';
            }
            field(EXCCRINetChangeLCY; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Net Change (LCY)';
                ToolTip = 'Specifies the vendor net change in local currency within the current filters.';
            }
            field(EXCCRIBlocked; Rec.Blocked)
            {
                ApplicationArea = All;
                Caption = 'Blocked';
                Visible = false;
                ToolTip = 'Specifies which transactions are blocked for the vendor.';
            }
            field(EXCCRILastDateModified; Rec."Last Date Modified")
            {
                ApplicationArea = All;
                Caption = 'Last Date Modified';
                Visible = false;
                ToolTip = 'Specifies the date when the vendor was last modified.';
            }
            field(EXCCRIApplicationMethod; Rec."Application Method")
            {
                ApplicationArea = All;
                Caption = 'Application Method';
                Visible = false;
                ToolTip = 'Specifies how payments are applied to vendor entries.';
            }
            field(EXCCRILocationCode; Rec."Location Code")
            {
                ApplicationArea = All;
                Caption = 'Location Code';
                Visible = false;
                ToolTip = 'Specifies the default receiving location for the vendor.';
            }
            field(EXCCRIShipmentMethod; Rec."Shipment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Shipment Method Code';
                Visible = false;
                ToolTip = 'Specifies the shipment method assigned to the vendor.';
            }
            field(EXCCRILeadTime; Rec."Lead Time Calculation")
            {
                ApplicationArea = All;
                Caption = 'Lead Time Calculation';
                Visible = false;
                ToolTip = 'Specifies the lead time calculation assigned to the vendor.';
            }
            field(EXCCRIBaseCalendar; Rec."Base Calendar Code")
            {
                ApplicationArea = All;
                Caption = 'Base Calendar Code';
                Visible = false;
                ToolTip = 'Specifies the base calendar assigned to the vendor.';
            }
            field(EXCCRIInactive; Rec.Inactivo)
            {
                ApplicationArea = All;
                Caption = 'Inactive';
                ToolTip = 'Specifies whether the vendor is inactive.';
            }
            //TODO: Ver 
            /*
            field(EXCCRITaxIdType; Rec."Tax Identification Type")
            {
                ApplicationArea = All;
                Caption = 'Tax Identification Type';
                ToolTip = 'Specifies the tax identification type assigned to the vendor.';
            }*/
            field(EXCCRIEmail; Rec."E-Mail")
            {
                ApplicationArea = All;
                Caption = 'Email';
                ToolTip = 'Specifies the vendor email address.';
            }
            field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'VAT Registration No.';
                ToolTip = 'Specifies the vendor tax registration number.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIRetentions)
            {
                ApplicationArea = All;
                Caption = 'Retentions';
                Image = CalculateCost;
                RunObject = Page 34003001;
                RunPageLink = "Cod. Proveedor" = field("No.");
                RunPageView = sorting("Cod. Proveedor", "Codigo Retencion") order(ascending);
                ShortCutKey = 'Shift+Ctrl+R';
                ToolTip = 'Opens the retention setup for the selected vendor.';
            }
        }
    }
}
