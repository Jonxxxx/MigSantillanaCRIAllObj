page 67095 "Colegio - Ranking - Nivel"
{
    PageType = Card;
    SourceTable = 67046;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Grupo de Negocio"; Rec."Grupo de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Negocio';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Categoria colegio"; Rec."Categoria colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria colegio';
                }
            }
        }
    }

    actions
    {
    }
}

