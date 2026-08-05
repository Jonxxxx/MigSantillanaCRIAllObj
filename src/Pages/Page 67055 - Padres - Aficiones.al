page 55522 "Padres - Aficiones"
{
    PageType = Card;
    SourceTable = 55516;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Padre"; Rec."Cod. Padre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Padre';
                }
                field("Nombre Padre"; Rec."Nombre Padre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Padre';
                }
                field("Cod. aficion"; Rec."Cod. aficion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. aficion';
                }
                field("Descripcion aficion"; Rec."Descripcion aficion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion aficion';
                }
            }
        }
    }

    actions
    {
    }
}

