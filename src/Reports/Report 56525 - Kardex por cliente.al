report 56525 "Kardex por cliente"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Kardex por cliente.rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Customer - Detail Trial Bal.';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING(No.);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_CustDateFilter_; STRSUBSTNO(Text000, CustDateFilter))
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
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; Customer.TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
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
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY____Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; StartBalanceLCY + "Cust. Ledger Entry"."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY_Control71; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(Customer___Detail_Trial_Bal_Caption; Customer___Detail_Trial_Bal_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(This_report_also_includes_customers_that_only_have_balances_Caption; This_report_also_includes_customers_that_only_have_balances_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; Cust__Ledger_Entry__Posting_Date_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_Type_Caption; Cust__Ledger_Entry__Document_Type_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; "Cust. Ledger Entry".FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; "Cust. Ledger Entry".FIELDCAPTION(Description))
            {
            }
            column(CustEntryDueDateCaption; CustEntryDueDateCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Entry_No__Caption; "Cust. Ledger Entry".FIELDCAPTION("Entry No."))
            {
            }
            column(CustBalanceLCY_Control56Caption; CustBalanceLCY_Control56CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Amount__LCY__Caption; "Cust. Ledger Entry".FIELDCAPTION("Amount (LCY)"))
            {
            }
            column(Cust__Ledger_Entry_AmountCaption; "Cust. Ledger Entry".FIELDCAPTION(Amount))
            {
            }
            column(Cust__Ledger_Entry__Currency_Code_Caption; "Cust. Ledger Entry".FIELDCAPTION("Currency Code"))
            {
            }
            column(Customer__Phone_No__Caption; FIELDCAPTION("Phone No."))
            {
            }
            column(Total__LCY_Caption; Total__LCY_CaptionLbl)
            {
            }
            column(Total__LCY__Before_PeriodCaption_Control16; Total__LCY__Before_PeriodCaption_Control16Lbl)
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            dataitem("Cust. Ledger Entry"; 21)
            {
                DataItemLink = Sell-to Customer No.=FIELD(No.),
                               Posting Date=FIELD(Date Filter),
                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                               Date Filter=FIELD(Date Filter);
                DataItemTableView = SORTING(Customer No.,Posting Date);
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY__;StartBalanceLCY + "Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(Cust__Ledger_Entry__Posting_Date_;FORMAT("Posting Date"))
                {
                }
                column(Cust__Ledger_Entry__Document_Type_;"Document Type")
                {
                }
                column(Cust__Ledger_Entry__Document_No__;"Document No.")
                {
                }
                column(Cust__Ledger_Entry_Description;Description)
                {
                }
                column(CustEntryDueDate;FORMAT(CustEntryDueDate))
                {
                }
                column(Cust__Ledger_Entry__Entry_No__;"Entry No.")
                {
                }
                column(CustBalanceLCY;CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(Cust__Ledger_Entry__Currency_Code_;"Currency Code")
                {
                }
                column(Cust__Ledger_Entry_Amount;Amount)
                {
                }
                column(Cust__Ledger_Entry__Amount__LCY__;"Amount (LCY)")
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY___Control59;StartBalanceLCY + "Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(ContinuedCaption;ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control46;ContinuedCaption_Control46Lbl)
                {
                }
                column(Cust__Ledger_Entry_Sell_to_Customer_No_;"Sell-to Customer No.")
                {
                }
                column(Cust__Ledger_Entry_Posting_Date;"Posting Date")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_2_Code;"Global Dimension 2 Code")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_1_Code;"Global Dimension 1 Code")
                {
                }
                column(Cust__Ledger_Entry_Date_Filter;"Date Filter")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Amount (LCY)");

                    CustLedgEntryExists := TRUE;
                    CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                      CustEntryDueDate := 0D
                    ELSE
                      CustEntryDueDate := "Due Date";
                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := FALSE;
                    CurrReport.CREATETOTALS("Amount (LCY)");
                end;
            }
            dataitem("Integer";2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(CustBalanceLCY_Control62;CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalanceLCY_footer;StartBalanceLCY)
                {
                }
                column(Customer_Name_Control48;Customer.Name)
                {
                }
                column(Integer_Number;Number)
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
                IF ISSERVICETIER THEN BEGIN
                  IF PrintOnlyOnePerPage THEN
                    PageGroupNo := PageGroupNo + 1;
                END;

                StartBalanceLCY := 0;
                IF CustDateFilter <> '' THEN BEGIN
                  IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                    SETRANGE("Date Filter",0D,GETRANGEMIN("Date Filter") - 1);
                    CALCFIELDS("Net Change (LCY)");
                    StartBalanceLCY := "Net Change (LCY)";
                    SETFILTER("Date Filter", CustDateFilter);
                  END;
                END;
                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                CustBalanceLCY := StartBalanceLCY;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                CurrReport.CREATETOTALS("Cust. Ledger Entry"."Amount (LCY)",StartBalanceLCY);
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
                    field(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Customer';
                    }
                    field(ExcludeBalanceOnly;ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude Customers That Have a Balance Only';
                        MultiLine = true;
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
    begin
        CustFilter := Customer.GETFILTERS;
        CustDateFilter := Customer.GETFILTER("Date Filter");
    end;

    var
        Text000: Label 'Period: %1';
        CustLedgEntry: Record 21;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text[250];
        CustDateFilter: Text[30];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        Text001: Label 'Appln Rounding:';
        CustBalanceLCY: Decimal;
        CustLedgEntryExists: Boolean;
        PageGroupNo: Integer;
        Customer___Detail_Trial_Bal_CaptionLbl: Label 'KARDEX BY CUSTOMER (Detailed)';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        This_report_also_includes_customers_that_only_have_balances_CaptionLbl: Label 'This report also includes customers that only have balances.';
        Cust__Ledger_Entry__Posting_Date_CaptionLbl: Label 'Posting Date';
        Cust__Ledger_Entry__Document_Type_CaptionLbl: Label 'Document Type';
        CustEntryDueDateCaptionLbl: Label 'Due Date';
        CustBalanceLCY_Control56CaptionLbl: Label 'Balance ($)';
        Total__LCY_CaptionLbl: Label 'Total ($)';
        Total__LCY__Before_PeriodCaption_Control16Lbl: Label 'Total ($) Before Period';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption_Control46Lbl: Label 'Continued';
}

