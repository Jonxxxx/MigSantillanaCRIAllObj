report 56117 "Antiguedad Cobros Formato Exce"
{
    // #3143 Se define un valor por defecto para la longitud del periodo. Se valida que tenga contenido.
    DefaultLayout = RDLC;
    RDLCLayout = './Antiguedad Cobros Formato Exce.rdlc';

    ApplicationArea = Basic, Suite, Service;
    Caption = 'Aged Accounts Receivable (EXCEL)';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(STRSUBSTNO_Text006_FORMAT_EndingDate_0_4__; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
            {
            }
            column(STRSUBSTNO_Text007_SELECTSTR_AgingBy___1_Text009__; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AgingBy; AgingBy)
            {
            }
            column(TABLECAPTION__________CustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(EmptyString_Control56; '')
            {
            }
            column(STRSUBSTNO_Text004_SELECTSTR_AgingBy___1_Text009__; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(HeaderText_5_; HeaderText[5])
            {
            }
            column(HeaderText_4_; HeaderText[4])
            {
            }
            column(HeaderText_3_; HeaderText[3])
            {
            }
            column(HeaderText_2_; HeaderText[2])
            {
            }
            column(HeaderText_1_; HeaderText[1])
            {
            }
            column(GrandTotalCustLedgEntry_5___Remaining_Amt___LCY__; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCustLedgEntry_4___Remaining_Amt___LCY__; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCustLedgEntry_3___Remaining_Amt___LCY__; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCustLedgEntry_2___Remaining_Amt___LCY__; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCustLedgEntry_1___Remaining_Amt___LCY__; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCustLedgEntry_1___Amount__LCY__; GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(Pct_GrandTotalCustLedgEntry_1___Remaining_Amt___LCY___GrandTotalCustLedgEntry_1___Amount__LCY___; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(Pct_GrandTotalCustLedgEntry_2___Remaining_Amt___LCY___GrandTotalCustLedgEntry_1___Amount__LCY___; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(Pct_GrandTotalCustLedgEntry_3___Remaining_Amt___LCY___GrandTotalCustLedgEntry_1___Amount__LCY___; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(Pct_GrandTotalCustLedgEntry_4___Remaining_Amt___LCY___GrandTotalCustLedgEntry_1___Amount__LCY___; Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(Pct_GrandTotalCustLedgEntry_5___Remaining_Amt___LCY___GrandTotalCustLedgEntry_1___Amount__LCY___; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(Aged_Accounts_ReceivableCaption; Aged_Accounts_ReceivableCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_Amounts_in_LCYCaption; All_Amounts_in_LCYCaptionLbl)
            {
            }
            column(Aged_Overdue_AmountsCaption; Aged_Overdue_AmountsCaptionLbl)
            {
            }
            column(Original_Amount_Control58Caption; Original_Amount_Control58CaptionLbl)
            {
            }
            column(CustLedgEntryEndingDate__Remaining_Amt___LCY__Caption; CustLedgEntryEndingDate__Remaining_Amt___LCY__CaptionLbl)
            {
            }
            column(CustLedgEntryEndingDate__Due_Date_Caption; CustLedgEntryEndingDate__Due_Date_CaptionLbl)
            {
            }
            column(CustLedgEntryEndingDate__Document_No__Caption; CustLedgEntryEndingDate__Document_No__CaptionLbl)
            {
            }
            column(CustLedgEntryEndingDate__Posting_Date_Caption; CustLedgEntryEndingDate__Posting_Date_CaptionLbl)
            {
            }
            column(FORMAT_CustLedgEntryEndingDate__Document_Type__Caption; FORMAT_CustLedgEntryEndingDate__Document_Type__CaptionLbl)
            {
            }
            column(No__ClienteCaption; No__ClienteCaptionLbl)
            {
            }
            column(NombreCaption; NombreCaptionLbl)
            {
            }
            column(Total__LCY_Caption; Total__LCY_CaptionLbl)
            {
            }
            column(Customer_No_; "No.")
            {
            }
            dataitem("Cust. Ledger Entry"; 21)
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", Currency Code);

                trigger OnAfterGetRecord()
                var
                    CustLedgEntry: Record 21;
                begin
                    CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    CustLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF CustLedgEntry.FIND('-') THEN
                        REPEAT
                            InsertTemp(CustLedgEntry);
                        UNTIL CustLedgEntry.NEXT = 0;

                    CustLedgEntry.RESET;
                    CustLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF CustLedgEntry.FIND('-') THEN
                        REPEAT
                            InsertTemp(CustLedgEntry);
                        UNTIL CustLedgEntry.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", EndingDate + 1, 12319999D);
                end;
            }
            dataitem(OpenCustLedgEntry; 21)
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", Currency Code)
                                    WHERE(Open = CONST(True));

                trigger OnAfterGetRecord()
                begin
                    InsertTemp(OpenCustLedgEntry);
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", 0D, EndingDate);
                end;
            }
            dataitem(CurrencyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                PrintOnlyIfDetail = true;
                dataitem(TempCustLedgEntryLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(CustLedgEntryEndingDate__Amount__LCY__; CustLedgEntryEndingDate."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCustLedgEntry_1___Remaining_Amt___LCY__; AgedCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCustLedgEntry_2___Remaining_Amt___LCY__; AgedCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCustLedgEntry_3___Remaining_Amt___LCY__; AgedCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCustLedgEntry_4___Remaining_Amt___LCY__; AgedCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCustLedgEntry_5___Remaining_Amt___LCY__; AgedCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntryEndingDate__Remaining_Amt___LCY__; CustLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntryEndingDate__Due_Date_; CustLedgEntryEndingDate."Due Date")
                    {
                    }
                    column(CustLedgEntryEndingDate__Document_No__; CustLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(FORMAT_CustLedgEntryEndingDate__Document_Type__; FORMAT(CustLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(CustLedgEntryEndingDate__Posting_Date_; CustLedgEntryEndingDate."Posting Date")
                    {
                    }
                    column(Customer__No__; Customer."No.")
                    {
                    }
                    column(Customer_Name; Customer.Name)
                    {
                    }
                    column(AgedCustLedgEntry_5___Remaining_Amount_; AgedCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCustLedgEntry_4___Remaining_Amount_; AgedCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCustLedgEntry_3___Remaining_Amount_; AgedCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCustLedgEntry_2___Remaining_Amount_; AgedCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCustLedgEntry_1___Remaining_Amount_; AgedCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntryEndingDate_Amount; CustLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntryEndingDate__Remaining_Amount_; CustLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntryEndingDate__Due_Date__Control96; CustLedgEntryEndingDate."Due Date")
                    {
                    }
                    column(CustLedgEntryEndingDate__Document_No___Control97; CustLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(FORMAT_CustLedgEntryEndingDate__Document_Type___Control98; FORMAT(CustLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(CustLedgEntryEndingDate__Posting_Date__Control99; CustLedgEntryEndingDate."Posting Date")
                    {
                    }
                    column(Customer__No___Control1000000001; Customer."No.")
                    {
                    }
                    column(Customer_Name_Control1000000003; Customer.Name)
                    {
                    }
                    column(STRSUBSTNO_Text005_Customer_Name_; STRSUBSTNO(Text005, Customer.Name))
                    {
                    }
                    column(TotalCustLedgEntry_1___Amount__LCY__; TotalCustLedgEntry[1]."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_1___Remaining_Amt___LCY__; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_2___Remaining_Amt___LCY__; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_3___Remaining_Amt___LCY__; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_4___Remaining_Amt___LCY__; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_5___Remaining_Amt___LCY__; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CurrencyCode; CurrencyCode)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(STRSUBSTNO_Text005_Customer_Name__Control101; STRSUBSTNO(Text005, Customer.Name))
                    {
                    }
                    column(TotalCustLedgEntry_5___Remaining_Amount_; TotalCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_4___Remaining_Amount_; TotalCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_3___Remaining_Amount_; TotalCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_2___Remaining_Amount_; TotalCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_1___Remaining_Amount_; TotalCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_1__Amount; TotalCustLedgEntry[1].Amount)
                    {
                        AutoFormatType = 1;
                    }
                    column(Customer__No___Control9; Customer."No.")
                    {
                    }
                    column(Customer_Name_Control15; Customer.Name)
                    {
                    }
                    column(TotalCustLedgEntry_1___Amount__LCY___Control17; TotalCustLedgEntry[1]."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_1___Remaining_Amt___LCY___Control18; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_2___Remaining_Amt___LCY___Control19; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_3___Remaining_Amt___LCY___Control20; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_4___Remaining_Amt___LCY___Control22; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_5___Remaining_Amt___LCY___Control23; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(Customer_Contact; Customer.Contact)
                    {
                    }
                    column(Customer__Phone_No__; Customer."Phone No.")
                    {
                    }
                    column(TotalCustLedgEntry_1__Amount_Control24; TotalCustLedgEntry[1].Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_1___Remaining_Amount__Control25; TotalCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_2___Remaining_Amount__Control26; TotalCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_3___Remaining_Amount__Control27; TotalCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_4___Remaining_Amount__Control28; TotalCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_5___Remaining_Amount__Control29; TotalCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Customer_Name_Control30; Customer.Name)
                    {
                    }
                    column(Customer__No___Control31; Customer."No.")
                    {
                    }
                    column(CurrencyCode_Control32; CurrencyCode)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Customer_Contact_Control1103350005; Customer.Contact)
                    {
                    }
                    column(Customer__Phone_No___Control1103350002; Customer."Phone No.")
                    {
                    }
                    column(TempCustLedgEntryLoop_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        CustLedgEntry: Record 21;
                        PeriodIndex: Integer;
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempCustLedgEntry.FIND('-') THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF TempCustLedgEntry.NEXT = 0 THEN
                                CurrReport.BREAK;

                        TempCustLedgEntry.SETRANGE("Date Filter", 0D, EndingDate);
                        TempCustLedgEntry.CALCFIELDS(Amount, "Amount (LCY)");
                        IF TempCustLedgEntry.Amount = 0 THEN
                            CurrReport.SKIP;

                        CustLedgEntryEndingDate := TempCustLedgEntry;
                        CustLedgEntryEndingDate."Remaining Amount" := TempCustLedgEntry.Amount;
                        CustLedgEntryEndingDate."Remaining Amt. (LCY)" := TempCustLedgEntry."Amount (LCY)";

                        CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                        CustLedgEntry.SETRANGE("Closed by Entry No.", TempCustLedgEntry."Entry No.");
                        CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                        IF CustLedgEntry.FIND('-') THEN
                            REPEAT
                                CustLedgEntry.CALCFIELDS(Amount);
                                IF CustLedgEntry.Amount <> 0 THEN BEGIN
                                    CustLedgEntryEndingDate."Remaining Amount" += CustLedgEntry."Closed by Currency Amount";
                                    CustLedgEntryEndingDate."Remaining Amt. (LCY)" += CustLedgEntry."Closed by Amount (LCY)";
                                END;
                            UNTIL CustLedgEntry.NEXT = 0;
                        CustLedgEntry.RESET;
                        CustLedgEntry.SETRANGE("Entry No.", TempCustLedgEntry."Closed by Entry No.");
                        CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                        IF CustLedgEntry.FIND('-') THEN
                            REPEAT
                                CustLedgEntry.CALCFIELDS(Amount);
                                IF CustLedgEntry.Amount <> 0 THEN BEGIN
                                    CustLedgEntryEndingDate."Remaining Amount" -= CustLedgEntry."Closed by Amount";
                                    CustLedgEntryEndingDate."Remaining Amt. (LCY)" -= CustLedgEntry."Closed by Amount (LCY)";
                                END;
                            UNTIL CustLedgEntry.NEXT = 0;

                        CASE AgingBy OF
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                        END;
                        CLEAR(AgedCustLedgEntry);
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                    end;

                    trigger OnPostDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN
                            UpdateCurrencyTotals;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT PrintAmountInLCY THEN
                            TempCustLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TotalCustLedgEntry);

                    IF Number = 1 THEN BEGIN
                        IF NOT TempCurrency.FIND('-') THEN
                            CurrReport.BREAK;
                    END ELSE
                        IF TempCurrency.NEXT = 0 THEN
                            CurrReport.BREAK;

                    IF TempCurrency.Code <> '' THEN
                        CurrencyCode := TempCurrency.Code
                    ELSE
                        CurrencyCode := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NewPagePercustomer AND (NumberOfCurrencies > 0) THEN
                        CurrReport.NEWPAGE;
                end;

                trigger OnPreDataItem()
                begin
                    NumberOfCurrencies := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TempCurrency.RESET;
                TempCurrency.DELETEALL;
                TempCustLedgEntry.RESET;
                TempCustLedgEntry.DELETEALL;
            end;
        }
        dataitem(CurrencyTotals; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(TempCurrency2_Code; TempCurrency2.Code)
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_6___Remaining_Amount_; AgedCustLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_1___Remaining_Amount__Control120; AgedCustLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_2___Remaining_Amount__Control121; AgedCustLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_3___Remaining_Amount__Control122; AgedCustLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_4___Remaining_Amount__Control123; AgedCustLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_5___Remaining_Amount__Control124; AgedCustLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(CurrencyTotals_Number; Number)
            {
            }
            column(TempCurrency2_Code_Control118; TempCurrency2.Code)
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_1___Remaining_Amount__Control109; AgedCustLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_5___Remaining_Amount__Control112; AgedCustLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_4___Remaining_Amount__Control113; AgedCustLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(Original_Amount; AgedCustLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(Original_Amount_Control115; AgedCustLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_6___Remaining_Amount__Control116; AgedCustLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(Currency_SpecificationCaption; Currency_SpecificationCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT TempCurrency2.FIND('-') THEN
                        CurrReport.BREAK;
                END ELSE
                    IF TempCurrency2.NEXT = 0 THEN
                        CurrReport.BREAK;

                CLEAR(AgedCustLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                IF TempCurrencyAmount.FIND('-') THEN
                    REPEAT
                        IF TempCurrencyAmount.Date <> 12319999D THEN
                            AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        ELSE
                            AgedCustLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                    UNTIL TempCurrencyAmount.NEXT = 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Opciones)
                {
                    Caption = 'Opciones';
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Vencido desde';
                    }
                    field(AgingBy; AgingBy)
                    {
                        Caption = 'Vencido por';
                        OptionCaption = 'Fecha vencimiento,Fecha registro,Fecha emisión documento';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Long. períodos antigüedad';
                    }
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        Caption = 'Imprimir importes en DL';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        Caption = 'Imprimir detalles';
                    }
                    field(HeadingType; HeadingType)
                    {
                        Caption = 'Tipo cabecera';
                        OptionCaption = 'Date Interval,Number of Days';
                    }
                    field(NewPagePercustomer; NewPagePercustomer)
                    {
                        Caption = 'Página nueva por cliente';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF EndingDate = 0D THEN
                EndingDate := WORKDATE;


            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '1M');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;

        GLSetup.GET;

        CalcDates;
        CreateHeadings;
    end;

    var
        GLSetup: Record 98;
        TempCustLedgEntry: Record 21 temporary;
        CustLedgEntryEndingDate: Record 21;
        TotalCustLedgEntry: array[5] of Record 21;
        GrandTotalCustLedgEntry: array[5] of Record 21;
        AgedCustLedgEntry: array[6] of Record 21;
        TempCurrency: Record 4 temporary;
        TempCurrency2: Record 4 temporary;
        TempCurrencyAmount: Record 264 temporary;
        CustFilter: Text[250];
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePercustomer: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        CurrencyCode: Code[10];
        Text002: Label 'days';
        Text003: Label 'More than';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        Text008: Label 'All Amounts in LCY';
        NumberOfCurrencies: Integer;
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        Aged_Accounts_ReceivableCaptionLbl: Label 'Aged Accounts Receivable';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_Amounts_in_LCYCaptionLbl: Label 'All Amounts in LCY';
        Aged_Overdue_AmountsCaptionLbl: Label 'Aged Overdue Amounts';
        Original_Amount_Control58CaptionLbl: Label 'Balance';
        CustLedgEntryEndingDate__Remaining_Amt___LCY__CaptionLbl: Label 'Original Amount ';
        CustLedgEntryEndingDate__Due_Date_CaptionLbl: Label 'Due Date';
        CustLedgEntryEndingDate__Document_No__CaptionLbl: Label 'Document No.';
        CustLedgEntryEndingDate__Posting_Date_CaptionLbl: Label 'Posting Date';
        FORMAT_CustLedgEntryEndingDate__Document_Type__CaptionLbl: Label 'Document Type';
        No__ClienteCaptionLbl: Label 'No. Cliente';
        NombreCaptionLbl: Label 'Nombre';
        Total__LCY_CaptionLbl: Label 'Total (LCY)';
        Currency_SpecificationCaptionLbl: Label 'Currency Specification';

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
        lText001: Label 'Es obligatorio introducir la longitud del periodo.';
    begin


        //#3143
        IF FORMAT(PeriodLength) = '' THEN
            ERROR(lText001);
        //#3143


        EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength));
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            PeriodEndDate[1] := 12319999D;
            PeriodStartDate[1] := EndingDate + 1;
        END ELSE BEGIN
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate) + 1;
        END;
        FOR i := 2 TO ARRAYLEN(PeriodEndDate) DO BEGIN
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i]) + 1;
        END;
        PeriodStartDate[i] := 0D;

        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF PeriodEndDate[i] < PeriodStartDate[i] THEN
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            HeaderText[1] := Text000;
            i := 2;
        END ELSE
            i := 1;
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
            IF HeadingType = HeadingType::"Date Interval" THEN
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            ELSE
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        END;
        IF HeadingType = HeadingType::"Date Interval" THEN
            HeaderText[i] := STRSUBSTNO('%1 %2', Text001, PeriodStartDate[i - 1])
        ELSE
            HeaderText[i] := STRSUBSTNO('%1 \%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var CustLedgEntry: Record 21)
    var
        Currency: Record 4;
    begin
        WITH TempCustLedgEntry DO BEGIN
            IF GET(CustLedgEntry."Entry No.") THEN
                EXIT;
            TempCustLedgEntry := CustLedgEntry;
            INSERT;
            IF PrintAmountInLCY THEN BEGIN
                CLEAR(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                IF TempCurrency.INSERT THEN;
                EXIT;
            END;
            IF TempCurrency.GET("Currency Code") THEN
                EXIT;
            IF "Currency Code" <> '' THEN
                Currency.GET("Currency Code")
            ELSE BEGIN
                CLEAR(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            END;
            TempCurrency := Currency;
            TempCurrency.INSERT;
        END;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF Date IN [PeriodStartDate[i] .. PeriodEndDate[i]] THEN
                EXIT(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30]
    begin
        IF b <> 0 THEN
            EXIT(FORMAT(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        IF TempCurrency2.INSERT THEN;
        WITH TempCurrencyAmount DO BEGIN
            FOR i := 1 TO ARRAYLEN(TotalCustLedgEntry) DO BEGIN
                "Currency Code" := CurrencyCode;
                Date := PeriodStartDate[i];
                IF FIND THEN BEGIN
                    Amount := Amount + TotalCustLedgEntry[i]."Remaining Amount";
                    MODIFY;
                END ELSE BEGIN
                    "Currency Code" := CurrencyCode;
                    Date := PeriodStartDate[i];
                    Amount := TotalCustLedgEntry[i]."Remaining Amount";
                    INSERT;
                END;
            END;
            "Currency Code" := CurrencyCode;
            Date := 12319999D;
            IF FIND THEN BEGIN
                Amount := Amount + TotalCustLedgEntry[1].Amount;
                MODIFY;
            END ELSE BEGIN
                "Currency Code" := CurrencyCode;
                Date := 12319999D;
                Amount := TotalCustLedgEntry[1].Amount;
                INSERT;
            END;
        END;
    end;
}

