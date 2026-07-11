page 67094 "Grupos de Negocio - Distrib."
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = 67086;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Código; Código)
                {
                }
                field(Descripción; Descripción)
                {
                }
                field(Porcentaje; Porcentaje)
                {
                    Caption = '%';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        DistrCentros: Record 67086;
        UserSetup: Record 91;
    begin

        CurrPage.EDITABLE := TRUE;
        UserSetup.GET(USERID);
        IF UserSetup."Salespers./Purch. Code" <> '' THEN
            IF NOT gModif THEN
                CurrPage.EDITABLE := FALSE;


        FILTERGROUP(2);
        IF gCodSolicitud <> '' THEN BEGIN
            SETRANGE("No. Solicitud", gCodSolicitud);
            SETRANGE("Cod. Taller - Evento");
            SETRANGE("Tipo Evento");
            SETRANGE(Expositor);
            SETRANGE(Secuencia);
        END
        ELSE BEGIN
            SETRANGE("No. Solicitud");
            SETRANGE("Cod. Taller - Evento", gCodEvento);
            SETRANGE("Tipo Evento", gTipoEvento);
            SETRANGE(Expositor, gExpositor);
            SETRANGE(Secuencia, gSecuencia);
        END;
        FILTERGROUP(2);

        IF NOT FINDFIRST THEN
            Calcular;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        rDist: Record 67086;
        wPorc: Decimal;
        Err001: Label 'El porcentaje de los centros de coste no deben ser mayores de 100.';
        Err002: Label 'El porcentaje de los centros de coste no deben ser menores de 0.';
    begin

        //IF "No. Solicitud" <> '' THEN BEGIN
        rDist.COPY(Rec);
        //rDist.SETRANGE(rDist."No. Solicitud", "No. Solicitud");
        IF rDist.FINDSET THEN
            REPEAT
                wPorc += rDist.Porcentaje;
            UNTIL rDist.NEXT = 0;

        IF wPorc > 100 THEN
            ERROR(Err001);

        IF wPorc < 0 THEN
            ERROR(Err002);
        //END;
    end;

    var
        ColAdopciones: Record 67053;
        Editoras: Record 67024;
        da: Record 67002;
        TotalGen: Decimal;
        Total: Decimal;
        Porciento: Decimal;
        gCodColegio: Code[20];
        gCodSolicitud: Code[20];
        gCodEvento: Code[20];
        gTipoEvento: Code[20];
        gTipoExpositor: Code[20];
        gExpositor: Code[20];
        gSecuencia: Integer;
        gGrupo: Boolean;
        gFiltroColegios: Text[1024];
        gModif: Boolean;
        gCodGrupo: Code[20];

    procedure RecibeParametros(CodCol: Code[20]; CodSol: Code[20]; CodEve: Code[20]; TipoEve: Code[20]; CodExpositor: Code[20]; Sec: Integer; Grupo: Boolean; modif: Boolean; CodGrupo: Code[20])
    var
        rGrupoCOL: Record 67089;
    begin
        gCodColegio := CodCol;
        gCodSolicitud := CodSol;
        gCodEvento := CodEve;
        gTipoEvento := TipoEve;
        gExpositor := CodExpositor;
        gSecuencia := Sec;
        gGrupo := Grupo;
        gCodGrupo := CodGrupo;
        IF gGrupo THEN BEGIN
            rGrupoCOL.GET(gCodGrupo);
            rGrupoCOL.CheckGrupo();
            gFiltroColegios := rGrupoCOL.GetColegios();
        END
        ELSE
            gFiltroColegios := '';
        gModif := modif;
    end;

    procedure Calcular()
    var
        DistrCentros: Record 67086;
    begin

        //IF gCodSolicitud = '' THEN
        //  EXIT;

        Editoras.SETRANGE(Santillana, TRUE);
        Editoras.FINDFIRST;
        ColAdopciones.RESET;
        IF gCodSolicitud <> '' THEN BEGIN
            IF gGrupo THEN
                ColAdopciones.SETFILTER("Cod. Colegio", gFiltroColegios)
            ELSE
                ColAdopciones.SETRANGE("Cod. Colegio", gCodColegio);
        END;
        ColAdopciones.SETRANGE("Cod. Editorial", Editoras.Code);
        IF ColAdopciones.FINDSET THEN
            TotalGen := ColAdopciones.COUNT;

        da.SETRANGE("Tipo registro", da."Tipo registro"::"Grupo de Negocio");
        IF da.FINDSET THEN
            REPEAT
                Total := 0;
                Porciento := 0;

                DistrCentros.INIT;
                DistrCentros."No. Solicitud" := gCodSolicitud;
                DistrCentros."Cod. Taller - Evento" := gCodEvento;
                DistrCentros."Tipo Evento" := gTipoEvento;
                DistrCentros.Expositor := gExpositor;
                DistrCentros.Secuencia := gSecuencia;
                DistrCentros.Código := da.Codigo;
                DistrCentros.Descripción := da.Descripcion;


                ColAdopciones.RESET;
                IF gCodSolicitud <> '' THEN BEGIN
                    IF gGrupo THEN
                        ColAdopciones.SETFILTER("Cod. Colegio", gFiltroColegios)
                    ELSE
                        ColAdopciones.SETRANGE("Cod. Colegio", gCodColegio);
                END;
                ColAdopciones.SETRANGE("Cod. Editorial", Editoras.Code);
                ColAdopciones.SETRANGE("Grupo de Negocio", Código);
                IF ColAdopciones.FINDSET THEN
                    Total := ColAdopciones.COUNT;

                IF (Total <> 0) AND (TotalGen <> 0) THEN
                    Porciento := ROUND(Total / TotalGen, 0.01) * 100;
                //    MESSAGE('%1 %2 %3 %4',TotalGen,Total);
                DistrCentros.Porcentaje := Porciento;
                DistrCentros.INSERT;
            UNTIL da.NEXT = 0;
    end;
}

