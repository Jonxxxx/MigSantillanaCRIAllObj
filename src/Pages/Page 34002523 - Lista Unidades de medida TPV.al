page 34002523 "Lista Unidades de medida TPV"
{
    PageType = List;
    SourceTable = 5404;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item No.';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Qty. per Unit of Measure';
                }
            }
        }
    }

    actions
    {
    }
}

