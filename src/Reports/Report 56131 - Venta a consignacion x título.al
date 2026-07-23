report 56131 "Venta a consignacion x titulo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Venta a consignacion x titulo.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Location Code");
            RequestFilterFields = "Document No.", "Remaining Quantity", "Item No.", "Location Code", "Global Dimension 1 Code", "Posting Date";
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
            column(Item_Ledger_Entry__Location_Code_; "Location Code")
            {
            }
            column(Item_Ledger_Entry__Location_Code__Control1000000011; "Location Code")
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Item_Ledger_Entry__Descripcion_Producto_; "Descripcion Producto")
            {
            }
            column(Item_Ledger_Entry__Remaining_Quantity_; "Remaining Quantity")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial_; "Importe Cons. bruto Inicial")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
            {
            }
            column(TotalFor___FIELDCAPTION__Location_Code__; TotalFor + ' ' + "Location Code")
            {
            }
            column(Item_Ledger_Entry__Remaining_Quantity__Control1000000029; "Remaining Quantity")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial__Control1000000030; "Importe Cons. bruto Inicial")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial__Control1000000031; "Importe Cons. Neto Inicial")
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Location_Code__Control1000000011Caption; FIELDCAPTION("Location Code"))
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry__Descripcion_Producto_Caption; FIELDCAPTION("Descripcion Producto"))
            {
            }
            column(Item_Ledger_Entry__Remaining_Quantity_Caption; FIELDCAPTION("Remaining Quantity"))
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial_Caption; FIELDCAPTION("Importe Cons. bruto Inicial"))
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial_Caption; FIELDCAPTION("Importe Cons. Neto Inicial"))
            {
            }
            column(Item_Ledger_Entry__Location_Code_Caption; FIELDCAPTION("Location Code"))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
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
        TotalFor: Label 'Total para almacén';
        Item_Ledger_EntryCaptionLbl: Label 'Item Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
}

