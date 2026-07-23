report 56133 "Informe Detalle Consignacion"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Informe Detalle Consignacion.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");
            RequestFilterFields = "Item No.", "Location Code", "Posting Date", "Document No.", "Entry Type";
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Item_Ledger_Entry__Location_Code_; "Location Code")
            {
            }
            column(Item_Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Item_Ledger_Entry__Item_No___Control1000000018; "Item No.")
            {
            }
            column(Item_Ledger_Entry__Descripcion_Producto_; "Descripcion Producto")
            {
            }
            column(Invoiced_Quantity___1; "Invoiced Quantity" * -1)
            {
            }
            column(Importe_Cons__bruto_Inicial___1; "Importe Cons. bruto Inicial" * -1)
            {
            }
            column(Importe_Cons__Neto_Inicial___1; "Importe Cons. Neto Inicial" * -1)
            {
            }
            column(TotalFor___FIELDCAPTION__Item_No___; TotalFor + FIELDCAPTION("Item No."))
            {
            }
            column(Invoiced_Quantity___1_Control1000000033; "Invoiced Quantity" * -1)
            {
            }
            column(Importe_Cons__bruto_Inicial___1_Control1000000034; "Importe Cons. bruto Inicial" * -1)
            {
            }
            column(Importe_Cons__Neto_Inicial___1_Control1000000035; "Importe Cons. Neto Inicial" * -1)
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Location_Code_Caption; FIELDCAPTION("Location Code"))
            {
            }
            column(Item_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Item_Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Item_Ledger_Entry__Item_No___Control1000000018Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry__Descripcion_Producto_Caption; FIELDCAPTION("Descripcion Producto"))
            {
            }
            column(Invoiced_Quantity___1Caption; Invoiced_Quantity___1CaptionLbl)
            {
            }
            column(Vta__NetaCaption; Vta__NetaCaptionLbl)
            {
            }
            column("Vta__LiquidaCaption"; Vta__LiquidaCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Item No.");
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
        PageConst: Label 'Página';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total para ';
        Item_Ledger_EntryCaptionLbl: Label 'Item Ledger Entry';
        Invoiced_Quantity___1CaptionLbl: Label 'Label1000000025';
        Vta__NetaCaptionLbl: Label 'Vta. Neta';
        "Vta__LiquidaCaptionLbl": Label 'Vta. Liquida';
}

