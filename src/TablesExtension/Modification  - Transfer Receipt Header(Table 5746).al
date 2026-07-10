tableextension 70000081 tableextension70000081 extends "Transfer Receipt Header"
{
    fields
    {
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Area")
        {
            Caption = 'Area';
        }

        //Unsupported feature: Deletion (FieldCollection) on "Devolucion(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Consignacion"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Saldo Cliente"(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Limite de credito cliente"(Field 50003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Prioridad entrega consignacion"(Field 50004)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Consignacion Orginal"(Field 50005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Vendedor"(Field 50006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Estado distribucion"(Field 50007)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Copias impresas"(Field 50008)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Copias imp. Recep."(Field 50009)".


        //Unsupported feature: Deletion (FieldCollection) on "Observaciones(Field 52500)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pedido Consignacion"(Field 56001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devolucion Consignacion"(Field 56002)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Bultos"(Field 56003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Ubicacion Alm. Origen"(Field 56013)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Ubicacion Alm. Destino"(Field 56014)".


        //Unsupported feature: Deletion (FieldCollection) on ""Desc. Ubic. Alm. Origen"(Field 56015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Desc. Ubic. Alm. Destino"(Field 56016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Consignacion Muestras"(Field 56017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad de Bultos"(Field 56062)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Envio de Almacen"(Field 56070)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Picking"(Field 56071)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Picking Reg."(Field 56072)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Packing"(Field 56073)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Packing Reg."(Field 56074)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Envio"(Field 56075)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Facturas"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003002)".

        field(49; "Partner VAT ID"; Code[20])
        {
            Caption = 'Partner Tax ID';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Transfer Order No."(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromTransferHeader(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "CopyFromTransferHeader(PROCEDURE 4)".

    //procedure CopyFromTransferHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Transfer-from Code" := TransHeader."Transfer-from Code";
    "Transfer-from Name" := TransHeader."Transfer-from Name";
    "Transfer-from Name 2" := TransHeader."Transfer-from Name 2;
    "Transfer-from Address" := TransHeader."Transfer-from Address";
    "Transfer-from Address 2" := TransHeader."Transfer-from Address 2;
    "Transfer-from Post Code" := TransHeader."Transfer-from Post Code";
    "Transfer-from City" := TransHeader."Transfer-from City";
    "Transfer-from County" := TransHeader."Transfer-from County";
    "Trsf.-from Country/Region Code" := TransHeader."Trsf.-from Country/Region Code";
    "Transfer-from Contact" := TransHeader."Transfer-from Contact";
    "Transfer-to Code" := TransHeader."Transfer-to Code";
    "Transfer-to Name" := TransHeader."Transfer-to Name";
    "Transfer-to Name 2" := TransHeader."Transfer-to Name 2;
    "Transfer-to Address" := TransHeader."Transfer-to Address";
    "Transfer-to Address 2" := TransHeader."Transfer-to Address 2;
    "Transfer-to Post Code" := TransHeader."Transfer-to Post Code";
    "Transfer-to City" := TransHeader."Transfer-to City";
    "Transfer-to County" := TransHeader."Transfer-to County";
    "Trsf.-to Country/Region Code" := TransHeader."Trsf.-to Country/Region Code";
    "Transfer-to Contact" := TransHeader."Transfer-to Contact";
    "Transfer Order Date" := TransHeader."Posting Date";
    "Posting Date" := TransHeader."Posting Date";
    "Shipment Date" := TransHeader."Shipment Date";
    "Receipt Date" := TransHeader."Receipt Date";
    "Shortcut Dimension 1 Code" := TransHeader."Shortcut Dimension 1 Code";
    "Shortcut Dimension 2 Code" := TransHeader."Shortcut Dimension 2 Code";
    "Dimension Set ID" := TransHeader."Dimension Set ID";
    "Transfer Order No." := TransHeader."No.";
    "External Document No." := TransHeader."External Document No.";
    "In-Transit Code" := TransHeader."In-Transit Code";
    "Shipping Agent Code" := TransHeader."Shipping Agent Code";
    "Shipping Agent Service Code" := TransHeader."Shipping Agent Service Code";
    "Shipment Method Code" := TransHeader."Shipment Method Code";
    "Transaction Type" := TransHeader."Transaction Type";
    "Transport Method" := TransHeader."Transport Method";
    "Entry/Exit Point" := TransHeader."Entry/Exit Point";
    Area := TransHeader.Area;
    "Transaction Specification" := TransHeader."Transaction Specification";
    "Direct Transfer" := TransHeader."Direct Transfer";

    "Cantidad de Bultos" := TransHeader."Cantidad de Bultos";//008
    Observaciones        := TransHeader.Observaciones; //SANTINAV-301

    //005
    "Consignacion Muestras" := TransHeader."Consignacion Muestras";
    "Cod. Ubicacion Alm. Origen" := TransHeader."Cod. Ubicacion Alm. Origen";   //APS
    "Cod. Ubicacion Alm. Destino" := TransHeader."Cod. Ubicacion Alm. Destino"; //APS
    //005

    //002
    "Prioridad entrega consignacion" := TransHeader."Prioridad entrega consignacion";
    "Cod. Vendedor"                  := TransHeader."Cod. Vendedor";
    "Pedido Consignacion"            := TransHeader."Pedido Consignacion";
    "Devolucion Consignacion"        := TransHeader."Devolucion Consignacion";
    //002

    OnAfterCopyFromTransferHeader(Rec,TransHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..35
    "Partner VAT ID" := TransHeader."Partner VAT ID";
    #36..40
    OnAfterCopyFromTransferHeader(Rec,TransHeader);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromTransferHeader(PROCEDURE 5)".

}

