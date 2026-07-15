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
                field(Desde; Desde)
                {
                }
                field("Cantidad de dias"; "Cantidad de dias")
                {
                }
            }
        }
    }

    actions
    {
    }
}

