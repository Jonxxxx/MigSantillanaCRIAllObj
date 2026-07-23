report 56099 "Existencia por Almacenes"
{
    // Si da error de clave, activar el grupo de claves "ConvLoc"
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Existencia por Almacenes.rdlc';

    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Item No.", "Location Code");
            RequestFilterFields = "Item No.", "Location Code";
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
            column(rItem_Description; rItem.Description)
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Location_Code__; ("Location Code"))
            {
            }
            column(Item_Ledger_Entry_Quantity; Quantity)
            {
            }
            column(rAlmacen_Name; rAlmacen.Name)
            {
            }
            column(Total_Producto___; 'Total Producto ')
            {
            }
            column(Item_Ledger_Entry_Quantity_Control1000000025; Quantity)
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Cod__AlmacénCaption"; Cod__AlmacénCaptionLbl)
            {
            }
            column(NombreCaption; NombreCaptionLbl)
            {
            }
            column(CantidadCaption; CantidadCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Item_Ledger_Entry_Location_Code; "Item Ledger Entry"."Location Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //+#139
                IF "Item No." <> rItem."No." THEN
                    rItem.GET("Item No.");

                IF "Location Code" <> rAlmacen.Code THEN
                    rAlmacen.GET("Location Code");

                IF Quantity = 0 THEN
                    CurrReport.SKIP;
                //-#139
            end;

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
        rItem: Record 27;
        rAlmacen: Record 14;
        Item_Ledger_EntryCaptionLbl: Label 'Item Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        "Cod__AlmacénCaptionLbl": Label 'Cod. Almacén';
        NombreCaptionLbl: Label 'Nombre';
        CantidadCaptionLbl: Label 'Cantidad';
}

