page 67106 "Planificacion Evento ListPart"
{
    Caption = 'Planned Events';
    PageType = CardPart;
    SourceTable = Table67051;

    layout
    {
        area(content)
        {
            field("Asistentes esperados";"Asistentes esperados")
            {
            }
            field("Total registrados";"Total registrados")
            {
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

