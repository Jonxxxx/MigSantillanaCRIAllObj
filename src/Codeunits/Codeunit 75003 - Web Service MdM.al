codeunit 75003 "Web Service MdM"
{

    trigger OnRun()
    begin
    end;

    [Scope('Personalization')]
    procedure insert(mensaje: XMLport "75000;var result: XMLport "75003")
    var
        Msg: Text[250];
        lwOutStrm: OutStream;
        lwIDC: Integer;
    begin
        // Insert

        mensaje.IMPORT;
        mensaje.GetOutStrm(lwOutStrm);
        mensaje.SETDESTINATION(lwOutStrm);
        mensaje.EXPORT;
        mensaje.GestMessageXML(result);
    end;

    [Scope('Personalization')]
    procedure update(mensaje: XMLport "75001;

    var
        result: XMLport "75003")
    var
        Msg: Text[250];
        lwOutStrm: OutStream;
        lwIDR: Integer;
    begin
        // Update

        mensaje.IMPORT;
        mensaje.GetOutStrm(lwOutStrm);
        mensaje.SETDESTINATION(lwOutStrm);
        mensaje.EXPORT;
        mensaje.GestMessageXML(result);
    end;

    [Scope('Personalization')]
    procedure delete(mensaje: XMLport "75002;

    var
        result: XMLport "75003")
    var
        Msg: Text[250];
        lwOutStrm: OutStream;
        lwIDR: Integer;
    begin
        // Delete

        mensaje.IMPORT;
        mensaje.GetOutStrm(lwOutStrm);
        mensaje.SETDESTINATION(lwOutStrm);
        mensaje.EXPORT;
        mensaje.GestMessageXML(result);
    end;
}

