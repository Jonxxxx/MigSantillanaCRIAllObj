codeunit 55684 "Web Service MdM"
{

    trigger OnRun()
    begin
    end;

    [Scope('Personalization')]
    procedure insert(mensaje: XMLport 55681; var result: XMLport 55684)
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
    procedure update(mensaje: XMLport 55682; var result: XMLport 55684)
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
    procedure delete(mensaje: XMLport 55683; var result: XMLport 55684)
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

