codeunit 56200 "Web Service MdE"
{

    trigger OnRun()
    begin
    end;

    var
    //TODO: Ver NS: ;

    [Scope('Personalization')]
    procedure Empleado(mae: XMLport 56200; var result: XMLport 56201)
    var
        IsOk: Boolean;
        id_mensaje: Text[36];
        Tipo: Text[20];
        FechaOrigen: Text[30];
        PaisOrigen: Text[20];
        DescErrorArray: array[10] of Text;
        TipoErrorArray: array[10] of Text;
        OutStrm: OutStream;
    begin
        mae.IMPORT;
        //TODO: Ver mae.GetInfo(IsOk, id_mensaje, Tipo, FechaOrigen, PaisOrigen, DescErrorArray, TipoErrorArray);

        //+#101415
        //TODO: Ver mae.GetOutStrm(OutStrm);
        mae.SETDESTINATION(OutStrm);
        mae.EXPORT;
        //TODO: Ver mae.SendAsyncResponse();
        //-#101415

        //TODO: Ver result.SetInfo(id_mensaje, Tipo, FechaOrigen, PaisOrigen);
    end;
}

