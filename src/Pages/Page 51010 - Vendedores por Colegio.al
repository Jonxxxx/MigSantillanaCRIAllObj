page 51010 "Vendedores por Colegio"
{
    PageType = List;
    SourceTable = Table51014;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Vendedor";"Cod. Vendedor")
                {
                }
                field("Nombre Vendedor";"Nombre Vendedor")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

