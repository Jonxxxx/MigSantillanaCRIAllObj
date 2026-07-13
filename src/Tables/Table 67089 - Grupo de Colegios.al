table 67089 "Grupo de Colegios"
{

    fields
    {
        field(1; "Cod. Grupo"; Code[20])
        {
        }
        field(2; "Descripcion"; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "Cod. Grupo")
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetColegios() rtn: Text[1024]
    var
        ColGrupo: Record 67090;
    begin
        ColGrupo.SETRANGE(ColGrupo."Cod. grupo", "Cod. Grupo");
        IF ColGrupo.FINDSET THEN
            REPEAT
                IF rtn = '' THEN
                    rtn := ColGrupo."Cod. Colegio"
                ELSE
                    rtn := rtn + '|' + ColGrupo."Cod. Colegio";
            UNTIL ColGrupo.NEXT = 0;
    end;

    procedure CheckGrupo()
    var
        ColGrupo: Record 67090;
        Err001: Label 'El grupo %1 no tiene colegios asociados';
    begin
        ColGrupo.SETRANGE(ColGrupo."Cod. grupo", "Cod. Grupo");
        IF NOT ColGrupo.FINDFIRST THEN
            ERROR(Err001, "Cod. Grupo");
    end;
}

