page 67106 "Planificacion Evento ListPart"
{
    Caption = 'Planned Events';
    PageType = CardPart;
    SourceTable = 55518;

    layout
    {
        area(content)
        {
            field("Asistentes esperados"; Rec."Asistentes esperados")
            {
                ApplicationArea = All;
                ToolTip = 'Asistentes esperados';
            }
            field("Total registrados"; Rec."Total registrados")
            {
                ApplicationArea = All;
                ToolTip = 'Total registrados';
            }
        }
    }

    actions
    {
    }

    var
        gCodDocente: Code[20];

    procedure RecibeParametro(CodDocente: Code[20])
    begin
        gCodDocente := CodDocente;
    end;
}

