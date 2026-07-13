page 51010 "Vendedores por Colegio"
{
    PageType = List;
    SourceTable = 51014;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Vendedor"; "Cod. Vendedor")
                {
                }
                field("Nombre Vendedor"; "Nombre Vendedor")
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

