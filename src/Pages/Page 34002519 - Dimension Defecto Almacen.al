page 34002519 "Dimension Defecto Almacen"
{
    PageType = List;
    SourceTable = 34002519;

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

