tableextension 70000091 tableextension70000091 extends "Service Invoice Header" 
{
    fields
    {
        modify("Your Reference")
        {
            Caption = 'Your Reference';
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
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("No. of E-Documents Sent")
        {
            Caption = 'No. of E-Documents Sent';
        }
        modify("PAC Web Service Name")
        {
            Caption = 'PAC Web Service Name';
        }
        modify("Fiscal Invoice Number PAC")
        {
            Caption = 'Fiscal Invoice Number PAC';
        }
        modify("Date/Time First Req. Sent")
        {
            Caption = 'Date/Time First Req. Sent';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Facturas"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha vencimiento NCF"(Field 34003007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de ingreso"(Field 34003008)".

        field(27002;"CFDI Cancellation Reason Code";Code[10])
        {
            Caption = 'CFDI Cancelation Reason Code';
            TableRelation = "CFDI Cancellation Reason";
        }
        field(27003;"Substitution Document No.";Code[20])
        {
            Caption = 'Substitution Document No.';
            TableRelation = "Service Invoice Header" WHERE (Electronic Document Status=FILTER(Stamp Received));
        }
        field(27004;"CFDI Export Code";Code[10])
        {
            Caption = 'CFDI Export Code';
            TableRelation = "CFDI Export Code";
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SendRecords(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "SendProfile(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "LookupAdjmtValueEntries(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ExportEDocument(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "RequestStampEDocument(PROCEDURE 1020001)".


    //Unsupported feature: Property Modification (Attributes) on "CancelEDocument(PROCEDURE 1020002)".


    //Unsupported feature: Property Modification (Attributes) on "ShowActivityLog(PROCEDURE 116)".


    //Unsupported feature: Property Modification (Attributes) on "GetDocExchStatusStyle(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforePrintRecords(PROCEDURE 7)".

}

