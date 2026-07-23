report 56524 "Estado Ctas. Clientes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Estado Ctas. Clientes.rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Análisis Cta Clientes';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("Customer Posting Group")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Currency Code", "Payment Terms Code";
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
            column(Customer_TABLECAPTION__________FilterString; Customer.TABLECAPTION + ': ' + FilterString)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(Customer_Contact; Contact)
            {
            }
            column(ctacble; ctacble)
            {
            }
            column(Customer_Address; Address)
            {
            }
            column(Customer_City; City)
            {
            }
            column(Customer__Post_Code_; "Post Code")
            {
            }
            column(CustomerBlockedText; CustomerBlockedText)
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
            column(Importe_Pendiente__DL_Caption; "Cust. Ledger Entry".FIELDCAPTION("Remaining Amt. (LCY)"))
            {
            }
            column("NúmeroCaption"; NúmeroCaptionLbl)
            {
            }
            column("Días_Venci_Caption"; Días_Venci_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Currency_Code_Caption; Cust__Ledger_Entry__Currency_Code_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Remaining_Amount_Caption; "Cust. Ledger Entry".FIELDCAPTION("Remaining Amount"))
            {
            }
            column(Cust__Ledger_Entry_AmountCaption; "Cust. Ledger Entry".FIELDCAPTION(Amount))
            {
            }
            column(Cust__Ledger_Entry__Amount__LCY__Caption; "Cust. Ledger Entry".FIELDCAPTION("Amount (LCY)"))
            {
            }
            column(Phone_Caption; Phone_CaptionLbl)
            {
            }
            column(Contact_Caption; Contact_CaptionLbl)
            {
            }
            column(Contact_Caption_Control1000000002; Contact_Caption_Control1000000002Lbl)
            {
            }
            column(ClienteCaption; ClienteCaptionLbl)
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Customer_Currency_Filter; "Currency Filter")
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            dataitem("Cust. Ledger Entry"; 21)
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               Global Dimension 1 Code=FIELD("Global Dimension 1 Filter"),
                               Global Dimension 2 Code=FIELD("Global Dimension 2 Filter"),
                               Currency Code=FIELD("Currency Filter"),
                               Posting Date=FIELD("Date Filter");
                DataItemTableView = SORTING("Customer No.",Open,Positive,"Due Date")
                                    WHERE(Open=CONST(True));
                column(Cust__Ledger_Entry__Posting_Date_;"Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Document_Type_;"Document Type")
                {
                }
                column(Cust__Ledger_Entry__Document_No__;"Document No.")
                {
                }
                column(Cust__Ledger_Entry__Due_Date_;"Due Date")
                {
                }
                column(OverDueDays;OverDueDays)
                {
                }
                column(Cust__Ledger_Entry__Currency_Code_;GetCurrency("Currency Code"))
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amount_;"Remaining Amount")
                {
                }
                column(RemainAmountToPrint;"Remaining Amt. (LCY)")
                {
                }
                column(Cust__Ledger_Entry_Amount;Amount)
                {
                }
                column(Cust__Ledger_Entry__Amount__LCY__;"Amount (LCY)")
                {
                }
                column(Cust__Ledger_Entry_Entry_No_;"Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_;"Customer No.")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_1_Code;"Global Dimension 1 Code")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_2_Code;"Global Dimension 2 Code")
                {
                }
                column(Cust__Ledger_Entry_Currency_Code;"Currency Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Remaining Amount","Remaining Amt. (LCY)");
                    IF ("Due Date" <> 0D) AND (ToDate > "Due Date") AND ("Remaining Amount" > 0) THEN
                      OverDueDays := ToDate - "Due Date"
                    ELSE
                      OverDueDays := 0;

                    IF NOT CurrTotalBuff.GET("Currency Code") THEN BEGIN
                      CurrTotalBuff."Currency Code" := "Currency Code";
                      CurrTotalBuff."Total Amount" := "Remaining Amount";
                      CurrTotalBuff."Total Amount (LCY)" := "Remaining Amt. (LCY)";
                      CurrTotalBuff.INSERT;
                    END
                    ELSE BEGIN
                      CurrTotalBuff."Total Amount" += "Remaining Amount";
                      CurrTotalBuff."Total Amount (LCY)" += "Remaining Amt. (LCY)";
                      CurrTotalBuff.MODIFY;
                    END;

                    IF NOT CustCurrTotalBuff.GET("Currency Code") THEN BEGIN
                      CustCurrTotalBuff."Currency Code" := "Currency Code";
                      CustCurrTotalBuff."Total Amount" := "Remaining Amount";
                      CustCurrTotalBuff."Total Amount (LCY)" := "Remaining Amt. (LCY)";
                      CustCurrTotalBuff.INSERT;
                    END
                    ELSE BEGIN
                      CustCurrTotalBuff."Total Amount" += "Remaining Amount";
                      CustCurrTotalBuff."Total Amount (LCY)" += "Remaining Amt. (LCY)";
                      CustCurrTotalBuff.MODIFY;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS("Remaining Amt. (LCY)","Remaining Amt. (LCY)");
                    IF ToDate = 0D THEN
                      DateToConvertCurrency := WORKDATE
                    ELSE BEGIN
                      SETRANGE("Due Date",0D,ToDate);
                      DateToConvertCurrency := ToDate;
                    END;

                    IF GETFILTER("Posting Date") <> '' THEN
                      COPYFILTER("Posting Date","Date Filter");

                    CustCurrTotalBuff.RESET;
                    CustCurrTotalBuff.DELETEALL;
                end;
            }
            dataitem(CustCurrencyTotal;2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=FILTER(1..));
                column(CustomerNo;Customer."No.")
                {
                }
                column(GetCurrency_CustCurrTotalBuff__Currency_Code__;GetCurrency(CustCurrTotalBuff."Currency Code"))
                {
                }
                column(CustCurrTotalBuff__Total_Amount_;CustCurrTotalBuff."Total Amount")
                {
                }
                column(CustCurrTotalBuff__Total_Amount__LCY__;CustCurrTotalBuff."Total Amount (LCY)")
                {
                }
                column(CustCurrencyTotal_Number;Number)
                {
                }
                column(CustCurrTotalBuff__Total_Amount__Control1000000016;CustCurrTotalBuff."Total Amount")
                {
                }
                column(CustCurrTotalBuff__Total_Amount__LCY___Control1000000017;CustCurrTotalBuff."Total Amount (LCY)")
                {
                }
                column(GetCurrency_CustCurrTotalBuff__Currency_Code___Control1000000018;GetCurrency(CustCurrTotalBuff."Currency Code"))
                {
                }
                column(CustCurrTotalBuff__Total_Amount__LCY___Control1000000020;CustCurrTotalBuff."Total Amount (LCY)")
                {
                }
                column(Customer_totalCaption;Customer_totalCaptionLbl)
                {
                }
                column(Customer_total__Caption;Customer_total__CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN
                      IF CustCurrTotalBuff.NEXT = 0 THEN
                        CurrReport.BREAK;
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT CustCurrTotalBuff.FINDSET THEN
                      CurrReport.BREAK;

                    CurrReport.CREATETOTALS(CustCurrTotalBuff."Total Amount",CustCurrTotalBuff."Total Amount (LCY)");
                end;
            }

            trigger OnAfterGetRecord()
            var
                recPosting: Record 92;
            begin
                IF Blocked <> Blocked::" " THEN
                  CustomerBlockedText := STRSUBSTNO(Text1020000,Blocked)
                ELSE
                  CustomerBlockedText := '';

                recPosting.RESET;
                IF recPosting.GET("Customer Posting Group") THEN
                  ctacble := recPosting."Receivables Account"
                ELSE
                  ctacble := '';

                sumUSD:=0;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS("Cust. Ledger Entry"."Remaining Amt. (LCY)");
            end;
        }
        dataitem(CurrencyTotal;2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number=FILTER(1..));
            column(CurrTotalBuff__Total_Amount_;CurrTotalBuff."Total Amount")
            {
            }
            column(CurrTotalBuff__Total_Amount__LCY__;CurrTotalBuff."Total Amount (LCY)")
            {
            }
            column(GetCurrency_CurrTotalBuff__Currency_Code__;GetCurrency(CurrTotalBuff."Currency Code"))
            {
            }
            column(CurrencyTotal_Number;Number)
            {
            }
            column(CurrTotalBuff__Total_Amount__Control1000000026;CurrTotalBuff."Total Amount")
            {
            }
            column(CurrTotalBuff__Total_Amount__LCY___Control1000000027;CurrTotalBuff."Total Amount (LCY)")
            {
            }
            column(GetCurrency_CurrTotalBuff__Currency_Code___Control1000000028;GetCurrency(CurrTotalBuff."Currency Code"))
            {
            }
            column(CustCurrTotalBuff__Total_Amount__LCY___Control1000000029;CustCurrTotalBuff."Total Amount (LCY)")
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            column(Total__Caption;Total__CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number > 1 THEN
                  IF CurrTotalBuff.NEXT = 0 THEN
                    CurrReport.BREAK;
            end;

            trigger OnPreDataItem()
            begin
                IF NOT CurrTotalBuff.FINDSET THEN
                  CurrReport.BREAK;

                CurrReport.CREATETOTALS(CurrTotalBuff."Total Amount",CurrTotalBuff."Total Amount (LCY)");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("<Control1000000001>";ToDate)
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
        FilterString := Customer.GETFILTERS;

        IF ToDate <> 0D THEN
          Subtitle := Text000 + ' ' + FORMAT(ToDate,0,4) + ')';
    end;

    var
        CompanyInformation: Record 79;
        CurrExchRate: Record 330;
        GLSetup: Record 98;
        CustCurrTotalBuff: Record 332 temporary;
        CurrTotalBuff: Record 332 temporary;
        FilterString: Text[250];
        CustomerBlockedText: Text[80];
        Subtitle: Text[126];
        ToDate: Date;
        DateToConvertCurrency: Date;
        OverDueDays: Integer;
        Text000: Label '(Open Entries Due as of';
        Text1020000: Label ' *** Customer is Blocked for %1 processing ***';
        Text002: Label 'Amount due is in %1';
        Text003: Label 'Amounts are in the customer''s local currency (report totals are in %1).';
        Text004: Label 'Report Total Amount Due (%1)';
        sumUSD: Decimal;
        sumPostingGroup: Decimal;
        ctacble: Text[20];
        sumUSDTotal: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Análisis_Cta_ClientesCaptionLbl": Label 'ACCOUNT STATUS BY CUSTOMER (Detailed)';
        DocumentCaptionLbl: Label 'Document';
        TipoCaptionLbl: Label 'Tipo';
        "NúmeroCaptionLbl": Label 'Número';
        "Días_Venci_CaptionLbl": Label 'Días Venci.';
        Cust__Ledger_Entry__Currency_Code_CaptionLbl: Label 'Currency Code';
        Phone_CaptionLbl: Label 'Phone:';
        Contact_CaptionLbl: Label 'Contact:';
        Contact_Caption_Control1000000002Lbl: Label 'Acc. No.:';
        ClienteCaptionLbl: Label 'Customer';
        Customer_totalCaptionLbl: Label 'Customer total';
        Customer_total__CaptionLbl: Label 'Customer total $';
        TotalCaptionLbl: Label 'Total';
        Total__CaptionLbl: Label 'Total $';

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

