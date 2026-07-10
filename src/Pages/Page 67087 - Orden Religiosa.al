page 67087 "Orden Religiosa"
{
    ApplicationArea = Basic,Suite,Service;
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = WHERE(Tipo registro=CONST(Orden religiosa));
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

