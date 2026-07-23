report 56093 "Venta a Consignacion por item"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Venta a Consignacion por item.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Item No.", "Posting Date");
            RequestFilterFields = "Item No.", "Posting Date", "Location Code", "Pedido Consignacion";
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
            column(Item_Ledger_Entry__Invoiced_Quantity_; "Invoiced Quantity")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial_; "Importe Cons. bruto Inicial")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Item_Ledger_Entry__Item_Ledger_Entry___Descripcion_Producto_; "Item Ledger Entry"."Descripcion Producto")
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(CantidadCaption; CantidadCaptionLbl)
            {
            }
            column(Vta__NetaCaption; Vta__NetaCaptionLbl)
            {
            }
            column("Vta__LiquidaCaption"; Vta__LiquidaCaptionLbl)
            {
            }
            column("DescripcionCaption"; DescripcionCaptionLbl)
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total para ';
        Item_Ledger_EntryCaptionLbl: Label 'Item Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        No_CaptionLbl: Label 'No.';
        CantidadCaptionLbl: Label 'Cantidad';
        Vta__NetaCaptionLbl: Label 'Vta. Neta';
        "Vta__LiquidaCaptionLbl": Label 'Vta. Liquida';
        "DescripcionCaptionLbl": Label 'Descripcion';
}

