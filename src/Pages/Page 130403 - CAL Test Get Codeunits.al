page 130403 "CAL Test Get Codeunits"
{
    Caption = 'CAL Test Get Codeunits';
    Editable = false;
    PageType = List;
    SourceTable = 2000000058;
    SourceTableView = WHERE("Object Type" = CONST(Codeunit),
                            "Object Subtype" = CONST(Test));

    layout
    {
        area(content)
        {
            repeater(General)
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

