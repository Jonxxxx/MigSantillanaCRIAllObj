page 34002204 "DSNOM Tools FactBox"
{
    Caption = 'Tools in use';
    PageType = CardPart;
    SourceTable = 5214;
    SourceTableView = WHERE("In Use" = CONST(True));

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'From Date';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Serial No.';
                }
            }
        }
    }

    actions
    {
    }
}

