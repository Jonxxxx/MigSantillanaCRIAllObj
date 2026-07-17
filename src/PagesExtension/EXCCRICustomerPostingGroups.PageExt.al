pageextension 50035 EXCCRICustomerPostingGroups extends "Customer Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIInternalCustomer; Rec."Cliente Interno")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether customers in this posting group are treated as internal customers.';
            }
            field(EXCCRICopyrightNotApplicable; Rec."No aplica Derechos de Autor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether copyright charges do not apply to customers in this posting group.';
            }
            field(EXCCRIPromotion; Rec.Promocion)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the customer posting group is used for promotional transactions.';
            }
            field(EXCCRIAllowNCF; Rec."Permite emitir NCF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether fiscal receipt numbers can be issued for this customer posting group.';
            }
            field(EXCCRINCFInvoiceNoSeries; Rec."No. Serie NCF Factura Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number series used for sales invoices.';
            }
            field(EXCCRINCFCreditMemoSeries; Rec."No. Serie NCF Abonos Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number series used for sales credit memos.';
            }
            field(EXCCRIInvoiceReportId; Rec."Invoice Report ID")
            {
                ApplicationArea = All;
                Visible = EXCCRIShowCustomReports;
                ToolTip = 'Specifies the report ID used to print invoices for this customer posting group.';
            }
            field(EXCCRIInvoiceReportName; Rec."Invoice Report Name")
            {
                ApplicationArea = All;
                Visible = EXCCRIShowCustomReports;
                ToolTip = 'Specifies the name of the report used to print invoices for this customer posting group.';
            }
            field(EXCCRIMemoReportId; Rec."Credit Memo Report ID")
            {
                ApplicationArea = All;
                Visible = EXCCRIShowCustomReports;
                ToolTip = 'Specifies the report ID used to print credit memos for this customer posting group.';
            }
            field(EXCCRIMemoReportName; Rec."Credit Memo Report Name")
            {
                ApplicationArea = All;
                Visible = EXCCRIShowCustomReports;
                ToolTip = 'Specifies the name of the report used to print credit memos for this customer posting group.';
            }
            field(EXCCRIInsolvencyProvisionAcc; Rec."Cta. Dotacion Provision insolv")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the account used for the insolvency provision allocation.';
            }
        }
    }

    trigger OnOpenPage()
    var
        EXCCRISantillanaSetup: Record 56001;
        EXCCRILocalizationSetup: Record 34003011;
    begin
        EXCCRISantillanaSetup.Get();
        EXCCRILocalizationSetup.Get(EXCCRISantillanaSetup.Country);
        EXCCRIShowCustomReports :=
            EXCCRILocalizationSetup."Formato Doc. Vtas. por cliente";
    end;

    var
        EXCCRIShowCustomReports: Boolean;
}
