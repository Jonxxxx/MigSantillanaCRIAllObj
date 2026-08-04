page 55173 "Grupo Negocio Reg."
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
            }
        }
    }

    actions
    {
    }
}

