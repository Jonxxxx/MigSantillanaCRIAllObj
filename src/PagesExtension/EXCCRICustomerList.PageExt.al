pageextension 50008 EXCCRICustomerList extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(EXCCRIBillToCustomerNo; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer that receives invoices for this customer.';
            }
            field(EXCCRIAddress; Rec.Address)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer address.';
            }
            field(EXCCRIName2; Rec."Name 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies an additional name for the customer.';
            }
            field(EXCCRISICCustomerNo; Rec."No_ Cliente SIC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer number used by the SIC integration.';
            }
            field(EXCCRIName; Rec.Name)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer name.';
            }
            field(EXCCRICounty; Rec.County)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the state, province, or county in the customer address.';
            }
            field(EXCCRICity; Rec.City)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the city in the customer address.';
            }
            field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer tax registration number.';
            }
            field(EXCCRIPostCode; Rec."Post Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the postal code in the customer address.';
            }
            field(EXCCRISchoolCode; Rec."Cod. Colegio")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the school code associated with the customer.';
            }
            field(EXCCRISchoolName; Rec."Nombre Colegio")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the school name associated with the customer.';
            }
            field(EXCCRISchoolTypes; Rec."Tipos de colegios")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the school type associated with the customer.';
            }
            field(EXCCRIUpdatedConsignBalance; Rec."Balance en Consignacion Act.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the updated consignment balance for the customer.';
            }
            field(EXCCRIUpdatedConsignInventory; Rec."Inventario en Consignacion Act")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the updated consignment inventory for the customer.';
            }
            field(EXCCRIAddress2; Rec."Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies additional customer address information.';
            }
            field(EXCCRIGlobalDimension2Code; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the second global dimension assigned to the customer.';
            }
            field(EXCCRICollectorCode; Rec."Collector Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the collector assigned to the customer.';
            }
            field(EXCCRICollectionZone; Rec."Zona de cobro")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the collection zone assigned to the customer.';
            }
            field(EXCCRIBalance; Rec.Balance)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the current customer balance.';
            }
            field(EXCCRIEmail; Rec."E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer email address.';
            }
            //TODO: Campo no existe
            /*
            field(EXCCRIEmail2; Rec."E-Mail 2")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the secondary customer email address.';
            }*/
            field(EXCCRICreditLimit; Rec."Credit Limit (LCY)")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the maximum credit amount allowed for the customer in local currency.';
            }
            field(EXCCRIBlocked; Rec.Blocked)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies which customer transactions are blocked.';
            }
            field(EXCCRILastDateModified; Rec."Last Date Modified")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the date when the customer was last modified.';
            }
            field(EXCCRIApplicationMethod; Rec."Application Method")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies how payments are applied to customer entries.';
            }
            field(EXCCRICombineShipments; Rec."Combine Shipments")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies whether multiple shipments are combined into one invoice.';
            }
            //TODO: Campo no existe
            /*
            field(EXCCRITaxIdentificationType; Rec."Tax Identification Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the tax identification type assigned to the customer.';
            }*/
            field(EXCCRIReserve; Rec.Reserve)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the default reservation policy for the customer.';
            }
            field(EXCCRIShippingAdvice; Rec."Shipping Advice")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies whether partial or complete shipments are allowed for the customer.';
            }
            field(EXCCRIShippingAgentCode; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the shipping agent assigned to the customer.';
            }
            field(EXCCRIBaseCalendarCode; Rec."Base Calendar Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the base calendar used for the customer.';
            }
            field(EXCCRIInactive; Rec.Inactivo)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the customer is inactive.';
            }
        }
    }
}
