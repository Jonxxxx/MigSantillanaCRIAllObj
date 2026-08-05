page 55529 Fechas
{
    Editable = false;
    PageType = ListPlus;
    SourceTable = 2000000007;
    SourceTableView = WHERE("Period Type" = CONST(Week));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Period Type"; Rec."Period Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Period Type';
                }
                field("Period Start"; Rec."Period Start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Period Start';
                }
                field("Period End"; NORMALDATE(Rec."Period End"))
                {
                    ApplicationArea = All;
                    Caption = 'Period End';
                }
                field("Period No."; Rec."Period No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Period No.';
                }
            }
        }
    }

    actions
    {
    }
}

