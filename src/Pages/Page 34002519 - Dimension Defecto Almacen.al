page 55913 "Dimension Defecto Almacen"
{
    PageType = List;
    SourceTable = 55913;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo Dimension"; Rec."Codigo Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Dimension';
                }
                field("Valor Dimension"; Rec."Valor Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor Dimension';
                }
            }
        }
    }

    actions
    {
    }
}

