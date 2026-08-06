page 55222 "InicializaTablas Movs."
{

    layout
    {
        area(content)
        {
            group(group)
            {
                Caption = 'group';
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("<Action1000000003>")
            {
                ApplicationArea = All;
                Caption = 'Initialize Entries';
                ToolTip = 'Initialize Entries';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // TODO: Manual review - Custom report 55227 is unavailable in the current repository.
                // Original code: RunObject = Report 55227;
            }
        }
    }
}

