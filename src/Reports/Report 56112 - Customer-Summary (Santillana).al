report 56112 "Customer-Summary (Santillana)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Customer-Summary (Santillana).rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Customer - Summary Aging Simp.';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Statistics Group", "Payment Terms Code";
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
            column(Customer_TABLECAPTION__________CustFilter; Customer.TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(CustBalanceDueLCY_5_; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4_; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3_; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2_; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY120; CustBalanceDueLCY120)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY180; CustBalanceDueLCY180)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY270; CustBalanceDueLCY270)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCYMas270; CustBalanceDueLCYMas270)
            {
                AutoFormatType = 1;
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CustBalanceDueLCY_5__Control25; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control26; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control27; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control28; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY120_Control1000000005; CustBalanceDueLCY120)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY180_Control1000000009; CustBalanceDueLCY180)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY270_Control1000000013; CustBalanceDueLCY270)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCYMas270_Control1000000017; CustBalanceDueLCYMas270)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5__Control31; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control32; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control33; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control34; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY120_Control1000000006; CustBalanceDueLCY120)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY180_Control1000000010; CustBalanceDueLCY180)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY270_Control1000000014; CustBalanceDueLCY270)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCYMas270_Control1000000018; CustBalanceDueLCYMas270)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5__Control37; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control38; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control39; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control40; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY120_Control1000000007; CustBalanceDueLCY120)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY180_Control1000000011; CustBalanceDueLCY180)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY270_Control1000000015; CustBalanceDueLCY270)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCYMas270_Control1000000019; CustBalanceDueLCYMas270)
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
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(CustBalanceDueLCY_5__Control25Caption; CustBalanceDueLCY_5__Control25CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_4__Control26Caption; CustBalanceDueLCY_4__Control26CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_3__Control27Caption; CustBalanceDueLCY_3__Control27CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_2__Control28Caption; CustBalanceDueLCY_2__Control28CaptionLbl)
            {
            }
            column(V91_120Caption; V91_120CaptionLbl)
            {
            }
            column(V121_180Caption; V121_180CaptionLbl)
            {
            }
            column(V181_270Caption; V181_270CaptionLbl)
            {
            }
            column(Mas_270Caption; Mas_270CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_5_Caption; CustBalanceDueLCY_5_CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_5__Control31Caption; CustBalanceDueLCY_5__Control31CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PrintCust := FALSE;
                FOR i := 1 TO 5 DO BEGIN
                    DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                    DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                    DtldCustLedgEntry.SETRANGE("Posting Date", 0D, StartDate);
                    DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
                    CustBalanceDueLCY[i] := DtldCustLedgEntry."Amount (LCY)";
                    IF CustBalanceDueLCY[i] <> 0 THEN
                        PrintCust := TRUE;
                END;

                //120
                DtldCustLedgEntry1.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                DtldCustLedgEntry1.SETRANGE("Customer No.", "No.");
                DtldCustLedgEntry1.SETRANGE("Posting Date", 0D, StartDate);
                DtldCustLedgEntry1.SETRANGE("Initial Entry Due Date", PeriodStartDate120, PeriodStartDate[2] - 1);
                DtldCustLedgEntry1.CALCSUMS("Amount (LCY)");
                CustBalanceDueLCY120 := DtldCustLedgEntry1."Amount (LCY)";

                //180
                DtldCustLedgEntry1.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                DtldCustLedgEntry1.SETRANGE("Customer No.", "No.");
                DtldCustLedgEntry1.SETRANGE("Posting Date", 0D, StartDate);
                DtldCustLedgEntry1.SETRANGE("Initial Entry Due Date", PeriodStartDate180, PeriodStartDate120 - 1);
                DtldCustLedgEntry1.CALCSUMS("Amount (LCY)");
                CustBalanceDueLCY180 := DtldCustLedgEntry1."Amount (LCY)";

                //270
                DtldCustLedgEntry1.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                DtldCustLedgEntry1.SETRANGE("Customer No.", "No.");
                DtldCustLedgEntry1.SETRANGE("Posting Date", 0D, StartDate);
                DtldCustLedgEntry1.SETRANGE("Initial Entry Due Date", PeriodStartDate270, PeriodStartDate180 - 1);
                DtldCustLedgEntry1.CALCSUMS("Amount (LCY)");
                CustBalanceDueLCY270 := DtldCustLedgEntry1."Amount (LCY)";

                //MAS 270
                DtldCustLedgEntry1.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                DtldCustLedgEntry1.SETRANGE("Customer No.", "No.");
                DtldCustLedgEntry1.SETRANGE("Posting Date", 0D, StartDate);
                DtldCustLedgEntry1.SETRANGE("Initial Entry Due Date", PeriodStartDate[1], PeriodStartDate270 - 1);
                DtldCustLedgEntry1.CALCSUMS("Amount (LCY)");
                CustBalanceDueLCYMas270 := DtldCustLedgEntry1."Amount (LCY)";


                IF NOT PrintCust THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(CustBalanceDueLCY, CustBalanceDueLCY120, CustBalanceDueLCY180, CustBalanceDueLCY270, CustBalanceDueLCYMas270);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        Caption = 'Starting Date';
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
        CustFilter := Customer.GETFILTERS;
        PeriodStartDate[5] := StartDate;
        PeriodStartDate[6] := 20991231D;
        FOR i := 4 DOWNTO 2 DO
            PeriodStartDate[i] := CALCDATE('<-30D>', PeriodStartDate[i + 1]);

        PeriodStartDate120 := CALCDATE('<-30D>', PeriodStartDate[i]);
        PeriodStartDate180 := CALCDATE('<-60D>', PeriodStartDate120);
        PeriodStartDate270 := CALCDATE('<-90D>', PeriodStartDate180);
    end;

    var
        Text001: Label 'As of %1';
        DtldCustLedgEntry: Record 379;
        StartDate: Date;
        CustFilter: Text[250];
        PeriodStartDate: array[6] of Date;
        CustBalanceDueLCY: array[5] of Decimal;
        PrintCust: Boolean;
        i: Integer;
        CustBalanceDueLCY120: Decimal;
        CustBalanceDueLCY180: Decimal;
        CustBalanceDueLCY270: Decimal;
        CustBalanceDueLCYMas270: Decimal;
        PeriodStartDate120: Date;
        PeriodStartDate180: Date;
        PeriodStartDate270: Date;
        PeriodStartDateMas270: Date;
        DtldCustLedgEntry1: Record 379;
        Customer___Summary_Aging_Simp_CaptionLbl: Label 'Customer - Summary Aging Simp.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in $';
        CustBalanceDueLCY_5__Control25CaptionLbl: Label 'Saldo';
        CustBalanceDueLCY_4__Control26CaptionLbl: Label '0-30 days';
        CustBalanceDueLCY_3__Control27CaptionLbl: Label '31-60 days';
        CustBalanceDueLCY_2__Control28CaptionLbl: Label '61-90 days';
        V91_120CaptionLbl: Label '91-120';
        V121_180CaptionLbl: Label '121-180';
        V181_270CaptionLbl: Label '181-270';
        Mas_270CaptionLbl: Label 'Mas 270';
        CustBalanceDueLCY_5_CaptionLbl: Label 'Continued';
        CustBalanceDueLCY_5__Control31CaptionLbl: Label 'Continued';
        TotalCaptionLbl: Label 'Total';
}

