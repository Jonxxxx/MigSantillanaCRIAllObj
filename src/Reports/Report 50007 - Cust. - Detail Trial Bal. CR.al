report 50007 "Cust. - Detail Trial Bal. CR"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Cust. - Detail Trial Bal. CR.rdlc';
    ApplicationArea = Basic, Suite;
    Caption = 'Customer - Detail Trial Bal. CR';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING(No.);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Date Filter";
            column(TodayFormatted; FORMAT(TODAY))
            {
            }
            column(PeriodCustDatetFilter; STRSUBSTNO(Text000, CustDateFilter))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintDebitCredit; PrintDebitCredit)
            {
            }
            column(CustFilterCaption; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(DebitAmountCaption; DebitLbl)
            {
            }
            column(CreditAmountCaption; CreditLbl)
            {
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
            }
            column(No_Cust; "No.")
            {
            }
            column(Name_Cust; Name)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(CustLedgerEntryAmtLCY; "Cust. Ledger Entry"."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(CustDetailTrialBalCaption; CustDetailTrialBalCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(AllAmtsLCYCaption; AllAmtsLCYCaptionLbl)
            {
            }
            column(RepInclCustsBalCptn; RepInclCustsBalCptnLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(BalanceLCYCaption; BalanceLCYCaptionLbl)
            {
            }
            column(AdjOpeningBalCaption; AdjOpeningBalCaptionLbl)
            {
            }
            column(BeforePeriodCaption; BeforePeriodCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(OpeningBalCaption; OpeningBalCaptionLbl)
            {
            }
            column(ExternalDocNoCaption; ExternalDocNoCaptionLbl)
            {
            }
            column(DireccionLbl; DireccionLbl)
            {
            }
            column(VendedorLbl; VendedorLbl)
            {
            }
            column(PhoneCaptionLbl; PhoneCaptionLbl)
            {
            }
            column(ContactLbl; ContactLbl)
            {
            }
            column(EmailLbl; EmailLbl)
            {
            }
            column(Cust_Phone_No; "Phone No.")
            {
            }
            column(Cust_Address; Address)
            {
            }
            column(Cust_Contact; Contact)
            {
            }
            column(Cust_Vendor_Name; GetSalesPersonName())
            {
            }
            column(Cust_Email; "E-Mail")
            {
            }
            dataitem("Cust. Ledger Entry"; 21)
            {
                DataItemLink = Customer No.=FIELD(No.),
                               Posting Date=FIELD(Date Filter),
                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                               Date Filter=FIELD(Date Filter);
                DataItemTableView = SORTING(Customer No.,Posting Date);
                column(PostDate_CustLedgEntry;FORMAT("Posting Date"))
                {
                }
                column(DocType_CustLedgEntry;"Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_CustLedgEntry;"Document No.")
                {
                    IncludeCaption = true;
                }
                column(ExtDocNo_CustLedgEntry;"External Document No.")
                {
                }
                column(Desc_CustLedgEntry;Description)
                {
                    IncludeCaption = true;
                }
                column(CustAmount;CustAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustDebitAmount;CustDebitAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustCreditAmount;CustCreditAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustRemainAmount;CustRemainAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustEntryDueDate;FORMAT(CustEntryDueDate))
                {
                }
                column(EntryNo_CustLedgEntry;"Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CustCurrencyCode;CustCurrencyCode)
                {
                }
                column(CustBalanceLCY1;CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                begin
                    CustLedgEntryExists := TRUE;
                    IF PrintAmountsInLCY THEN BEGIN
                      CustAmount := "Amount (LCY)";
                      CustRemainAmount := "Remaining Amt. (LCY)";
                      CustCurrencyCode := '';
                    END ELSE BEGIN
                      CustAmount := Amount;
                      CustRemainAmount := "Remaining Amount";
                      CustCurrencyCode := "Currency Code";
                    END;
                    CustDebitAmount := 0;
                    CustCreditAmount := 0;
                    IF CustAmount > 0 THEN
                      CustDebitAmount := CustAmount
                    ELSE
                      CustCreditAmount := -CustAmount;
                    CustTotalDebitAmount += CustDebitAmount;
                    CustTotalCreditAmount += CustCreditAmount;

                    CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                      CustEntryDueDate := 0D
                    ELSE
                      CustEntryDueDate := "Due Date";
                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := FALSE;
                    CustTotalDebitAmount := 0;
                    CustTotalCreditAmount := 0;
                    CustAmount := 0;
                    CustDebitAmount := 0;
                    CustCreditAmount := 0;

                    SETAUTOCALCFIELDS(Amount,"Remaining Amount","Amount (LCY)","Remaining Amt. (LCY)");
                end;
            }
            dataitem("Integer";2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(Name1_Cust;Customer.Name)
                {
                }
                column(CustBalanceLCY4;CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalanceLCY2;StartBalanceLCY)
                {
                }
                column(CustTotalDebitAmount;CustTotalDebitAmount)
                {
                }
                column(CustTotalCreditAmount;CustTotalCreditAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT CustLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                      StartBalanceLCY := 0;
                      CurrReport.SKIP;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintOnlyOnePerPage THEN
                  PageGroupNo := PageGroupNo + 1;

                StartBalanceLCY := 0;
                IF CustDateFilter <> '' THEN BEGIN
                  IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                    SETRANGE("Date Filter",0D,GETRANGEMIN("Date Filter") - 1);
                    CALCFIELDS("Net Change (LCY)");
                    StartBalanceLCY := "Net Change (LCY)";
                  END;
                  SETFILTER("Date Filter",CustDateFilter);
                END;
                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                CustBalanceLCY := StartBalanceLCY;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                CLEAR(StartBalanceLCY);
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
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowAmountsInLCY;PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Amounts in $';
                        ToolTip = 'Specifies if the reported amounts are shown in the local currency.';
                    }
                    field(NewPageperCustomer;PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                    }
                    field(ExcludeCustHaveaBalanceOnly;ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Exclude Customers That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for customers that have a balance but do not have a net change during the selected time period.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit 368;
    begin
        GeneralLedgerSetup.GET;
        PrintDebitCredit := GeneralLedgerSetup."Show Amounts" = GeneralLedgerSetup."Show Amounts"::"Debit/Credit Only";
        CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);
        CustDateFilter := Customer.GETFILTER("Date Filter");
        WITH "Cust. Ledger Entry" DO
          IF PrintAmountsInLCY THEN BEGIN
            AmountCaption := FIELDCAPTION("Amount (LCY)");
            RemainingAmtCaption := FIELDCAPTION("Remaining Amt. (LCY)");
          END ELSE BEGIN
            AmountCaption := FIELDCAPTION(Amount);
            RemainingAmtCaption := FIELDCAPTION("Remaining Amount");
          END;
    end;

    var
        Text000: Label 'Period: %1';
        GeneralLedgerSetup: Record 98;
        PrintDebitCredit: Boolean;
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text;
        CustDateFilter: Text;
        AmountCaption: Text[80];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustDebitAmount: Decimal;
        CustCreditAmount: Decimal;
        CustTotalDebitAmount: Decimal;
        CustTotalCreditAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        CustLedgEntryExists: Boolean;
        PageGroupNo: Integer;
        CustDetailTrialBalCaptionLbl: Label 'Customer - Detail Trial Bal.';
        PageNoCaptionLbl: Label 'Page';
        AllAmtsLCYCaptionLbl: Label 'All amounts are in $';
        RepInclCustsBalCptnLbl: Label 'This report also includes customers that only have balances.';
        PostingDateCaptionLbl: Label 'Posting Date';
        DueDateCaptionLbl: Label 'Due Date';
        BalanceLCYCaptionLbl: Label 'Balance ($)';
        AdjOpeningBalCaptionLbl: Label 'Adj. of Opening Balance';
        BeforePeriodCaptionLbl: Label 'Total ($) Before Period';
        TotalCaptionLbl: Label 'Total ($)';
        OpeningBalCaptionLbl: Label 'Total Adj. of Opening Balance';
        DebitLbl: Label 'Debit Amount';
        CreditLbl: Label 'Credit Amount';
        ExternalDocNoCaptionLbl: Label 'External Doc. No.';
        SalesPerson: Record 13;
        DireccionLbl: Label 'Address';
        VendedorLbl: Label 'Sales person';
        PhoneCaptionLbl: Label 'Phone Number';
        ContactLbl: Label 'Contact';
        EmailLbl: Label 'Email';

    [Scope('Personalization')]
    procedure InitializeRequest(ShowAmountInLCY: Boolean;SetPrintOnlyOnePerPage: Boolean;SetExcludeBalanceOnly: Boolean)
    begin
        PrintOnlyOnePerPage := SetPrintOnlyOnePerPage;
        PrintAmountsInLCY := ShowAmountInLCY;
        ExcludeBalanceOnly := SetExcludeBalanceOnly;
    end;

    procedure GetSalesPersonName(): Text[100]
    begin
        IF SalesPerson.GET(Customer."Salesperson Code") THEN
          EXIT('(' + SalesPerson.Code + ') ' + SalesPerson.Name);
        EXIT('');
    end;
}

