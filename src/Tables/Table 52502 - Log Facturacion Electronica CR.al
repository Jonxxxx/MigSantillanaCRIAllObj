table 55201 "Log Facturacion Electronica CR"
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
        CALCFIELDS("Doc SF  XML");
        IF NOT "Doc SF  XML".HASVALUE THEN
            EXIT('');

        "Doc SF  XML".CREATEINSTREAM(InStr, TextEncoding::UTF8);
        WHILE NOT InStr.EOS DO BEGIN
            InStr.READTEXT(ReadPart);
            ProcessData += ReadPart;
        END;
    end;

    procedure SetDocSF(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc SF  XML");
        "Doc SF  XML".CREATEOUTSTREAM(OutStr, TextEncoding::UTF8);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetDocFirmado() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        CALCFIELDS("Doc Firmado  XML");
        IF NOT "Doc Firmado  XML".HASVALUE THEN
            EXIT('');

        "Doc Firmado  XML".CREATEINSTREAM(InStr, TextEncoding::UTF8);
        WHILE NOT InStr.EOS DO BEGIN
            InStr.READTEXT(ReadPart);
            ProcessData += ReadPart;
        END;
    end;

    procedure SetDocFirmado(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc Firmado  XML");
        "Doc Firmado  XML".CREATEOUTSTREAM(OutStr, TextEncoding::UTF8);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetJsonEnviado() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        CALCFIELDS("Doc Json envio  XML");
        IF NOT "Doc Json envio  XML".HASVALUE THEN
            EXIT('');

        "Doc Json envio  XML".CREATEINSTREAM(InStr, TextEncoding::UTF8);
        WHILE NOT InStr.EOS DO BEGIN
            InStr.READTEXT(ReadPart);
            ProcessData += ReadPart;
        END;
    end;

    procedure SetJsonEnviado(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc Json envio  XML");
        "Doc Json envio  XML".CREATEOUTSTREAM(OutStr, TextEncoding::UTF8);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetJsonRespuesta() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        CALCFIELDS("Doc Json Respuesta  XML");
        IF NOT "Doc Json Respuesta  XML".HASVALUE THEN
            EXIT('');

        "Doc Json Respuesta  XML".CREATEINSTREAM(InStr, TextEncoding::UTF8);
        WHILE NOT InStr.EOS DO BEGIN
            InStr.READTEXT(ReadPart);
            ProcessData += ReadPart;
        END;
    end;

    procedure SetJsonRespuesta(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc Json Respuesta  XML");
        "Doc Json Respuesta  XML".CREATEOUTSTREAM(OutStr, TextEncoding::UTF8);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetXmlRespuesta() ProcessData: Text
    var
        InStr: InStream;
        ReadPart: Text;
    begin
        CALCFIELDS("Doc Respuesta  XML");
        IF NOT "Doc Respuesta  XML".HASVALUE THEN
            EXIT('');

        "Doc Respuesta  XML".CREATEINSTREAM(InStr, TextEncoding::UTF8);
        WHILE NOT InStr.EOS DO BEGIN
            InStr.READTEXT(ReadPart);
            ProcessData += ReadPart;
        END;
    end;

    procedure SetXmlRespuesta(ProcessData: Text)
    var
        OutStr: OutStream;
    begin
        CLEAR("Doc Respuesta  XML");
        "Doc Respuesta  XML".CREATEOUTSTREAM(OutStr, TextEncoding::UTF8);
        OutStr.WRITETEXT(ProcessData);
    end;

    procedure GetPDFGenerado(var PdfInStream: InStream): Boolean
    begin
        CALCFIELDS("Doc Pdf Generado");
        IF NOT "Doc Pdf Generado".HASVALUE THEN
            EXIT(FALSE);

        "Doc Pdf Generado".CREATEINSTREAM(PdfInStream);
        EXIT(TRUE);
    end;

    procedure SetPDFGenerado(PdfInStream: InStream)
    var
        PdfOutStream: OutStream;
    begin
        CLEAR("Doc Pdf Generado");
        "Doc Pdf Generado".CREATEOUTSTREAM(PdfOutStream);
        COPYSTREAM(PdfOutStream, PdfInStream);
    end;
}
