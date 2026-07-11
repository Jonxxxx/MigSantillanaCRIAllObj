page 67132 "Solicitud - Proposición Fechas"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 67088;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fecha propuesta"; "Fecha propuesta")
                {
                }
                field("Hora Inicio"; "Hora Inicio")
                {
                }
                field("Hora Fin"; "Hora Fin")
                {
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
                field("No. asistentes"; "No. asistentes")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        rProp: Record 67088;
        rSol: Record 67055;
        TieneGrado: Boolean;
        wAsis: Integer;
        Err001: Label 'El número de asistentes definidos supera al número de asistentes esperados de la solicitud';
    begin
        rProp.COPY(Rec);
        rProp.SETRANGE(rProp."No. Solicitud", "No. Solicitud");
        IF rProp.FINDSET THEN
            REPEAT
                IF rProp."Cod. Grado" <> '' THEN
                    TieneGrado := TRUE;
                wAsis += rProp."No. asistentes"
            UNTIL rProp.NEXT = 0;

        IF TieneGrado THEN BEGIN

            rSol.GET("No. Solicitud");

            IF wAsis > rSol."Asistentes Esperados" THEN
                ERROR(Err001);

        END;
    end;

    var
        [InDataSet]
        wAceptar: Boolean;

    procedure Aceptar(pAcp: Boolean)
    begin
        wAceptar := pAcp
    end;

    procedure Parametros(par_Editable: Boolean)
    begin
        CurrPage.EDITABLE(par_Editable);
    end;
}

