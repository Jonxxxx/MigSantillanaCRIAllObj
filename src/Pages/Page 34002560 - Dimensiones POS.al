page 34002560 "Dimensiones POS"
{
    // #217374, RRT, 10.09.19: Se aprovecha este desarrollo para renumerar la tabla "Dimensiones POS".

    PageType = List;
    SourceTable = 34002536;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Dimension; Dimension)
                {
                }
                field("Valor dimension"; "Valor dimension")
                {
                }
            }
        }
    }

    actions
    {
    }
}

