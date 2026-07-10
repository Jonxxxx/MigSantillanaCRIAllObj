tableextension 70000002 tableextension70000002 extends "Sales Shipment Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Bill-to City"(Field 9)".

        modify("Your Reference")
        {
            Caption = 'Your Reference';
        }
        modify("Ship-to Address")
        {
            Caption = 'Ship-to Address';
        }

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

        //Unsupported feature: Property Modification (Data type) on ""Sell-to City"(Field 83)".

        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de Venta"(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Documento SIC"(Field 50110)".


        //Unsupported feature: Deletion (FieldCollection) on ""Source counter"(Field 50111)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Cajero"(Field 50112)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Supervisor"(Field 50113)".


        //Unsupported feature: Deletion (FieldCollection) on "Tienda(Field 53008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Factura en Historico"(Field 53009)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pedido Consignacion"(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Collector Code"(Field 56001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Pre pedido"(Field 56002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Devolucion Consignacion"(Field 56003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 56006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre Colegio"(Field 56007)".


        //Unsupported feature: Deletion (FieldCollection) on ""No aplica Derechos de Autor"(Field 56020)".


        //Unsupported feature: Deletion (FieldCollection) on "Promocion(Field 56021)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cantidad de Bultos"(Field 56062)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Envio de Almacen"(Field 56070)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Picking"(Field 56071)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Picking Reg."(Field 56072)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Packing"(Field 56073)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Packing Reg."(Field 56074)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Factura"(Field 56075)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Envio"(Field 56076)".


        //Unsupported feature: Deletion (FieldCollection) on ""En Hoja de Ruta"(Field 56098)".


        //Unsupported feature: Deletion (FieldCollection) on ""En Hoja de Ruta Registrada"(Field 56099)".


        //Unsupported feature: Deletion (FieldCollection) on "Origen(Field 56310)".


        //Unsupported feature: Deletion (FieldCollection) on ""Estado E-Commerce"(Field 56311)".

        field(10020; "Original Document XML"; BLOB)
        {
            Caption = 'Original Document XML';
        }
        field(10022; "Original String"; BLOB)
        {
            Caption = 'Original String';
        }
        field(10023; "Digital Stamp SAT"; BLOB)
        {
            Caption = 'Digital Stamp SAT';
        }
        field(10024; "Certificate Serial No."; Text[250])
        {
            Caption = 'Certificate Serial No.';
            Editable = false;
        }
        field(10025; "Signed Document XML"; BLOB)
        {
            Caption = 'Signed Document XML';
        }
        field(10026; "Digital Stamp PAC"; BLOB)
        {
            Caption = 'Digital Stamp PAC';
        }
        field(10030; "Electronic Document Status"; Option)
        {
            Caption = 'Electronic Document Status';
            Editable = false;
            OptionCaption = ' ,Stamp Received,Sent,Canceled,Stamp Request Error,Cancel Error';
            OptionMembers = " ","Stamp Received",Sent,Canceled,"Stamp Request Error","Cancel Error";
        }
        field(10031; "Date/Time Stamped"; Text[50])
        {
            Caption = 'Date/Time Stamped';
            Editable = false;
        }
        field(10033; "Date/Time Canceled"; Text[50])
        {
            Caption = 'Date/Time Canceled';
            Editable = false;
        }
        field(10035; "Error Code"; Code[10])
        {
            Caption = 'Error Code';
            Editable = false;
        }
        field(10036; "Error Description"; Text[250])
        {
            Caption = 'Error Description';
            Editable = false;
        }
        field(10040; "PAC Web Service Name"; Text[50])
        {
            Caption = 'PAC Web Service Name';
            Editable = false;
        }
        field(10041; "QR Code"; BLOB)
        {
            Caption = 'QR Code';
        }
        field(10042; "Fiscal Invoice Number PAC"; Text[50])
        {
            Caption = 'Fiscal Invoice Number PAC';
            Editable = false;
        }
        field(10043; "Date/Time First Req. Sent"; Text[50])
        {
            Caption = 'Date/Time First Req. Sent';
            Editable = false;
        }
        field(10044; "Transport Operators"; Integer)
        {
            CalcFormula = Count("CFDI Transport Operator" WHERE(Document Table ID=CONST(110),
                                                                 Document No.=FIELD(No.)));
            Caption = 'Transport Operators';
            FieldClass = FlowField;
        }
        field(10045;"Transit-from Date/Time";DateTime)
        {
            Caption = 'Transit-from Date/Time';
        }
        field(10046;"Transit Hours";Integer)
        {
            Caption = 'Transit Hours';
        }
        field(10047;"Transit Distance";Decimal)
        {
            Caption = 'Transit Distance';
        }
        field(10048;"Insurer Name";Text[50])
        {
            Caption = 'Insurer Name';
        }
        field(10049;"Insurer Policy Number";Text[30])
        {
            Caption = 'Insurer Policy Number';
        }
        field(10050;"Foreign Trade";Boolean)
        {
            Caption = 'Foreign Trade';
        }
        field(10051;"Vehicle Code";Code[20])
        {
            Caption = 'Vehicle Code';
            TableRelation = "Fixed Asset";
        }
        field(10052;"Trailer 1;Code[20])
        {
            Caption = 'Trailer 1';
            TableRelation = "Fixed Asset" WHERE (SAT Trailer Type=FILTER(<>''));
        }
        field(10053;"Trailer 2;Code[20])
        {
            Caption = 'Trailer 2';
            TableRelation = "Fixed Asset" WHERE (SAT Trailer Type=FILTER(<>''));
        }
        field(10055;"Transit-to Location";Code[10])
        {
            Caption = 'Transit-to Location';
            TableRelation = Location WHERE (Use As In-Transit=CONST(false));
        }
        field(10056;"Medical Insurer Name";Text[50])
        {
            Caption = 'Medical Insurer Name';
        }
        field(10057;"Medical Ins. Policy Number";Text[30])
        {
            Caption = 'Medical Ins. Policy Number';
        }
        field(10058;"SAT Weight Unit Of Measure";Code[10])
        {
            Caption = 'SAT Weight Unit Of Measure';
            TableRelation = "SAT Weight Unit of Measure";
        }
        field(27002;"CFDI Cancellation Reason Code";Code[10])
        {
            Caption = 'CFDI Cancelation Reason Code';
            TableRelation = "CFDI Cancellation Reason";
        }
        field(27003;"Substitution Document No.";Code[20])
        {
            Caption = 'Substitution Document No.';
            TableRelation = "Sales Shipment Header" WHERE (Electronic Document Status=FILTER(Stamp Received));
        }
        field(27004;"CFDI Export Code";Code[10])
        {
            Caption = 'CFDI Export Code';
            TableRelation = "CFDI Export Code";
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "SendProfile(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "EmailRecords(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "StartTrackingSite(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "IsCompletlyInvoiced(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetTrackingInternetAddr(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetWorkDescription(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeEmailRecords(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforePrintRecords(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSendProfile(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetTrackingInternetAddr(PROCEDURE 13)".


    [Scope('Personalization')]
    procedure ExportEDocument()
    var
        TempBlob Record: 99008535;
        FileManagement: Codeunit 419;
    begin
        CALCFIELDS("Signed Document XML");
        IF "Signed Document XML".HASVALUE THEN BEGIN
          TempBlob.Blob := "Signed Document XML";
          FileManagement.BLOBExport(TempBlob,"No." + '.xml',TRUE);
        END ELSE
          ERROR(NoElectronicStampErr,"No.");
    end;

    [Scope('Personalization')]
    procedure RequestStampEDocument()
    var
        EInvoiceMgt: Codeunit 10145;
        LoCRecRef: RecordRef;
    begin
        LoCRecRef.GETTABLE(Rec);
        EInvoiceMgt.RequestStampDocument(LoCRecRef,FALSE);
    end;

    [Scope('Personalization')]
    procedure CancelEDocument()
    var
        EInvoiceMgt: Codeunit 10145;
        LoCRecRef: RecordRef;
    begin
        LoCRecRef.GETTABLE(Rec);
        EInvoiceMgt.CancelDocument(LoCRecRef);
    end;

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".


    var
        NoElectronicStampErr: Label 'There is no electronic stamp for document no. %1.', Comment='%1 - Document No.';
}

