page 55973 "Lin. Campos Requeridos"
{
    PageType = ListPart;
    SourceTable = 55973;

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

