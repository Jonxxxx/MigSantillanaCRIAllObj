report 56086 "Consignacion por Almacen"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Consignacion por Almacen.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Location Code", "Item Category Code", "Posting Date", "Item No.")
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
            column(Item_Ledger_Entry__Location_Code_; "Location Code")
            {
            }
            column(Item_Ledger_Entry_Quantity; Quantity)
            {
                DecimalPlaces = 2 : 2;
            }
            column(Item_Ledger_Entry__Importe_Cons__bruto_Inicial_; "Importe Cons. bruto Inicial")
            {
            }
            column(Item_Ledger_Entry__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
            {
            }
            column(NombreCliente; NombreCliente)
            {
            }
            column(CodZonaServ; CodZonaServ)
            {
            }
            column(Item_Ledger_Entry_Quantity_Control1000000007; Quantity)
            {
                DecimalPlaces = 2 : 2;
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
            column("Cod__Cliente__Almacén_Caption"; Cod__Cliente__Almacén_CaptionLbl)
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
            column("Cod__Zona_Serv_Caption"; Cod__Zona_Serv_CaptionLbl)
            {
            }
            column(Nombre_ClienteCaption; Nombre_ClienteCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
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

    trigger OnPreReport()
    begin
        Filtros := "Item Ledger Entry".GETFILTERS;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total para ';
        Filtros: Text[800];
        rCliente: Record 18;
        NombreCliente: Text[100];
        CodZonaServ: Text[30];
        Item_Ledger_EntryCaptionLbl: Label 'Item Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        "Cod__Cliente__Almacén_CaptionLbl": Label 'Cod. Cliente (Almacén)';
        CantidadCaptionLbl: Label 'Cantidad';
        Vta__NetaCaptionLbl: Label 'Vta. Neta';
        Vta__LiquidaCaptionLbl: Label 'Vta. Liquida';
        "Cod__Zona_Serv_CaptionLbl": Label 'Cod. Zona Serv.';
        Nombre_ClienteCaptionLbl: Label 'Nombre Cliente';
        TotalCaptionLbl: Label 'Total';
}

