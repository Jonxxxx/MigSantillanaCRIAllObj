page 55172 "Grupo Negocio - Cupon Lote"
{
    PageType = List;
    SourceTable = 55177;

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

