page 67093 "Grupos de Negocio"
{
    ApplicationArea = Basic,Suite,Service;
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = WHERE(Tipo registro=CONST(Grupo de Negocio));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Codigo;Codigo)
                {
                }
                field(Descripcion;Descripcion)
                {
                }
            }
        }
    }

    actions
    {
    }
}

