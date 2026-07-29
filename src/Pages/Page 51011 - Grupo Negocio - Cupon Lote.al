page 51011 "Grupo Negocio - Cupon Lote"
{
    PageType = List;
    SourceTable = 51016;

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

