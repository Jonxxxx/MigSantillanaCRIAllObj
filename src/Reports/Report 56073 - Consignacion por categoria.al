report 56073 "Consignacion por categoria"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Consignacion por categoria.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Item Category Code", "Posting Date", "Item No.", "Location Code")
                                ORDER(Ascending);
            RequestFilterFields = "Item Category Code", "Posting Date", "Item No.", "Location Code";
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
            column(Filtros; Filtros)
            {
            }
            column(Item_Ledger_Entry__Item_Category_Code_; "Item Category Code")
            {
            }
            column(Item_Ledger_Entry_Quantity; Quantity)
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial_; "Importe Cons. bruto Inicial")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
            {
            }
            column(DescCat; DescCat)
            {
            }
            column(Item_Ledger_Entry_Quantity_Control1000000007; Quantity)
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial__Control1000000008; "Importe Cons. bruto Inicial")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial__Control1000000009; "Importe Cons. Neto Inicial")
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Categoria_ProductoCaption"; Categoria_ProductoCaptionLbl)
            {
            }
            column(CantidadCaption; CantidadCaptionLbl)
            {
            }
            column(Vta__NetaCaption; Vta__NetaCaptionLbl)
            {
            }
            column(Vta__LiquidaCaption; Vta__LiquidaCaptionLbl)
            {
            }
            column("DescripcionCaption"; DescripcionCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF rItemCatCode.GET("Item Category Code") THEN
                    DescCat := rItemCatCode.Description
                ELSE
                    DescCat := '';
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Item Category Code");
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

    trigger OnPreReport()
    begin
        Filtros := "Item Ledger Entry".GETFILTERS;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total para ';
        Filtros: Text[800];
        rItemCatCode: Record 5722;
        DescCat: Text[100];
        Item_Ledger_EntryCaptionLbl: Label 'Item Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        "Categoria_ProductoCaptionLbl": Label 'Categoria Producto';
        CantidadCaptionLbl: Label 'Cantidad';
        Vta__NetaCaptionLbl: Label 'Vta. Neta';
        Vta__LiquidaCaptionLbl: Label 'Vta. Liquida';
        "DescripcionCaptionLbl": Label 'Descripcion';
        TotalCaptionLbl: Label 'Total';
}

