page 56086 "% Provisión"
{
    // 001 CAT 20/02/14  #144 Configuración de los porcentajes de insolvencias

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
                field("Desde día"; "Desde dia")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("% Provisión"; "% Provision")
                {
                }
            }
        }
    }

    actions
    {
    }
}

