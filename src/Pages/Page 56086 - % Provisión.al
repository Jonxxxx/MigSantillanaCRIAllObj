page 56086 "% Provision"
{
    // 001 CAT 20/02/14  #144 Configuracion de los porcentajes de insolvencias

    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 56086;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Desde dia"; "Desde dia")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("% Provision"; "% Provision")
                {
                }
            }
        }
    }

    actions
    {
    }
}

