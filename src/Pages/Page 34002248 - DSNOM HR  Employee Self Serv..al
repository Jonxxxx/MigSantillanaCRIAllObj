page 34002248 "DSNOM HR  Employee Self Serv."
{
    Caption = 'Home';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(GeneralGroup)
            {
                part(PartPage; 34002237)
                {
                }
                part(PartPage1; 34002238)
                {
                }
                part(PartPage2; 34002239)
                {
                }
            }
            group(GeneralGroup2)
            {
                systempart(Notes; Notes)
                {
                }
                systempart(Notes1; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Employee - Labels")
            {
                Caption = 'Employee - Labels';
                Image = "Report";
                //TODO: Ver RunObject = Report 5200;
                ToolTip = 'View a list of employees'' mailing labels.';
            }
            action("Employee - List")
            {
                Caption = 'Employee - List';
                Image = "Report";
                //TODO: Ver RunObject = Report 5201;
                ToolTip = 'View a list of all employees.';
            }
            action("Employee - Misc. Article Info.")
            {
                Caption = 'Employee - Misc. Article Info.';
                Image = "Report";
                //TODO: Ver RunObject = Report 5202;
                ToolTip = 'View a list of employees'' miscellaneous articles.';
            }
            action("Employee - Confidential Info.")
            {
                Caption = 'Employee - Confidential Info.';
                Image = "Report";
                //TODO: Ver RunObject = Report 5203;
                ToolTip = 'View a list of employees'' confidential information.';
            }
            action("Employee - Staff Absences")
            {
                Caption = 'Employee - Staff Absences';
                Image = "Report";
                //TODO: Ver RunObject = Report 5204;
                ToolTip = 'View a list of employee absences by date. The list includes the cause of each employee absence.';
            }
            action("Employee - Absences by Causes")
            {
                Caption = 'Employee - Absences by Causes';
                Image = "Report";
                //TODO: Ver RunObject = Report 5205;
                ToolTip = 'View a list of all employees'' absences categorized by absence code.';
            }
            action("Employee - Qualifications")
            {
                Caption = 'Employee - Qualifications';
                Image = "Report";
                //TODO: Ver RunObject = Report 5206;
                ToolTip = 'View a list of employees'' qualifications.';
            }
            action("Employee - Addresses")
            {
                Caption = 'Employee - Addresses';
                Image = "Report";
                //TODO: Ver RunObject = Report 5207;
                ToolTip = 'View a list of employees'' addresses.';
            }
            action("Employee - Relatives")
            {
                Caption = 'Employee - Relatives';
                Image = "Report";
                //TODO: Ver RunObject = Report 5208;
                ToolTip = 'View a list of employees'' relatives.';
            }
            action("Employee - Birthdays")
            {
                Caption = 'Employee - Birthdays';
                Image = "Report";
                //TODO: Ver RunObject = Report 5209;
                ToolTip = 'View a list of employees'' birthdays.';
            }
            action("Employee - Phone Nos.")
            {
                Caption = 'Employee - Phone Nos.';
                Image = "Report";
                //TODO: Ver RunObject = Report 5210;
                ToolTip = 'View a list of employees'' phone numbers.';
            }
            action("Employee - Unions")
            {
                Caption = 'Employee - Unions';
                Image = "Report";
                //TODO: Ver RunObject = Report 5211;
                ToolTip = 'View a list of employees'' union memberships.';
            }
            action("Employee - Contracts")
            {
                Caption = 'Employee - Contracts';
                Image = "Report";
                //TODO: Ver RunObject = Report 5212;
                ToolTip = 'View all employee contracts.';
            }
            action("Employee - Alt. Addresses")
            {
                Caption = 'Employee - Alt. Addresses';
                Image = "Report";
                //TODO: Ver RunObject = Report 5213;
                ToolTip = 'View a list of employees'' alternate addresses.';
            }
        }
    }
}

