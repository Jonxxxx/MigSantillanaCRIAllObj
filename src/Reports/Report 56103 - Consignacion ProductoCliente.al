report 56103 "Consignacion Producto/Cliente"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Consignacion ProductoCliente.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Item No.", Positive, "Location Code", Variant Code);
            RequestFilterFields = "Item No.", Positive, "Location Code";
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
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial_; "Importe Cons. bruto Inicial")
            {
            }
            column(Item_Ledger_Entry__Invoiced_Quantity_; "Invoiced Quantity")
            {
            }
            column(Item_Ledger_Entry__Location_Code_; "Location Code")
            {
            }
            column(Item_Ledger_Entry__Descripcion_Producto_; "Descripcion Producto")
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(TotalFor___FIELDCAPTION__Item_No___; TotalFor + FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry__Invoiced_Quantity__Control1000000043; "Invoiced Quantity")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial__Control1000000044; "Importe Cons. bruto Inicial")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial__Control1000000045; "Importe Cons. Neto Inicial")
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry__Descripcion_Producto_Caption; FIELDCAPTION("Descripcion Producto"))
            {
            }
            column(Item_Ledger_Entry__Location_Code_Caption; FIELDCAPTION("Location Code"))
            {
            }
            column(Item_Ledger_Entry__Invoiced_Quantity_Caption; FIELDCAPTION("Invoiced Quantity"))
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial_Caption; FIELDCAPTION("Importe Cons. bruto Inicial"))
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial_Caption; FIELDCAPTION("Importe Cons. Neto Inicial"))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Item_Ledger_Entry_Positive; Positive)
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Location Code");
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
        Item_Ledger_EntryCaptionLbl: Label 'Item Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
}

