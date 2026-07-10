tableextension 70000007 tableextension70000007 extends "Sales Cr.Memo Line" 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 12)".

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
        modify("IC Partner Ref. Type")
        {
            Caption = 'IC Partner Ref. Type';
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
        modify("Return Receipt Line No.")
        {
            Caption = 'Return Receipt Line No.';
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


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Descuento FE"(Field 56015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Alumnos"(Field 67000)".


        //Unsupported feature: Deletion (FieldCollection) on "Adopcion(Field 67001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 67002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devuelve a Documento"(Field 34002508)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devuelve a Linea Documento"(Field 34002509)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de bien-servicio"(Field 34003000)".

        field(10001;"Retention Attached to Line No.";Integer)
        {
            Caption = 'Retention Attached to Line No.';
        }
        field(10002;"Retention VAT %";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Retention tax %';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Document No.,Type,No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Bin Ranking"(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCode(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemTrackingLines(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CalcVATAmountLines(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountExclVAT(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "GetLineAmountInclVAT(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "GetReturnRcptLines(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetItemLedgEntries(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPstdDocLineValueEntries(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemReturnRcptLines(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromSalesLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDeferrals(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocumentType(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitFromSalesLine(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetItemLedgEntriesOnBeforeTempItemLedgEntryInsert(PROCEDURE 16)".

}

