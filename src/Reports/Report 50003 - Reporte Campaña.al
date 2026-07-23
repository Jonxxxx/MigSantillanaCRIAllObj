report 50003 "Reporte Campaña"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reporte Campaña.rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Reporte Campaña';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            RequestFilterFields = "Posting Date", "Sell-to Customer No.", "No.";
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(SalespersonCode_SalesInvoiceHeader; "Sales Invoice Header"."Salesperson Code")
            {
            }
            column(ShortcutDimension2Code_SalesInvoiceHeader; "Sales Invoice Header"."Shortcut Dimension 2 Code")
            {
            }
            column(CollectorCode_SalesInvoiceHeader; "Sales Invoice Header"."Collector Code")
            {
            }
            column(CodigoDivisa; "Sales Invoice Header"."Currency Code")
            {
            }
            dataitem("Cust. Ledger Entry"; 21)
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Posting Date" = FIELD("Posting Date");
                DataItemTableView = ORDER(Ascending)
                                    WHERE("Document Type" = CONST(Invoice));
                RequestFilterFields = "Posting Date";
                column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Amount_CustLedgerEntry; "Cust. Ledger Entry".Amount)
                {
                }
                column(CustomerPostingGroup_CustLedgerEntry; "Cust. Ledger Entry"."Customer Posting Group")
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; 379)
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = ORDER(Ascending);
                    RequestFilterFields = "Posting Date";
                    column(PostingDate_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Posting Date")
                    {
                    }
                    column(DocumentType_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Document Type")
                    {
                    }
                    column(DocumentNo_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Document No.")
                    {
                    }
                    column(Amount_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry".Amount)
                    {
                    }
                    column(CustomerNo_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Customer No.")
                    {
                    }
                    column(GrupoContable_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Grupo Contable")
                    {
                    }
                }
            }
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
        CodDiv: Code[20];
}

