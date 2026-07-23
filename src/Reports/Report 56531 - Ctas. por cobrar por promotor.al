report 56531 "Ctas. por cobrar por promotor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Ctas. por cobrar por promotor.rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Ctas. por cobrar por promotor';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Salesperson/Purchaser"; 13)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", Name;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Subtitle; Subtitle)
            {
            }
            column(Customer_TABLECAPTION__________FilterString; "Salesperson/Purchaser".TABLECAPTION + ': ' + FilterString)
            {
            }
            column(Salesperson_Purchaser_Code; Code)
            {
            }
            column(Salesperson_name; Name)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(Customer_Contact; "Home Page")
            {
            }
            column(Cust__Ledger_Entry___Remaining_Amt___LCY__; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
            {
            }
            column(Cust__Ledger_Entry___Amount__LCY__; "Cust. Ledger Entry"."Amount (LCY)")
            {
            }
            column(Cust__Ledger_Entry___Amount__LCY____Cust__Ledger_Entry___Remaining_Amt___LCY__; "Cust. Ledger Entry"."Amount (LCY)" - "Cust. Ledger Entry"."Remaining Amt. (LCY)")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Análisis_Cta_ClientesCaption"; Análisis_Cta_ClientesCaptionLbl)
            {
            }
            column(DocumentCaption; DocumentCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; "Cust. Ledger Entry".FIELDCAPTION("Posting Date"))
            {
            }
            column(TipoCaption; TipoCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Due_Date_Caption; "Cust. Ledger Entry".FIELDCAPTION("Due Date"))
            {
            }
            column("NúmeroCaption"; NúmeroCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Amount__LCY__Caption; "Cust. Ledger Entry".FIELDCAPTION("Amount (LCY)"))
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption; "Cust. Ledger Entry".FIELDCAPTION("Customer No."))
            {
            }
            column(Importe_Pendiente__DL_Caption; "Cust. Ledger Entry".FIELDCAPTION("Remaining Amt. (LCY)"))
            {
            }
            column(Amount__LCY____Remaining_Amt___LCY__Caption; Amount__LCY____Remaining_Amt___LCY__CaptionLbl)
            {
            }
            column(Customer_Name_Control1000000012Caption; Customer_Name_Control1000000012CaptionLbl)
            {
            }
            column(Phone_Caption; Phone_CaptionLbl)
            {
            }
            column(Contact_Caption; Contact_CaptionLbl)
            {
            }
            column(ClienteCaption; ClienteCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Salesperson_Purchaser_Date_Filter; "Date Filter")
            {
            }
            dataitem("Cust. Ledger Entry"; 21)
            {
                DataItemLink = "Salesperson Code" = FIELD(Code),
                               Posting Date=FIELD("Date Filter");
                DataItemTableView = SORTING("Customer No.", "Posting Date", Open, Provisionado por insolvencia)
                                    WHERE(Open = CONST(True));
                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Document_Type_; "Document Type")
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry__Due_Date_; "Due Date")
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amt___LCY__; "Remaining Amt. (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Amount__LCY__; "Amount (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
                {
                }
                column(Customer_Name; Customer.Name)
                {
                }
                column(Amount__LCY____Remaining_Amt___LCY__; "Amount (LCY)" - "Remaining Amt. (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amt___LCY___Control1000000001; "Remaining Amt. (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Amount__LCY___Control1000000002; "Amount (LCY)")
                {
                }
                column(Salesperson_Purchaser__Code; "Salesperson/Purchaser".Code)
                {
                }
                column(Amount__LCY____Remaining_Amt___LCY___Control1000000015; "Amount (LCY)" - "Remaining Amt. (LCY)")
                {
                }
                column(TotalCaption_Control1000000003; TotalCaption_Control1000000003Lbl)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Salesperson_Code; "Salesperson Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //IF "Customer No." <> Customer."No." THEN
                    IF NOT Customer.GET("Customer No.") THEN
                        CLEAR(Customer);
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS("Cust. Ledger Entry"."Remaining Amt. (LCY)", "Cust. Ledger Entry"."Amount (LCY)");

                    IF ToDate = 0D THEN
                        DateToConvertCurrency := WORKDATE
                    ELSE BEGIN
                        SETRANGE("Due Date", 0D, ToDate);
                        DateToConvertCurrency := ToDate;
                    END;

                    IF GETFILTER("Posting Date") <> '' THEN
                        COPYFILTER("Posting Date", "Date Filter");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                sumUSD := 0;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS("Cust. Ledger Entry"."Remaining Amt. (LCY)", "Cust. Ledger Entry"."Amount (LCY)");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("<Control1000000001>"; ToDate)
                {
                    Caption = 'Fecha final';
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            IF ToDate = 0D THEN
                ToDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        GLSetup.GET;
        FilterString := "Salesperson/Purchaser".GETFILTERS;

        IF ToDate <> 0D THEN
            Subtitle := Text000 + ' ' + FORMAT(ToDate, 0, 4) + ')';
    end;

    var
        CompanyInformation: Record 79;
        GLSetup: Record 98;
        Customer: Record 18;
        FilterString: Text[250];
        Subtitle: Text[126];
        ToDate: Date;
        DateToConvertCurrency: Date;
        Text000: Label '(Open Entries Due as of';
        Text1020000: Label ' *** Customer is Blocked for %1 processing ***';
        Text002: Label 'Amount due is in %1';
        Text003: Label 'Amounts are in the customer''s local currency (report totals are in %1).';
        Text004: Label 'Report Total Amount Due (%1)';
        sumUSD: Decimal;
        sumPostingGroup: Decimal;
        sumUSDTotal: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Análisis_Cta_ClientesCaptionLbl": Label 'ACCOUNT STATUS BY CUSTOMER (Detailed)';
        DocumentCaptionLbl: Label 'Document';
        TipoCaptionLbl: Label 'Tipo';
        "NúmeroCaptionLbl": Label 'Número';
        Amount__LCY____Remaining_Amt___LCY__CaptionLbl: Label 'Advance ($)';
        Customer_Name_Control1000000012CaptionLbl: Label 'Name';
        Phone_CaptionLbl: Label 'Phone:';
        Contact_CaptionLbl: Label 'Zone:';
        ClienteCaptionLbl: Label 'Salesperson';
        TotalCaptionLbl: Label 'Total';
        TotalCaption_Control1000000003Lbl: Label 'Total';

    local procedure GetCurrency(CurrencyCode: Code[10]): Code[10]
    var
        Currency: Record 4;
    begin
        IF CurrencyCode = '' THEN
            EXIT(GLSetup."LCY Code")
        ELSE
            EXIT(CurrencyCode);
    end;
}

