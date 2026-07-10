tableextension 70000003 tableextension70000003 extends "Sales Shipment Line" 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 12)".

        modify("Item Shpt. Entry No.")
        {
            Caption = 'Item Shpt. Entry No.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Attached to Line No.")
        {
            Caption = 'Attached to Line No.';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Job Contract Entry No.")
        {
            Caption = 'Job Contract Entry No.';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }
        modify("Depr. until FA Posting Date")
        {
            Caption = 'Depr. until FA Posting Date';
        }
        modify("Duplicate in Depreciation Book")
        {
            Caption = 'Duplicate in Depreciation Book';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Cupon"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Linea Cupon"(Field 50015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Aprobada"(Field 50016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad pendiente BO"(Field 50017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Anular"(Field 50018)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Solicitada"(Field 50019)".


        //Unsupported feature: Deletion (FieldCollection) on "Temporal(Field 50020)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Anulada"(Field 50022)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Ajustar"(Field 50040)".


        //Unsupported feature: Deletion (FieldCollection) on ""Porcentaje Cant. Aprobada"(Field 50041)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Vendedor"(Field 53004)".


        //Unsupported feature: Deletion (FieldCollection) on ""Linea Copiada"(Field 55500)".


        //Unsupported feature: Deletion (FieldCollection) on "Disponible(Field 56001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Bin Ranking"(Field 56008)".


        //Unsupported feature: Deletion (FieldCollection) on "Compartir(Field 56009)".

        field(10003;"Custom Transit Number";Text[30])
        {
            Caption = 'Custom Transit Number';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Bin Ranking"(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCode(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "InsertInvLineFromShptLine(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "CalcShippedSaleNotReturned(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPstdDocLnItemLedgEntries(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemSalesInvLines(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "StartTrackingSite(PROCEDURE 10000)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAsmToOrder(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "AsmToShipmentExists(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromSalesLine(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearSalesLineValues(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDescriptionSalesLineInsert(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitFromSalesLine(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInsertInvLineFromShptLine(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertInvLineFromShptLine(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCodeInsertInvLineFromShptLine(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "OnInsertInvLineFromShptLineOnAfterAssignDescription(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OnInsertInvLineFromShptLineOnAfterCalcQuantities(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "OnInsertInvLineFromShptLineOnAfterUpdatePrepaymentsAmounts(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "OnInsertInvLineFromShptLineOnBeforeValidateQuantity(PROCEDURE 23)".

}

