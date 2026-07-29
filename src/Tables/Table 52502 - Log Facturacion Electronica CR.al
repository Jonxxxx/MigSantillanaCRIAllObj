table 52502 "Log Facturacion Electronica CR"
{

    fields
    {
        field(1; NoDocumento; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NoDocumento';
        }
        field(2; "Tipo Documento"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Documento';
            OptionMembers = FE,NC,ND,TE,MA,MP,MR,FEC;
        }
        field(3; "Doc SF  XML"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Doc SF  XML';
        }
        field(4; "Doc Firmado  XML"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Doc Firmado  XML';
        }
        field(5; "Doc Json envio  XML"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Doc Json envio  XML';
        }
        field(6; "Doc Json Respuesta  XML"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Doc Json Respuesta  XML';
        }
        field(7; "Doc Respuesta  XML"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Doc Respuesta  XML';
        }
        field(8; "Doc Pdf Generado"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Doc Pdf Generado';
        }
        field(9; "Fecha Doc"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Doc';
        }
        field(10; "Clave Doc"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Clave Doc';
        }
        field(11; "Consecutivo Doc"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Consecutivo Doc';
        }
        field(12; Estado; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
        }
        field(13; Mensaje; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Mensaje';
        }
        field(14; "Estado Interfaz"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado Interfaz';
            OptionMembers = ,Pendiente,Completado;
        }
        field(15; Usuario; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario';
        }
    }

    keys
    {
        key(Key1; "Tipo Documento", NoDocumento)
        {
        }
        key(Key2; Estado)
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetDocSF() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        IF NOT "Doc SF  XML".HASVALUE THEN EXIT('');
        CALCFIELDS("Doc SF  XML");
        "Doc SF  XML".CREATEINSTREAM(InStr);
        WHILE InStr.READTEXT(ReadPart) > 0 DO
            ProcessData += ReadPart;
    end;

    //TODO: Ver
    /*
    procedure SetDocSF(ArchivoDir: Text)
    var
        OutStr: OutStream;
        xmlDomDoc: DotNet XmlDocument;
    begin
        CLEAR("Doc SF  XML");
        xmlDomDoc := xmlDomDoc.XmlDocument;
        xmlDomDoc.Load(ArchivoDir);
        "Doc SF  XML".CREATEOUTSTREAM(OutStr);
        xmlDomDoc.Save(OutStr);
    end;*/

    procedure GetDocFirmado() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        IF NOT "Doc SF  XML".HASVALUE THEN EXIT('');
        CALCFIELDS("Doc SF  XML");
        "Doc SF  XML".CREATEINSTREAM(InStr);
        WHILE InStr.READTEXT(ReadPart) > 0 DO
            ProcessData += ReadPart;
    end;

    procedure SetDocFirmado(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc SF  XML");
        "Doc SF  XML".CREATEOUTSTREAM(OutStr);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetJsonEnviado() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        IF NOT "Doc SF  XML".HASVALUE THEN EXIT('');
        CALCFIELDS("Doc SF  XML");
        "Doc SF  XML".CREATEINSTREAM(InStr);
        WHILE InStr.READTEXT(ReadPart) > 0 DO
            ProcessData += ReadPart;
    end;

    procedure SetJsonEnviado(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc SF  XML");
        "Doc SF  XML".CREATEOUTSTREAM(OutStr);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetJsonRespuesta() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        IF NOT "Doc SF  XML".HASVALUE THEN EXIT('');
        CALCFIELDS("Doc SF  XML");
        "Doc SF  XML".CREATEINSTREAM(InStr);
        WHILE InStr.READTEXT(ReadPart) > 0 DO
            ProcessData += ReadPart;
    end;

    procedure SetJsonRespuesta(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc SF  XML");
        "Doc SF  XML".CREATEOUTSTREAM(OutStr);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetXmlRespuesta() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        IF NOT "Doc SF  XML".HASVALUE THEN EXIT('');
        CALCFIELDS("Doc SF  XML");
        "Doc SF  XML".CREATEINSTREAM(InStr);
        WHILE InStr.READTEXT(ReadPart) > 0 DO
            ProcessData += ReadPart;
    end;

    procedure SetXmlRespuesta(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc SF  XML");
        "Doc SF  XML".CREATEOUTSTREAM(OutStr);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetPDFGenerado() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        IF NOT "Doc SF  XML".HASVALUE THEN EXIT('');
        CALCFIELDS("Doc SF  XML");
        "Doc SF  XML".CREATEINSTREAM(InStr);
        WHILE InStr.READTEXT(ReadPart) > 0 DO
            ProcessData += ReadPart;
    end;

    procedure SetPDFGenerado(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc SF  XML");
        "Doc SF  XML".CREATEOUTSTREAM(OutStr);
        OutStr.WRITETEXT(ProcessData);
    end;
}

