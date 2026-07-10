tableextension 70000005 tableextension70000005 extends "Sales Invoice Line"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 12)".



        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Cupon"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Linea Cupon"(Field 50015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Aprobada"(Field 50016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad pendiente BO"(Field 50017)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Anular"(Field 50018)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Solicitada"(Field 50019)".


        //Unsupported feature: Deletion (FieldCollection) on "Temporal(Field 50020)".


        //Unsupported feature: Deletion (FieldCollection) on ""Requested Delivery Date"(Field 50021)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Anulada"(Field 50022)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad a Ajustar"(Field 50040)".


        //Unsupported feature: Deletion (FieldCollection) on ""Porcentaje Cant. Aprobada"(Field 50041)".


        //Unsupported feature: Deletion (FieldCollection) on ""Linea Copiada"(Field 55500)".


        //Unsupported feature: Deletion (FieldCollection) on "Disponible(Field 56001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Bin Ranking"(Field 56008)".


        //Unsupported feature: Deletion (FieldCollection) on "Compartir(Field 56009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Descuento FE"(Field 56015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Documento Replicador"(Field 56150)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Pedido Replicador"(Field 56151)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad 1 Replicador"(Field 56152)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad 2 Replicador"(Field 56153)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad 3 Replicador"(Field 56154)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad 4 Replicador"(Field 56155)".


        //Unsupported feature: Deletion (FieldCollection) on ""Anulada en TPV"(Field 34002500)".


        //Unsupported feature: Deletion (FieldCollection) on ""Precio anulacion TPV"(Field 34002501)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad anulacion TPV"(Field 34002502)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad agregada"(Field 34002503)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Vendedor"(Field 34002504)".


        //Unsupported feature: Deletion (FieldCollection) on "Devuelto(Field 34002505)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devuelto en Documento"(Field 34002506)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devuelto en Linea Documento"(Field 34002507)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad Alumnos"(Field 34002800)".


        //Unsupported feature: Deletion (FieldCollection) on "Adopcion(Field 34002801)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 34002802)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de bien-servicio"(Field 34003000)".

        field(10001; "Retention Attached to Line No."; Integer)
        {
            Caption = 'Retention Attached to Line No.';
        }
        field(10002; "Retention VAT %"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Retention tax %';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Document No.,Type,No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Document No.,Posting Date,Type,No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Document No.,Bill-to Customer No.,Shortcut Dimension 1 Code,Shortcut Dimension 2 Code"(Key)".


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


    //Unsupported feature: Property Modification (Attributes) on "GetSalesShptLines(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CalcShippedSaleNotReturned(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetItemLedgEntries(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPstdDocLineValueEntries(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemShipmentLines(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromSalesLine(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "InitFromSalesLine(PROCEDURE 12)".

    //procedure InitFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    INIT;
    TRANSFERFIELDS(SalesLine);
    IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
      Type := Type::" ";
    "Posting Date" := SalesInvHeader."Posting Date";
    "Document No." := SalesInvHeader."No.";

    Quantity := SalesLine."Qty. to Invoice";
    "Quantity (Base)" := SalesLine."Qty. to Invoice (Base)";

    OnAfterInitFromSalesLine(Rec,SalesInvHeader,SalesLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    #8..11
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShowDeferrals(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePriceDescription(PROCEDURE 143)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocumentType(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "IsCancellationSupported(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitFromSalesLine(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetItemLedgEntriesOnBeforeTempItemLedgEntryInsert(PROCEDURE 16)".

}

