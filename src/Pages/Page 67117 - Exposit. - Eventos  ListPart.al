page 67117 "Exposit. - Eventos  ListPart"
{
    Caption = 'Expositors - Events';
    PageType = ListPart;
    SourceTable = 67050;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Evento"; "Cod. Evento")
                {
                    Visible = false;
                }
                field("Cod. Expositor"; "Cod. Expositor")
                {
                }
                field("Tipo de Expositor"; "Tipo de Expositor")
                {
                }
                field("Nombre Expositor"; "Nombre Expositor")
                {
                }
                field(Delegacion; Delegacion)
                {
                }
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

