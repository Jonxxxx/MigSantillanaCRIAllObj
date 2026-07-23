report 56527 "Ctas. por cobrar x dias vdos."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Ctas. por cobrar x dias vdos..rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Ctas. por cobrar x dias vdos.';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("Customer Posting Group");
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
            column(PrintCustomers; PrintCustomers)
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
            column(CustBalanceDueLCY_1_; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(Customer__Customer_Posting_Group_; "Customer Posting Group")
            {
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
            column(CustBalanceDueLCY_1__Control29; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(Customer__Customer_Posting_Group__Control1000000012; "Customer Posting Group")
            {
            }
            column(CustBalanceDueLCY_1__Control1000000013; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control1000000014; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control1000000015; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control1000000016; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5__Control1000000017; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control1000000004; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control1000000005; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control1000000006; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control1000000007; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5__Control1000000008; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(Customer__Customer_Posting_Group__Control1000000009; "Customer Posting Group")
            {
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
            column(CustBalanceDueLCY_1__Control35; CustBalanceDueLCY[1])
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
            column(CustBalanceDueLCY_1__Control41; CustBalanceDueLCY[1])
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
            column(CustBalanceDueLCY_1__Control29Caption; CustBalanceDueLCY_1__Control29CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_5_Caption; CustBalanceDueLCY_5_CaptionLbl)
            {
            }
            column(Customer__Customer_Posting_Group_Caption; FIELDCAPTION("Customer Posting Group"))
            {
            }
            column(TotalCaptionCustomer; TotalCaptionCustomerLbl)
            {
            }
            column(CustBalanceDueLCY_5__Control31Caption; CustBalanceDueLCY_5__Control31CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                PrintCust: Boolean;
                i: Integer;
            begin
                IF CustPostGroup.Code <> "Customer Posting Group" THEN
                    IF NOT CustPostGroup.GET("Customer Posting Group") THEN
                        CLEAR(CustPostGroup);

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
                IF NOT PrintCust THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(CustBalanceDueLCY);
            end;
        }
    }

    requestpage
    {
        Caption = 'Print customers';
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
                        Caption = 'Starting Date';
                    }
                    field(PrintCustomers; PrintCustomers)
                    {
                        Caption = 'Print customers';
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
    var
        i: Integer;
    begin
        CustFilter := Customer.GETFILTERS;
        PeriodStartDate[6] := 20991231D;
        PeriodStartDate[5] := StartDate;
        PeriodStartDate[4] := CALCDATE('<-60D>', StartDate);
        FOR i := 3 DOWNTO 2 DO
            PeriodStartDate[i] := CALCDATE('<-30D>', PeriodStartDate[i + 1]);
    end;

    var
        Text001: Label 'As of %1';
        DtldCustLedgEntry: Record 379;
        CustPostGroup: Record 92;
        StartDate: Date;
        CustFilter: Text[250];
        PeriodStartDate: array[6] of Date;
        CustBalanceDueLCY: array[5] of Decimal;
        PrintCustomers: Boolean;
        Customer___Summary_Aging_Simp_CaptionLbl: Label 'Customer - Summary Aging Simp.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in $';
        CustBalanceDueLCY_5__Control25CaptionLbl: Label 'Not Due';
        CustBalanceDueLCY_4__Control26CaptionLbl: Label '0-60 days';
        CustBalanceDueLCY_3__Control27CaptionLbl: Label '61-90 days';
        CustBalanceDueLCY_2__Control28CaptionLbl: Label '91-120 days';
        CustBalanceDueLCY_1__Control29CaptionLbl: Label 'Over 120 days';
        CustBalanceDueLCY_5_CaptionLbl: Label 'Continued';
        TotalCaptionCustomerLbl: Label 'Total';
        CustBalanceDueLCY_5__Control31CaptionLbl: Label 'Continued';
        TotalCaptionLbl: Label 'Total';
}

