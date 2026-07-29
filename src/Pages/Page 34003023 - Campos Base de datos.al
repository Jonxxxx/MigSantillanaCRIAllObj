page 34003023 "Campos Base de datos"
{
    Editable = false;
    PageType = List;
    SourceTable = 64829;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Database Code"; Rec."Database Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Database Code';
                }
                field("Table No."; Rec."Table No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Table No.';
                }
                field("Field No."; Rec."Field No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Field No.';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Field Name';
                }
                field("Field Type"; Rec."Field Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Field Type';
                }
                field("Field Length"; Rec."Field Length")
                {
                    ApplicationArea = All;
                    ToolTip = 'Field Length';
                }
                field("Field Option"; Rec."Field Option")
                {
                    ApplicationArea = All;
                    ToolTip = 'Field Option';
                }
                field("Field Class"; Rec."Field Class")
                {
                    ApplicationArea = All;
                    ToolTip = 'Field Class';
                }
            }
        }
    }

    actions
    {
    }
}

