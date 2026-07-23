report 56076 "Reporte Recibos de Ingresos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reporte Recibos de Ingresos.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cust. Ledger Entry"; 21)
        {
            DataItemTableView = SORTING(Document No., Document Type, Customer No.);
            RequestFilterFields = "Document No.", "Posting Date", "Document Type";
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
            column(Cust__Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
            {
            }
            column(Cust__Ledger_Entry_Description; Description)
            {
            }
            column(Cust__Ledger_Entry__Currency_Code_; "Currency Code")
            {
            }
            column(Cust__Ledger_Entry_Amount; Amount)
            {
            }
            column(Cust__Ledger_Entry__Amount__LCY__; "Amount (LCY)")
            {
            }
            column(Cust__Ledger_Entry__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(Cust__Ledger_Entry__Applies_to_Doc__No__; "Applies-to Doc. No.")
            {
            }
            column(Cust__Ledger_EntryCaption; Cust__Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption; FIELDCAPTION("Customer No."))
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Cust__Ledger_Entry__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
            {
            }
            column(Cust__Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Cust__Ledger_Entry__Amount__LCY__Caption; FIELDCAPTION("Amount (LCY)"))
            {
            }
            column(Cust__Ledger_Entry__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
            {
            }
            column(Cust__Ledger_Entry__Applies_to_Doc__No__Caption; FIELDCAPTION("Applies-to Doc. No."))
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
}

