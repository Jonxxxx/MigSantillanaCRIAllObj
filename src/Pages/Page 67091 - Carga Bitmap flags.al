page 67091 "Carga Bitmap flags"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67032;
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

