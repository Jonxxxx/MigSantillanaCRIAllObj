page 34002194 "Payroll -Job JNL Template List"
{
    Caption = 'Job Journal Template List';
    Editable = false;
    PageType = List;
    SourceTable = 34002174;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Name; Name)
                {
                }
                field(Description; Description)
                {
                }
                field("Test Report ID"; "Test Report ID")
                {
                    Visible = false;
                }
                field("Page ID"; "Page ID")
                {
                    Visible = false;
                }
                field("Posting Report ID"; "Posting Report ID")
                {
                    Visible = false;
                }
                field("Force Posting Report"; "Force Posting Report")
                {
                    Visible = false;
                }
                field("Test Report Caption"; "Test Report Caption")
                {
                    Visible = false;
                }
                field("Page Caption"; "Page Caption")
                {
                    Visible = false;
                }
                field("Posting Report Caption"; "Posting Report Caption")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

