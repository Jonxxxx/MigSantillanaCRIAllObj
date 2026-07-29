page 34002205 "Parametros vacaciones"
{
    Caption = 'Vacation parameters';
    PageType = List;
    SourceTable = 34002187;

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

