page 55306 "% Provision"
{
    // 001 CAT 20/02/14  #144 Configuracion de los porcentajes de insolvencias

    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 55306;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Desde dia"; Rec."Desde dia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desde dia';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("% Provision"; Rec."% Provision")
                {
                    ApplicationArea = All;
                    ToolTip = '% Provision';
                }
            }
        }
    }

    actions
    {
    }
}

