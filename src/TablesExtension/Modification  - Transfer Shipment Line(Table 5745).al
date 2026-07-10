tableextension 70000080 tableextension70000080 extends "Transfer Shipment Line"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Description(Field 7)".

        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 23)".


        //Unsupported feature: Property Modification (Data type) on ""Transfer-from Code"(Field 29)".


        //Unsupported feature: Property Modification (Data type) on ""Transfer-to Code"(Field 30)".

        modify("Item Shpt. Entry No.")
        {
            Caption = 'Item Shpt. Entry No.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Precio Venta Consignacion"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Descuento % Consignacion"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Consignacion"(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50004)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Pedido Consignacion"(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Linea Pedido Consignacion"(Field 50011)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Mov. Prod. Cosg. a Liq."(Field 50012)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Devuelta"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""Grupo registro IVA prod."(Field 50015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Grupo registro IVA neg."(Field 50016)".


        //Unsupported feature: Deletion (FieldCollection) on ""% IVA"(Field 50017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe IVA"(Field 50018)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad pendiente BO"(Field 50021)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Anular"(Field 50022)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Solicitada"(Field 50023)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Ajustar"(Field 50024)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Anulada"(Field 50029)".


        //Unsupported feature: Deletion (FieldCollection) on ""Bin Ranking"(Field 56008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Alumnos"(Field 67000)".


        //Unsupported feature: Deletion (FieldCollection) on "Adopcion(Field 67001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 67002)".

        field(10003; "Custom Transit Number"; Text[30])
        {
            Caption = 'Custom Transit Number';
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (SumIndexFields) on ""Document No.,Line No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Bin Ranking"(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemTrackingLines(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromTransferLine(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "CopyFromTransferLine(PROCEDURE 1)".

    //procedure CopyFromTransferLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Line No." := TransLine."Line No.";
    "Item No." := TransLine."Item No.";
    Description := TransLine.Description;
    Quantity := TransLine."Qty. to Ship";
    "Unit of Measure" := TransLine."Unit of Measure";
    "Shortcut Dimension 1 Code" := TransLine."Shortcut Dimension 1 Code";
    "Shortcut Dimension 2 Code" := TransLine."Shortcut Dimension 2 Code";
    "Dimension Set ID" := TransLine."Dimension Set ID";
    "Gen. Prod. Posting Group" := TransLine."Gen. Prod. Posting Group";
    "Inventory Posting Group" := TransLine."Inventory Posting Group";
    "Quantity (Base)" := TransLine."Qty. to Ship (Base)";
    "Qty. per Unit of Measure" := TransLine."Qty. per Unit of Measure";
    "Unit of Measure Code" := TransLine."Unit of Measure Code";
    "Gross Weight" := TransLine."Gross Weight";
    "Net Weight" := TransLine."Net Weight";
    "Unit Volume" := TransLine."Unit Volume";
    "Variant Code" := TransLine."Variant Code";
    "Units per Parcel" := TransLine."Units per Parcel";
    "Description 2" := TransLine."Description 2;
    "Transfer Order No." := TransLine."Document No.";
    "Shipment Date" := TransLine."Shipment Date";
    "Shipping Agent Code" := TransLine."Shipping Agent Code";
    "Shipping Agent Service Code" := TransLine."Shipping Agent Service Code";
    "In-Transit Code" := TransLine."In-Transit Code";
    "Transfer-from Code" := TransLine."Transfer-from Code";
    "Transfer-to Code" := TransLine."Transfer-to Code";
    "Transfer-from Bin Code" := TransLine."Transfer-from Bin Code";
    "Shipping Time" := TransLine."Shipping Time";
    "Item Category Code" := TransLine."Item Category Code";

    //002
    "Precio Venta Consignacion"     := TransLine."Precio Venta Consignacion";
    "Descuento % Consignacion"      := TransLine."Descuento % Consignacion";
    "Importe Consignacion"          := TransLine."Importe Consignacion";
    "No. Mov. Prod. Cosg. a Liq."   := TransLine."No. Mov. Prod. Cosg. a Liq.";
    "No. Linea Pedido Consignacion" := TransLine."No. Linea Pedido Consignacion";
    "No. Pedido Consignacion"       := TransLine."No. Pedido Consignacion";
    //002

    ISBN := TransLine.ISBN;//008

    OnAfterCopyFromTransferLine(Rec,TransLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..30
    OnAfterCopyFromTransferLine(Rec,TransLine);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromTransferLine(PROCEDURE 2)".

}

