report 56089 "Cdad Enviada No Fact. Cosng."
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Cdad Enviada No Fact. Cosng..rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Line"; 5741)
        {
            DataItemTableView = SORTING("Item Category Code");
            RequestFilterFields = "Item Category Code", "Shipment Date";
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
            column(Transfer_Line__Item_Category_Code_; "Item Category Code")
            {
            }
            column(DescCategoria; DescCategoria)
            {
            }
            column(wVtaBruta; wVtaBruta)
            {
            }
            column(Transfer_Line__Qty__in_Transit_; "Qty. in Transit")
            {
            }
            column(Transfer_Line__Qty__in_Transit__Control1000000015; "Qty. in Transit")
            {
            }
            column(wVtaBruta_Control1000000016; wVtaBruta)
            {
            }
            column(Transfer_LineCaption; Transfer_LineCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Vta__BrutaCaption; Vta__BrutaCaptionLbl)
            {
            }
            column(CantidadCaption; CantidadCaptionLbl)
            {
            }
            column("DescripcionCaption"; DescripcionCaptionLbl)
            {
            }
            column("Cod__Categoria_ProductoCaption"; Cod__Categoria_ProductoCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Transfer_Line_Document_No_; "Document No.")
            {
            }
            column(Transfer_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                wVtaBruta := "Qty. in Transit" * "Precio Venta Consignacion"; //+#139
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Item Category Code");
                CurrReport.CREATETOTALS(wVtaBruta);
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
        Filtros: Text[1000];
        wVtaBruta: Decimal;
        wVtaBrutaTotal: Decimal;
        rItemCatCode: Record 5722;
        DescCategoria: Text[290];
        Transfer_LineCaptionLbl: Label 'Transfer Line';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        Vta__BrutaCaptionLbl: Label 'Vta. Bruta';
        CantidadCaptionLbl: Label 'Cantidad';
        "DescripcionCaptionLbl": Label 'Descripcion';
        "Cod__Categoria_ProductoCaptionLbl": Label 'Cod. Categoria Producto';
        TotalCaptionLbl: Label 'Total';
}

