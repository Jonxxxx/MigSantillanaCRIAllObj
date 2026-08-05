page 55550 "Carga Bitmap flags"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = 55499;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
                field(Bitmap; Rec.Bitmap)
                {
                    ApplicationArea = All;
                    ToolTip = 'Bitmap';
                }
            }
        }
    }

    actions
    {
    }
}

