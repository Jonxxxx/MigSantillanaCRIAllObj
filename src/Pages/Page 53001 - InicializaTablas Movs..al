page 53001 "InicializaTablas Movs."
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
                Caption = 'Initialize Entries';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // TODO: Manual review - Custom report 53007 is unavailable in the current repository.
                // Original code: RunObject = Report 53007;
            }
        }
    }
}

