page 55846 "Parametros vacaciones"
{
    Caption = 'Vacation parameters';
    PageType = List;
    SourceTable = 55828;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Desde; Rec.Desde)
                {
                    ApplicationArea = All;
                    ToolTip = 'Desde';
                }
                field("Cantidad de dias"; Rec."Cantidad de dias")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de dias';
                }
            }
        }
    }

    actions
    {
    }
}

