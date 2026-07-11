tableextension 70000079 tableextension70000079 extends "Transfer Shipment Header"
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


        //Unsupported feature: Deletion (FieldCollection) on ""No. Hoja de Ruta"(Field 56063)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Hoja de Ruta Reg."(Field 56064)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Envio de Almacen"(Field 56070)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Picking"(Field 56071)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Picking Reg."(Field 56072)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Packing"(Field 56073)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Packing Reg."(Field 56074)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Envio"(Field 56075)".


        //Unsupported feature: Deletion (FieldCollection) on ""En Hoja de Ruta"(Field 56095)".


        //Unsupported feature: Deletion (FieldCollection) on ""En Hoja de Ruta Registrada"(Field 56096)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Facturas"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003002)".

        field(49; "Partner VAT ID"; Code[20])
        {
            Caption = 'Partner Tax ID';
        }
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
            CalcFormula = Count("CFDI Transport Operator" WHERE(Document Table ID=CONST(5744),
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
            TableRelation = "Transfer Shipment Header" WHERE (Electronic Document Status=FILTER(Stamp Received));
        }
        field(27004;"CFDI Export Code";Code[10])
        {
            Caption = 'CFDI Export Code';
            TableRelation = "CFDI Export Code";
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

        "Cantidad de Bultos" := TransHeader."Cantidad de Bultos";//012
        Observaciones        := TransHeader.Observaciones; //SANTINAV-301

        //002
        "Prioridad entrega consignacion" := TransHeader."Prioridad entrega consignacion";
        "Cod. Vendedor"                  := TransHeader."Cod. Vendedor";
        "Pedido Consignacion"            := TransHeader."Pedido Consignacion";
        "Devolucion Consignacion"        := TransHeader."Devolucion Consignacion";
        //002

        //007
        "Consignacion Muestras" := "Consignacion Muestras";
        "Cod. Ubicacion Alm. Origen" := "Cod. Ubicacion Alm. Origen";   //APS
        "Cod. Ubicacion Alm. Destino" := "Cod. Ubicacion Alm. Destino"; //APS
        //007

        Area := TransHeader.Area;
        "Transaction Specification" := TransHeader."Transaction Specification";
        "Direct Transfer" := TransHeader."Direct Transfer";

        OnAfterCopyFromTransferHeader(Rec,TransHeader);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..35
        "Partner VAT ID" := TransHeader."Partner VAT ID";
        "Entry/Exit Point" := TransHeader."Entry/Exit Point";
        #54..57
        "Transit-from Date/Time" := TransHeader."Transit-from Date/Time";
        "Transit Hours" := TransHeader."Transit Hours";
        "Transit Distance" := TransHeader."Transit Distance";
        "Insurer Name" := TransHeader."Insurer Name";
        "Insurer Policy Number" := TransHeader."Insurer Policy Number";
        "Foreign Trade" := TransHeader."Foreign Trade";
        "Vehicle Code" := TransHeader."Vehicle Code";
        "Trailer 1" := TransHeader."Trailer 1;
        "Trailer 2" := TransHeader."Trailer 2;
        "Medical Insurer Name" := TransHeader."Medical Insurer Name";
        "Medical Ins. Policy Number" := TransHeader."Medical Ins. Policy Number";
        "SAT Weight Unit Of Measure" := TransHeader."SAT Weight Unit Of Measure";
        "CFDI Export Code" := "CFDI Export Code";

        OnAfterCopyFromTransferHeader(Rec,TransHeader);
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromTransferHeader(PROCEDURE 5)".


    [Scope('Personalization')]
    procedure ExportEDocument()
    var
        TempBlob: Record 99008535;
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

