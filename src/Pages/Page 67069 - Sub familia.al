page 67069 "Sub familia"
{
    PageType = Card;
    SourceTable = 67002;
    SourceTableView = WHERE("Tipo registro" = CONST("Sub familia"));

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
            }
        }
    }

    actions
    {
    }
}

