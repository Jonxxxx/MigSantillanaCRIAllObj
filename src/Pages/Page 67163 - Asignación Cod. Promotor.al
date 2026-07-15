page 67163 "Asignacion Cod. Promotor"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 91;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; "User ID")
                {
                    Editable = false;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

