tableextension 70000082 tableextension70000082 extends "Transfer Receipt Line" 
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

        modify("Item Rcpt. Entry No.")
        {
            Caption = 'Item Rcpt. Entry No.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Precio Venta Consignacion"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Descuento % Consignacion"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Consignacion"(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50004)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Pedido Consignacion"(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Linea Pedido Consignacion"(Field 50011)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Mov. Prod. Cosg. a Liq."(Field 50012)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Consg. Aplicada"(Field 50013)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Devuelta"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""Grupo registro IVA prod."(Field 50015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Grupo registro IVA neg."(Field 50016)".


        //Unsupported feature: Deletion (FieldCollection) on ""% IVA"(Field 50017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe IVA"(Field 50018)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Aprobada"(Field 50020)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad pendiente BO"(Field 50021)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Anular"(Field 50022)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Solicitada"(Field 50023)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Ajustar"(Field 50024)".


        //Unsupported feature: Deletion (FieldCollection) on ""Porcentaje Cant. Aprobada"(Field 50025)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Anulada"(Field 50029)".


        //Unsupported feature: Deletion (FieldCollection) on ""Bin Ranking"(Field 56008)".


        //Unsupported feature: Deletion (FieldCollection) on "Disponible(Field 56028)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Alumnos"(Field 67000)".


        //Unsupported feature: Deletion (FieldCollection) on "Adopcion(Field 67001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 67002)".

    }
    keys
    {

        //Unsupported feature: Property Deletion (SumIndexFields) on ""Document No.,Line No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Transfer-to Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Bin Ranking"(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemTrackingLines(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromTransferLine(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromTransferLine(PROCEDURE 2)".

}

