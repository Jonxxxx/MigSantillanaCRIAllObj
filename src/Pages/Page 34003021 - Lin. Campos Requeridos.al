page 34003021 "Lin. Campos Requeridos"
{
    PageType = ListPart;
    SourceTable = 34003021;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Campo"; Rec."No. Campo")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Campo';
                }
                field("Nombre Campo"; Rec."Nombre Campo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Campo';
                }
            }
        }
    }

    actions
    {
    }
}

