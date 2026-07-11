page 67136 "Colegio - Work Flow Objetivos"
{
    AutoSplitKey = true;
    Caption = 'School - programming Work flow';
    DeleteAllowed = false;
    PageType = ListPlus;
    SourceTable = 67062;
    SourceTableView = WHERE("Area" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Detalle; Detalle)
                {
                    Editable = false;
                }
                field(Mantenimiento; Mantenimiento)
                {
                }
                field(Conquista; Conquista)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Sec := 0;
        CWF.RESET;
        CWF.SETRANGE("Cod. Promotor", "Cod. Promotor");
        CWF.SETRANGE("Cod. Colegio", "Cod. Colegio");
        CWF.SETRANGE(Area, TRUE);
        IF NOT CWF.FINDFIRST THEN BEGIN
            DatosAux.RESET;
            DatosAux.SETRANGE("Tipo registro", DatosAux."Tipo registro"::"Area principal");
            DatosAux.FIND('-');
            REPEAT
                Sec += 1000;
                INIT;
                "Cod. Colegio" := "Cod. Colegio";
                Secuencia := Sec;
                Detalle := DatosAux.Descripcion;
                Area := TRUE;
                INSERT;
            UNTIL DatosAux.NEXT = 0;
        END;
    end;

    var
        CWF: Record 67062;
        DatosAux: Record 67002;
        Sec: Integer;
}

