page 67117 "Exposit. - Eventos  ListPart"
{
    Caption = 'Expositors - Events';
    PageType = ListPart;
    SourceTable = 55517;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Evento"; Rec."Cod. Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Evento';
                    Visible = false;
                }
                field("Cod. Expositor"; Rec."Cod. Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Expositor';
                }
                field("Tipo de Expositor"; Rec."Tipo de Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Expositor';
                }
                field("Nombre Expositor"; Rec."Nombre Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Expositor';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
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

