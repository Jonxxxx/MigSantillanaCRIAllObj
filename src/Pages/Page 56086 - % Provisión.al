page 56086 "% Provisión"
{
    // 001 CAT 20/02/14  #144 Configuración de los porcentajes de insolvencias

    ApplicationArea = Basic,Suite,Service;
    PageType = List;
    SourceTable = Table56086;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Desde día";"Desde día")
                {
                }
                field(Descripción;Descripción)
                {
                }
                field("% Provisión";"% Provisión")
                {
                }
            }
        }
    }

    actions
    {
    }
}

