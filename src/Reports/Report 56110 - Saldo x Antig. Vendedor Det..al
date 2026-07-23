report 56110 "Saldo x Antig. Vendedor Det."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Saldo x Antig. Vendedor Det..rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cust. Ledger Entry"; 21)
        {
            DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");
            RequestFilterFields = "Customer No.", "Document No.", "Salesperson Code";
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
            column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Cust__Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Cust__Ledger_Entry__Currency_Code_; "Currency Code")
            {
            }
            column(Cust__Ledger_Entry__Remaining_Amt___LCY__; "Remaining Amt. (LCY)")
            {
            }
            column(Cust__Ledger_Entry__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(TotalFor___FIELDCAPTION__Customer_No___; TotalFor + FIELDCAPTION("Customer No."))
            {
            }
            column(Cust__Ledger_Entry__Remaining_Amt___LCY___Control1000000037; "Remaining Amt. (LCY)")
            {
            }
            column(Cust__Ledger_EntryCaption; Cust__Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption; FIELDCAPTION("Customer No."))
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column("DescripcionCaption"; DescripcionCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
            {
            }
            column(Cust__Ledger_Entry__Remaining_Amt___LCY__Caption; FIELDCAPTION("Remaining Amt. (LCY)"))
            {
            }
            column(Cust__Ledger_Entry__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
            {
            }
            column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total para ';
        Cust__Ledger_EntryCaptionLbl: Label 'Cust. Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        "DescripcionCaptionLbl": Label 'Descripcion';
}

