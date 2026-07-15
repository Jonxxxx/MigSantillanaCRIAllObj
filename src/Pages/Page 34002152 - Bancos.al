page 34002152 Bancos
{
    PageType = List;
    SourceTable = 34002139;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Codigo; Codigo)
                {
                }
                field("Nombre banco"; "Nombre banco")
                {
                }
                field("ID Banco"; "ID Banco")
                {
                }
                field(Formato; Formato)
                {
                }
            }
        }
    }

    actions
    {
    }
}

