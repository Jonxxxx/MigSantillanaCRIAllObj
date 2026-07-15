page 34002203 "DSNOM Qualification FactBox"
{
    Caption = 'Training agreements';
    PageType = CardPart;
    SourceTable = 5203;
    SourceTableView = WHERE("Acuerdo de permanencia" = CONST(True));

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                field(Description; FORMAT(Description))
                {
                }
                field("Expiration Date"; "Expiration Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

