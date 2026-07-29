page 34003026 "Lin. Dimensiones Requeridas"
{
    PageType = ListPart;
    SourceTable = 34003023;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Dimension"; Rec."Cod. Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension';
                }
                field("Registro valor"; Rec."Registro valor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Registro valor';
                }
            }
        }
    }

    actions
    {
    }
}

