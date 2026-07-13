page 67169 "Atenciones - Grupos de Negocio"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = 67101;

    layout
    {
        area(content)
        {
            repeater(General)
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


        IF NOT FINDFIRST THEN
            Calcular;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        rDist: Record 67101;
        wPorc: Decimal;
        Err001: Label 'El porcentaje de los centros de coste no deben ser mayores de 100.';
        Err002: Label 'El porcentaje de los centros de coste no deben ser menores de 0.';
    begin

        rDist.COPY(Rec);
        IF rDist.FINDSET THEN
            REPEAT
                wPorc += rDist.Porcentaje;
            UNTIL rDist.NEXT = 0;

        IF wPorc > 100 THEN
            ERROR(Err001);

        IF wPorc < 0 THEN
            ERROR(Err002);
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
    end;

    procedure Calcular()
    var
        DistrCentros: Record 67101;
    begin



        da.SETRANGE("Tipo registro", da."Tipo registro"::"Grupo de Negocio");
        IF da.FINDSET THEN
            REPEAT
                Total := 0;
                Porciento := 0;

                DistrCentros.INIT;
                DistrCentros."No. Atención" := "No. Atención";
                DistrCentros.Código := da.Codigo;
                DistrCentros.Descripción := da.Descripcion;
                DistrCentros.Porcentaje := Porciento;
                DistrCentros.INSERT;
            UNTIL da.NEXT = 0;
    end;
}

