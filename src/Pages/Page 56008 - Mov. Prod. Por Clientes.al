page 56008 "Mov. Prod. Por Clientes"
{
    PageType = List;
    SourceTable = 32;
    SourceTableView = SORTING(Entry No.)
                      ORDER(Ascending)
                      WHERE("Source Type" = FILTER(Customer));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Source No."; "Source No.")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Sales Amount (Actual)"; "Sales Amount (Actual)")
                {
                }
            }
        }
    }

    actions
    {
    }
}

