table 75002 "Estructura Analitica"
{
    DrillDownPageID = 75002;
    LookupPageID = 75002;

    fields
    {
        field(1; Codigo; Code[21])
        {

            trigger OnValidate()
            begin
                SetNivel;
            end;
        }
        field(10; Nivel; Integer)
        {
        }
        field(11; Descripcion; Text[100])
        {
        }
        field(50; Blocked; Boolean)
        {
            Caption = 'Blocked';

            trigger OnValidate()
            var
                EstrAna: Record 75002;
                i: Integer;
                NuevoCodigo: Code[21];
                EndLoop: Boolean;
            begin
                // Si el nivel est  bloqueado y cambia, hay que verificar que el nivel menor no est  bloqueado
                IF Blocked <> xRec.Blocked THEN BEGIN
                    IF NOT Blocked AND (Nivel > 1) THEN BEGIN
                        EstrAna.SETRANGE(Nivel, Nivel - 1);
                        i := STRLEN(Codigo);
                        REPEAT
                            i := i - 1;

                            NuevoCodigo := COPYSTR(Codigo, 1, i);

                            EstrAna.SETRANGE(Codigo, NuevoCodigo);
                            IF EstrAna.FINDFIRST THEN BEGIN
                                IF EstrAna.Blocked THEN
                                    ERROR(Text002, NuevoCodigo)
                                ELSE
                                    EndLoop := TRUE;
                            END;
                        UNTIL (i = 1) OR EndLoop;
                    END;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }

    trigger OnDelete()
    var
        EstrAna: Record 75002;
    begin
        EstrAna.SETFILTER(Codigo, Codigo + '*');
        EstrAna.SETFILTER(Nivel, '>%1', Nivel);
        EstrAna.DELETEALL;
    end;

    trigger OnInsert()
    begin
        SetNivel;
    end;

    trigger OnModify()
    var
        EstrAna: Record 75002;
        UnBlock: Boolean;
    begin
        // Si se modifica el bloqueo, hay que actualizar los bloqueos de los niveles mayores
        IF Blocked <> xRec.Blocked THEN BEGIN
            EstrAna.SETFILTER(Codigo, Codigo + '*');
            EstrAna.SETFILTER(Nivel, '>%1', Nivel);
            IF EstrAna.FINDFIRST THEN BEGIN
                IF Blocked THEN
                    EstrAna.MODIFYALL(Blocked, TRUE)
                ELSE BEGIN
                    IF HideWindow THEN
                        UnBlock := TRUE
                    ELSE
                        UnBlock := CONFIRM(Text001, FALSE);
                    IF UnBlock THEN
                        EstrAna.MODIFYALL(Blocked, FALSE);
                END;
            END;
        END;
    end;

    var
        Text001: Label ' Quieres desbloquear los niveles dependientes de este nivel?';
        HideWindow: Boolean;
        Text002: Label 'No se puede desbloquear, el nivel superior (%1) est  bloqueado.';

    procedure SetNivel()
    var
        lwCode: Code[21];
        lwOk: Boolean;
        lrEA: Record 75002;
    begin
        // SetNivel
        // Automatiza el nivel

        // Una manera mejor de determinar el nivel
        Nivel := STRLEN(Codigo) DIV 3;
        /*
        Nivel := 0;
        lwCode := Codigo;
        IF lwCode = '' THEN
          EXIT;
        
        lwOk := FALSE;
        
        CLEAR(lrEA);
        WHILE NOT lwOk DO BEGIN
          lwCode := COPYSTR(lwCode,1,STRLEN(lwCode)-1);
          lwOk := lwCode = '';
          IF lwOk THEN
            Nivel := 1
          ELSE BEGIN
            lwOk := lrEA.GET(lwCode);
            IF lwOk THEN
              Nivel := lrEA.Nivel +1;
          END;
        END;
        */

    end;

    procedure SetHideWindow(NewHideWindow: Boolean)
    begin
        HideWindow := NewHideWindow;
    end;
}

