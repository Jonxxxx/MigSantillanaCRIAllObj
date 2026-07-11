page 130402 "CAL Test Codeunits"
{
    Caption = 'CAL Test Codeunits';
    Editable = false;
    PageType = List;
    SourceTable = 2000000058;
    SourceTableView = WHERE("Object Type" = CONST(Codeunit),
                            "Object Subtype" = CONST(Test));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Object ID"; "Object ID")
                {
                    ApplicationArea = All;
                }
                field("Object Name"; "Object Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

