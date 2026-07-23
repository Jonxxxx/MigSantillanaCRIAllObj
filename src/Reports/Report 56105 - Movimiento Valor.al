report 56105 "Movimiento Valor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Movimiento Valor.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Value Entry"; 5802)
        {
            DataItemTableView = SORTING("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
            RequestFilterFields = "Item No.", "Document No.", "Posting Date", "Source No.", "Item Ledger Entry Type", "Document Type";
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
            column(Value_Entry__Item_No__; "Item No.")
            {
            }
            column(Value_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Value_Entry__Item_Ledger_Entry_Type_; "Item Ledger Entry Type")
            {
            }
            column(Value_Entry__Source_No__; "Source No.")
            {
            }
            column(Value_Entry__Document_No__; "Document No.")
            {
            }
            column(Invoiced_Quantity___1; "Invoiced Quantity" * -1)
            {
            }
            column(Value_Entry__Cost_per_Unit_; "Cost per Unit")
            {
            }
            column(Value_Entry__Cost_Amount__Actual__; "Cost Amount (Actual)")
            {
            }
            column(Value_EntryCaption; Value_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Value_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Value_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Value_Entry__Item_Ledger_Entry_Type_Caption; FIELDCAPTION("Item Ledger Entry Type"))
            {
            }
            column(Value_Entry__Source_No__Caption; FIELDCAPTION("Source No."))
            {
            }
            column(Value_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(CantidadCaption; CantidadCaptionLbl)
            {
            }
            column(Value_Entry__Cost_per_Unit_Caption; FIELDCAPTION("Cost per Unit"))
            {
            }
            column(Value_Entry__Cost_Amount__Actual__Caption; FIELDCAPTION("Cost Amount (Actual)"))
            {
            }
            column(Cat__ProductoCaption; Cat__ProductoCaptionLbl)
            {
            }
            column(Value_Entry_Entry_No_; "Entry No.")
            {
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
        Value_EntryCaptionLbl: Label 'Value Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        CantidadCaptionLbl: Label 'Cantidad';
        Cat__ProductoCaptionLbl: Label 'Cat. Producto';
}

