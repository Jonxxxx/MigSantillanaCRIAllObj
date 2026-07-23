report 56528 "Pendiente cobro x campaña"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Pendiente cobro x campaña.rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Pendiente cobro x campaña';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Integer"; 2000000026)
        {
            DataItemTableView = SORTING(Number);
            MaxIteration = 1;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(STRSUBSTNO_Text001_FORMAT_StartDate__; STRSUBSTNO(Text001, FORMAT(StartDate)))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; "Salesperson/Purchaser".TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(DueAmount_OldDueAmount_Control40; DueAmount + OldDueAmount)
            {
                AutoFormatType = 1;
            }
            column(OldDueAmount_Control39; OldDueAmount)
            {
                AutoFormatType = 1;
            }
            column(DueAmount_SalesAmount_Control41; GetPercent(SalesAmount, DueAmount))
            {
                AutoFormatType = 1;
            }
            column(DueAmount_Control38; DueAmount)
            {
                AutoFormatType = 1;
            }
            column(SalesAmount_Control37; SalesAmount)
            {
                AutoFormatType = 1;
            }
            column(Customer___Summary_Aging_Simp_Caption; Customer___Summary_Aging_Simp_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Customer__No__Caption; "Salesperson/Purchaser".FIELDCAPTION(Code))
            {
            }
            column(Customer_NameCaption; "Salesperson/Purchaser".FIELDCAPTION(Name))
            {
            }
            column(SalesAmount_Caption; SalesAmount_CaptionLbl)
            {
            }
            column(DueAmount_Caption; DueAmount_CaptionLbl)
            {
            }
            column(OldDueAmount_Caption; OldDueAmount_CaptionLbl)
            {
            }
            column(DueAmount_OldDueAmount_Caption; DueAmount_OldDueAmount_CaptionLbl)
            {
            }
            column(DueAmount_SalesAmount_Caption; DueAmount_SalesAmount_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }
            dataitem("Salesperson/Purchaser"; 13)
            {
                RequestFilterFields = "Code", "Home Page";
                column(Customer_Name; Name)
                {
                }
                column(DueAmount_OldDueAmount; DueAmount + OldDueAmount)
                {
                    AutoFormatType = 1;
                }
                column(OldDueAmount; OldDueAmount)
                {
                    AutoFormatType = 1;
                }
                column(DueAmount_SalesAmount; GetPercent(SalesAmount, DueAmount))
                {
                    AutoFormatType = 1;
                }
                column(DueAmount; DueAmount)
                {
                    AutoFormatType = 1;
                }
                column(SalesAmount; SalesAmount)
                {
                    AutoFormatType = 1;
                }
                column(Customer__No__; Code)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SalesAmount := 0;
                    DueAmount := 0;
                    OldDueAmount := 0;

                    CustLedgEntry.SETCURRENTKEY("Salesperson Code", "Posting Date");
                    CustLedgEntry.SETRANGE("Salesperson Code", Code);
                    CustLedgEntry.SETRANGE("Posting Date", BeginDate, EndDate);
                    CustLedgEntry.SETFILTER("Document Type", '%1|%2',
                      CustLedgEntry."Document Type"::Invoice,
                      CustLedgEntry."Document Type"::"Credit Memo");
                    IF CustLedgEntry.FINDSET THEN
                        REPEAT
                            CustLedgEntry.CALCFIELDS("Original Amt. (LCY)", "Remaining Amt. (LCY)");
                            SalesAmount += CustLedgEntry."Original Amt. (LCY)";
                            DueAmount += CustLedgEntry."Remaining Amt. (LCY)";
                        UNTIL CustLedgEntry.NEXT = 0;

                    CustLedgEntry.SETRANGE("Posting Date", 0D, BeginDate - 1);
                    IF CustLedgEntry.FINDSET THEN
                        REPEAT
                            CustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
                            OldDueAmount := CustLedgEntry."Remaining Amt. (LCY)";
                        UNTIL CustLedgEntry.NEXT = 0;

                    IF (SalesAmount = 0) AND (DueAmount = 0) AND (OldDueAmount = 0) THEN
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(SalesAmount, DueAmount, OldDueAmount);
                end;
            }
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
                    field(StartDate; StartDate)
                    {
                        Caption = 'Campaign Starting Date';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF StartDate = 0D THEN
                StartDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CustFilter := "Salesperson/Purchaser".GETFILTERS;

        BeginDate := StartDate;
        EndDate := CALCDATE('<+1Y>', BeginDate);
    end;

    var
        Text001: Label 'As of %1';
        DtldCustLedgEntry: Record 379;
        CustLedgEntry: Record 21;
        CustPostGroup: Record 92;
        StartDate: Date;
        BeginDate: Date;
        EndDate: Date;
        CustFilter: Text[250];
        i: Integer;
        SalesAmount: Decimal;
        DueAmount: Decimal;
        OldDueAmount: Decimal;
        Customer___Summary_Aging_Simp_CaptionLbl: Label 'REMAINING AMOUNT BY SALESPERSON (CURRENTY AND PREVIOUS CAMPAIGN)';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in $';
        SalesAmount_CaptionLbl: Label 'Sales Campaign';
        DueAmount_CaptionLbl: Label 'Open amount';
        OldDueAmount_CaptionLbl: Label 'Old Open amount';
        DueAmount_OldDueAmount_CaptionLbl: Label 'Total open amount';
        DueAmount_SalesAmount_CaptionLbl: Label '% Open amount';
        TotalCaptionLbl: Label 'Total';

    procedure GetPercent(SalesAmount: Decimal; DueAmount: Decimal): Decimal
    begin
        IF (SalesAmount = 0) OR (DueAmount = 0) THEN
            EXIT(0)
        ELSE
            EXIT((DueAmount / SalesAmount) * 100);
    end;
}

