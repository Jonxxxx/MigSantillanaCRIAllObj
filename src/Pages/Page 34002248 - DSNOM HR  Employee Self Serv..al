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
                ApplicationArea = All;
                Caption = 'Employee - Labels';
                ToolTip = 'Employee - Labels';
                Image = "Report";
                RunObject = Report 5200;
            }
            action("Employee - List")
            {
                ApplicationArea = All;
                Caption = 'Employee - List';
                ToolTip = 'Employee - List';
                Image = "Report";
                RunObject = Report 5201;
            }
            action("Employee - Misc. Article Info.")
            {
                ApplicationArea = All;
                Caption = 'Employee - Misc. Article Info.';
                ToolTip = 'Employee - Misc. Article Info.';
                Image = "Report";
                RunObject = Report 5202;
            }
            action("Employee - Confidential Info.")
            {
                ApplicationArea = All;
                Caption = 'Employee - Confidential Info.';
                ToolTip = 'Employee - Confidential Info.';
                Image = "Report";
                RunObject = Report 5203;
            }
            action("Employee - Staff Absences")
            {
                ApplicationArea = All;
                Caption = 'Employee - Staff Absences';
                ToolTip = 'Employee - Staff Absences';
                Image = "Report";
                RunObject = Report 5204;
            }
            action("Employee - Absences by Causes")
            {
                ApplicationArea = All;
                Caption = 'Employee - Absences by Causes';
                ToolTip = 'Employee - Absences by Causes';
                Image = "Report";
                RunObject = Report 5205;
            }
            action("Employee - Qualifications")
            {
                ApplicationArea = All;
                Caption = 'Employee - Qualifications';
                ToolTip = 'Employee - Qualifications';
                Image = "Report";
                RunObject = Report 5206;
            }
            action("Employee - Addresses")
            {
                ApplicationArea = All;
                Caption = 'Employee - Addresses';
                ToolTip = 'Employee - Addresses';
                Image = "Report";
                RunObject = Report 5207;
            }
            action("Employee - Relatives")
            {
                ApplicationArea = All;
                Caption = 'Employee - Relatives';
                ToolTip = 'Employee - Relatives';
                Image = "Report";
                RunObject = Report 5208;
            }
            action("Employee - Birthdays")
            {
                ApplicationArea = All;
                Caption = 'Employee - Birthdays';
                ToolTip = 'Employee - Birthdays';
                Image = "Report";
                RunObject = Report 5209;
            }
            action("Employee - Phone Nos.")
            {
                ApplicationArea = All;
                Caption = 'Employee - Phone Nos.';
                ToolTip = 'Employee - Phone Nos.';
                Image = "Report";
                RunObject = Report 5210;
            }
            action("Employee - Unions")
            {
                ApplicationArea = All;
                Caption = 'Employee - Unions';
                ToolTip = 'Employee - Unions';
                Image = "Report";
                RunObject = Report 5211;
            }
            action("Employee - Contracts")
            {
                ApplicationArea = All;
                Caption = 'Employee - Contracts';
                ToolTip = 'Employee - Contracts';
                Image = "Report";
                RunObject = Report 5212;
            }
            action("Employee - Alt. Addresses")
            {
                ApplicationArea = All;
                Caption = 'Employee - Alt. Addresses';
                ToolTip = 'Employee - Alt. Addresses';
                Image = "Report";
                RunObject = Report 5213;
            }
        }
    }
}

