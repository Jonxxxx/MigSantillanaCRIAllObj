report 56111 "Aged Accounts Receivable-365D"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Aged Accounts Receivable-365D.rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Aged Accounts Receivable';
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
            column(TABLECAPTION__________CustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(AgingBy; AgingBy)
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
            column(HeaderText_5__Control8; HeaderText[5])
            {
            }
            column(HeaderText_4__Control11; HeaderText[4])
            {
            }
            column(HeaderText_3__Control12; HeaderText[3])
            {
            }
            column(HeaderText_2__Control13; HeaderText[2])
            {
            }
            column(HeaderText_1__Control14; HeaderText[1])
            {
            }
            column(HeaderText_1__Control36; HeaderText[1])
            {
            }
            column(HeaderText_2__Control37; HeaderText[2])
            {
            }
            column(HeaderText_3__Control38; HeaderText[3])
            {
            }
            column(HeaderText_4__Control39; HeaderText[4])
            {
            }
            column(HeaderText_5__Control40; HeaderText[5])
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
            column(CustLedgEntryEndingDate__Remaining_Amt___LCY__Caption; CustLedgEntryEndingDate__Remaining_Amt___LCY__CaptionLbl)
            {
            }
            column(CustLedgEntryEndingDate__Amount__LCY__Caption; CustLedgEntryEndingDate__Amount__LCY__CaptionLbl)
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
            column(SaldoAcumCaption; SaldoAcumCaptionLbl)
            {
            }
            column(Customer__No___Control9Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_Name_Control15Caption; FIELDCAPTION(Name))
            {
            }
            column(TotalCustLedgEntry_1___Amount__LCY___Control1000000010Caption; TotalCustLedgEntry_1___Amount__LCY___Control1000000010CaptionLbl)
            {
            }
            column(SaldoAcumUSDCaption; SaldoAcumUSDCaptionLbl)
            {
            }
            column(Customer__No___Control31Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_Name_Control30Caption; FIELDCAPTION(Name))
            {
            }
            column(TotalCustLedgEntry_1__Amount_Control24Caption; TotalCustLedgEntry_1__Amount_Control24CaptionLbl)
            {
            }
            column(CurrencyCode_Control32Caption; CurrencyCode_Control32CaptionLbl)
            {
            }
            column(Saldo_AcumuladoCaption; Saldo_AcumuladoCaptionLbl)
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
                    IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            InsertTemp(CustLedgEntry);
                        UNTIL CustLedgEntry.NEXT = 0;

                    IF "Closed by Entry No." <> 0 THEN BEGIN
                        CustLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                InsertTemp(CustLedgEntry);
                            UNTIL CustLedgEntry.NEXT = 0;
                    END;


                    CustLedgEntry.RESET;
                    CustLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
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
                DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", Currency Code);

                trigger OnAfterGetRecord()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        CALCFIELDS("Remaining Amt. (LCY)");
                        IF "Remaining Amt. (LCY)" = 0 THEN
                            CurrReport.SKIP;
                    END;

                    InsertTemp(OpenCustLedgEntry);
                end;

                trigger OnPreDataItem()
                begin
                    IF AgingBy = AgingBy::"Posting Date" THEN BEGIN
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                    END;
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
                    column(Customer_Name; Customer.Name)
                    {
                    }
                    column(Customer__No__; Customer."No.")
                    {
                    }
                    column(CustLedgEntryEndingDate__Remaining_Amt___LCY__; CustLedgEntryEndingDate."Remaining Amt. (LCY)")
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
                    column(CustLedgEntryEndingDate__Amount__LCY__; CustLedgEntryEndingDate."Amount (LCY)")
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
                    column(SaldoAcum; SaldoAcum)
                    {
                        AutoFormatType = 1;
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
                    column(CustLedgEntryEndingDate__Remaining_Amount_; CustLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntryEndingDate_Amount; CustLedgEntryEndingDate.Amount)
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
                    column(SaldoAcumUSD; SaldoAcumUSD)
                    {
                        AutoFormatType = 1;
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
                    column(TotalCustLedgEntry_5___Remaining_Amt___LCY___Control23; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_4___Remaining_Amt___LCY___Control22; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_3___Remaining_Amt___LCY___Control20; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_2___Remaining_Amt___LCY___Control19; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_1___Remaining_Amt___LCY___Control18; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCustLedgEntry_1___Amount__LCY___Control1000000010; TotalCustLedgEntry[1]."Amount (LCY)")
                    {
                    }
                    column(Customer_Name_Control15; Customer.Name)
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
                    column(TempCustLedgEntryLoop_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        CustLedgEntry: Record 21;
                        PeriodIndex: Integer;
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempCustLedgEntry.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF TempCustLedgEntry.NEXT = 0 THEN
                                CurrReport.BREAK;

                        CustLedgEntryEndingDate := TempCustLedgEntry;
                        DetailedCustomerLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryEndingDate."Entry No.");
                        IF DetailedCustomerLedgerEntry.FINDSET THEN
                            REPEAT
                                IF (DetailedCustomerLedgerEntry."Entry Type" =
                                    DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") AND
                                   (CustLedgEntryEndingDate."Posting Date" > EndingDate) AND
                                   (AgingBy <> AgingBy::"Posting Date")
                                THEN BEGIN
                                    IF CustLedgEntryEndingDate."Document Date" <= EndingDate THEN
                                        DetailedCustomerLedgerEntry."Posting Date" :=
                                          CustLedgEntryEndingDate."Document Date"
                                    ELSE
                                        IF (CustLedgEntryEndingDate."Due Date" <= EndingDate) AND
                                           (AgingBy = AgingBy::"Due Date")
                                        THEN
                                            DetailedCustomerLedgerEntry."Posting Date" :=
                                              CustLedgEntryEndingDate."Due Date"
                                END;

                                IF DetailedCustomerLedgerEntry."Posting Date" <= EndingDate THEN BEGIN
                                    IF DetailedCustomerLedgerEntry."Entry Type" IN
                                      [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                       DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                    THEN BEGIN
                                        CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                        CustLedgEntryEndingDate."Amount (LCY)" :=
                                          CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    END;
                                    CustLedgEntryEndingDate."Remaining Amount" :=
                                      CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                    CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                      CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                END;
                            UNTIL DetailedCustomerLedgerEntry.NEXT = 0;

                        IF CustLedgEntryEndingDate."Remaining Amount" = 0 THEN
                            CurrReport.SKIP;

                        CASE AgingBy OF
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                BEGIN
                                    IF CustLedgEntryEndingDate."Document Date" > EndingDate THEN BEGIN
                                        CustLedgEntryEndingDate."Remaining Amount" := 0;
                                        CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
                                    END;
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                                END;
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

                        //GRN Para acumular el saldo por linea
                        IF CustLedgEntryEndingDate."Remaining Amt. (LCY)" <> CustLedgEntryEndingDate."Remaining Amount" THEN
                            SaldoAcum += CustLedgEntryEndingDate."Remaining Amt. (LCY)";

                        SaldoAcumUSD += CustLedgEntryEndingDate."Remaining Amount";

                        IF PrintToExcel THEN
                            MakeExcelDataBody;
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
                        IF NOT TempCurrency.FINDSET(FALSE, FALSE) THEN
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
                    CurrReport.CREATETOTALS(SaldoAcumUSD, SaldoAcum);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TempCurrency.RESET;
                TempCurrency.DELETEALL;
                TempCustLedgEntry.RESET;
                TempCustLedgEntry.DELETEALL;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(SaldoAcumUSD, SaldoAcum);
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
            column(SaldoAcum_Control1000000006; SaldoAcum)
            {
                AutoFormatType = 1;
            }
            column(CurrencyTotals_CurrencyTotals_Number; CurrencyTotals.Number)
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
            column(AgedCustLedgEntry_3___Remaining_Amount__Control114; AgedCustLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_2___Remaining_Amount__Control115; AgedCustLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCustLedgEntry_6___Remaining_Amount__Control116; AgedCustLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(SaldoAcumUSD_Control1000000005; SaldoAcumUSD)
            {
                AutoFormatType = 1;
            }
            column(Currency_SpecificationCaption; Currency_SpecificationCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT TempCurrency2.FINDSET(FALSE, FALSE) THEN
                        CurrReport.BREAK;
                END ELSE
                    IF TempCurrency2.NEXT = 0 THEN
                        CurrReport.BREAK;

                CLEAR(AgedCustLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
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
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Imprimir en excel';
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
            PrintToExcel := FALSE;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;

        GLSetup.GET;

        CalcDates;
        CreateHeadings;

        IF PrintToExcel THEN
            MakeExcelInfo;
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
        ExcelBuf: Record 370 temporary;
        DetailedCustomerLedgerEntry: Record 379;
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
        PrintToExcel: Boolean;
        Text011: Label 'Data';
        Text012: Label 'Aged Accounts Receivable';
        Text013: Label 'Company Name';
        Text014: Label 'Report No.';
        Text015: Label 'Report Name';
        Text016: Label 'User ID';
        Text017: Label 'Date';
        Text018: Label 'Customer Filters';
        Text019: Label 'Cust. Ledger Entry Filters';
        SaldoAcum: Decimal;
        SaldoAcumUSD: Decimal;
        Aged_Accounts_ReceivableCaptionLbl: Label 'Aged Accounts Receivable';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_Amounts_in_LCYCaptionLbl: Label 'All Amounts in LCY';
        Aged_Overdue_AmountsCaptionLbl: Label 'Aged Overdue Amounts';
        CustLedgEntryEndingDate__Remaining_Amt___LCY__CaptionLbl: Label 'Balance';
        CustLedgEntryEndingDate__Amount__LCY__CaptionLbl: Label 'Original Amount ';
        CustLedgEntryEndingDate__Due_Date_CaptionLbl: Label 'Due Date';
        CustLedgEntryEndingDate__Document_No__CaptionLbl: Label 'Document No.';
        CustLedgEntryEndingDate__Posting_Date_CaptionLbl: Label 'Posting Date';
        FORMAT_CustLedgEntryEndingDate__Document_Type__CaptionLbl: Label 'Document Type';
        SaldoAcumCaptionLbl: Label 'Summary Balance';
        TotalCustLedgEntry_1___Amount__LCY___Control1000000010CaptionLbl: Label 'Balance';
        SaldoAcumUSDCaptionLbl: Label 'Summary Balance';
        TotalCustLedgEntry_1__Amount_Control24CaptionLbl: Label 'Balance';
        CurrencyCode_Control32CaptionLbl: Label 'Currency Code';
        Saldo_AcumuladoCaptionLbl: Label 'Saldo Acumulado';
        Total__LCY_CaptionLbl: Label 'Total (LCY)';
        Currency_SpecificationCaptionLbl: Label 'Currency Specification';

    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength));
        IF AgingBy = AgingBy::"Due Date" THEN BEGIN
            PeriodEndDate[1] := 12319999D;
            PeriodStartDate[1] := EndingDate + 1;
        END ELSE BEGIN
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        END;
        FOR i := 2 TO ARRAYLEN(PeriodEndDate) DO BEGIN
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
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

    procedure MakeExcelInfo()
    begin
        /*//fes mig
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text013),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text015),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text012),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text014),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::Report120,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text016),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text017),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text018),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Customer.GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text019),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("Cust. Ledger Entry".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        IF PrintAmountInLCY THEN BEGIN
          ExcelBuf.NewRow;
          ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddInfoColumn(PrintAmountInLCY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(COPYSTR(Text004,1,7)),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(SELECTSTR(AgingBy + 1,Text009)),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        */

    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer.FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Posting Date"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Document Type"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Document No."), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Due Date"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        IF NOT PrintAmountInLCY THEN BEGIN
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Currency Code"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Original Amount"), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Remaining Amount"), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        END ELSE BEGIN
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Original Amt. (LCY)"), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Remaining Amt. (LCY)"), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        END;
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(TempCustLedgEntry."Document Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Due Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintAmountInLCY THEN BEGIN
            ExcelBuf.AddColumn(CustLedgEntryEndingDate."Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(CustLedgEntryEndingDate."Remaining Amt. (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END ELSE BEGIN
            ExcelBuf.AddColumn(CurrencyCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(CustLedgEntryEndingDate.Amount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(CustLedgEntryEndingDate."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
    end;

    procedure CreateExcelbook()
    begin
        //fes mig ExcelBuf.CreateBookAndOpenExcel(Text011,Text012,COMPANYNAME,USERID);
        ERROR('');
    end;
}

