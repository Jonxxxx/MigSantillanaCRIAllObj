page 67132 "Solicitud - Proposicion Fechas"
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
                field("Fecha propuesta"; Rec."Fecha propuesta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha propuesta';
                }
                field("Hora Inicio"; Rec."Hora Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Inicio';
                }
                field("Hora Fin"; Rec."Hora Fin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Fin';
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                }
                field("No. asistentes"; Rec."No. asistentes")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. asistentes';
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
        rSol: Record 55522;
        TieneGrado: Boolean;
        wAsis: Integer;
        Err001: Label 'El Numero de asistentes definidos supera al Numero de asistentes esperados de la solicitud';
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

