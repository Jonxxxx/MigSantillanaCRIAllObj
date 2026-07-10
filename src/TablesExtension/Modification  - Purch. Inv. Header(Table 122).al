tableextension 70000008 tableextension70000008 extends "Purch. Inv. Header" 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Pay-to Name 2"(Field 6)".


        //Unsupported feature: Property Modification (Data type) on ""Pay-to Address 2"(Field 8)".


        //Unsupported feature: Property Modification (Data type) on ""Pay-to City"(Field 9)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to Name 2"(Field 14)".

        modify("Ship-to Address")
        {
            Caption = 'Ship-to Address';
        }

        //Unsupported feature: Property Modification (Data type) on ""Ship-to Address 2"(Field 16)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to City"(Field 17)".

        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }

        //Unsupported feature: Property Modification (Data type) on ""VAT Registration No."(Field 70)".

        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }

        //Unsupported feature: Property Modification (Data type) on ""Buy-from Vendor Name 2"(Field 80)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from Address 2"(Field 82)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from City"(Field 83)".

        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("Vendor Ledger Entry No.")
        {
            Caption = 'Vendor Ledger Entry No.';
        }
        modify("Fiscal Invoice Number PAC")
        {
            Caption = 'Fiscal Invoice Number PAC';
        }

        //Unsupported feature: Deletion (FieldCollection) on "Clave(Field 52500)".


        //Unsupported feature: Deletion (FieldCollection) on "Consecutivo(Field 52501)".


        //Unsupported feature: Deletion (FieldCollection) on "Estado(Field 52502)".


        //Unsupported feature: Deletion (FieldCollection) on "Mensaje(Field 52503)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Doc Electronico"(Field 52504)".


        //Unsupported feature: Deletion (FieldCollection) on ""E-Mail-FE"(Field 52505)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Doc Electronico"(Field 52506)".


        //Unsupported feature: Deletion (FieldCollection) on ""QR Code FE"(Field 52507)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Doc. Ref."(Field 52508)".


        //Unsupported feature: Deletion (FieldCollection) on ""Numero Referencia FE"(Field 52509)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Doc. Ref NC"(Field 52510)".


        //Unsupported feature: Deletion (FieldCollection) on ""Codigo Referencia"(Field 52511)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Retencion"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003002)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal Rel."(Field 34003003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Correccion Doc. NCF"(Field 34003004)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Facturas"(Field 34003005)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Abonos"(Field 34003006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Clasificacion Gasto"(Field 34003007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha vencimiento NCF"(Field 34003009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de ingreso"(Field 34003010)".


        //Unsupported feature: Deletion (FieldCollection) on "Proporcionalidad(Field 34003030)".

    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""No. Comprobante Fiscal"(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "IsFullyOpen(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "ShowCanceledOrCorrCrMemo(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "ShowCorrectiveCreditMemo(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "ShowCancelledCreditMemo(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforePrintRecords(PROCEDURE 7)".

}

