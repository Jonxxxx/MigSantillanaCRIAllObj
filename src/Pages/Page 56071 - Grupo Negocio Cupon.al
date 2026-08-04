page 56071 "Grupo Negocio Cupon"
{
    Editable = false;
    PageType = List;
    SourceTable = 55178;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Grupo Negocio"; Rec."Grupo Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo Negocio';
                }
                field("No. Cupon"; Rec."No. Cupon")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cupon';
                }
            }
        }
    }

    actions
    {
    }
}

