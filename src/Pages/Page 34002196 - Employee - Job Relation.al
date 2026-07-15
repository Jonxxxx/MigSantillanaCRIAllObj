page 34002196 "Employee - Job Relation"
{
    PageType = List;
    SourceTable = 34002171;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    Visible = false;
                }
                field("Job No."; "Job No.")
                {
                }
                field("Job Task No."; "Job Task No.")
                {
                }
                field("Job Line Type"; "Job Line Type")
                {
                }
                field("Job Unit Price"; "Job Unit Price")
                {
                    Visible = false;
                }
                field("Job Description"; "Job Description")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Job Task Name"; "Job Task Name")
                {
                    Caption = 'Job Task Name';
                    Editable = false;
                    Visible = false;
                }
                field("% to distribute"; "% to distribute")
                {
                }
            }
        }
    }

    actions
    {
    }
}

