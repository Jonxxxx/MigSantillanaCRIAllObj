page 34002236 "DSNOM HR Role Center"
{
    Caption = 'Home';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(GeneralGroup)
            {
                part(PartPage; 1441)
                {
                    ApplicationArea = Basic, Suite;
                }
                part(PartPage1; 34002237)
                {
                }
                part(PartPage2; 34002238)
                {
                }
                part(PartPage3; 34002239)
                {
                }
            }
            group(GeneralGroup1)
            {
                systempart(Notes; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            ToolTip = 'Manage human resource processes, view';
            action(EmpleadosActivos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Active employees';
                Image = "Order";
                RunObject = Page 5201;
                RunPageView = WHERE(Status = CONST(Active));
                ToolTip = 'Visualize Employees with Active status';
            }
            action(EmpleadosInactivos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inactive Employees';
                RunObject = Page 5201;
                RunPageView = WHERE(Status = CONST(Inactive));
                ToolTip = 'View sales documents that are shipped but not yet invoiced.';
            }
            action(Empleados)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employees';
                Image = Item;
                RunObject = Page 5201;
                ToolTip = 'View or edit detailed information for the emplolyees.';
            }
        }
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
        area(sections)
        {
            group("Administration HR")
            {
                Caption = 'Administration HR';
                Image = HumanResources;
                action("Human Resources Unit of Measure")
                {
                    Caption = 'Human Resources Unit of Measure';
                    RunObject = Page 5236;
                    ToolTip = 'View or edit the Units in which you measure human resources'' work, such as Hours.';
                }
                action("Vend. Causes of Absence")
                {
                    Caption = 'Vend. Causes of Absence';
                    RunObject = Page 5210;
                    ToolTip = 'View or edit causes of absence for your vendor resources. These codes can be used to indicate various reasons for employee absences, such as sickness, vacation, personal days, personal emergencies, and so on.';
                }
                action("Causes of Inactivity")
                {
                    Caption = 'Causes of Inactivity';
                    RunObject = Page 5214;
                    ToolTip = 'Register causes of inactivity codes for your employees. These codes can be used for various reasons causing employee inactiveness, such as maternity leave, long-term illness, sabbatical, and so on.';
                }
                action("Grounds for Termination")
                {
                    Caption = 'Grounds for Termination';
                    RunObject = Page 5215;
                    ToolTip = 'View or edit grounds for termination codes for your employees. These codes can be used for various reasons for employee termination, such as dismissal, retirement, resignation, and so on.';
                }
                action(Unions)
                {
                    Caption = 'Unions';
                    RunObject = Page 5213;
                    ToolTip = 'View a list of labor and trade unions. For each union, the report shows the employees who are members of the union.';
                }
                action("Employment Contracts")
                {
                    Caption = 'Employment Contracts';
                    RunObject = Page 5217;
                    ToolTip = 'View or edit employment contracts.';
                }
                action(Relatives)
                {
                    Caption = 'Relatives';
                    Image = Relatives;
                    RunObject = Page 5208;
                    ToolTip = 'View a list of employees'' relatives for selected employees. For each employee, the report shows basic information about the employee''s relatives such as name and date of birth.';
                }
                action("Misc. Articles")
                {
                    Caption = 'Misc. Articles';
                    RunObject = Page 5218;
                    ToolTip = 'View the benefits that your employees receive and other articles that are in your employees'' possession (keys, computers, company cars, memberships in company clubs, and so on).';
                }
                action(Confidential)
                {
                    Caption = 'Confidential';
                    RunObject = Page 5220;
                    ToolTip = 'Register confidential information related to your employees such as salaries, stock option plans, pensions, and so on.';
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = Certificate;
                    RunObject = Page 5205;
                    ToolTip = 'View or register qualification codes for your employees. These codes can be used for various employee qualifications: job titles, employee computer skills, education, courses, and so on.';
                }
                action("Employee Statistics Groups")
                {
                    Caption = 'Employee Statistics Groups';
                    RunObject = Page 5216;
                    ToolTip = 'View or edit the grouping of employees for statistical purposes.';
                }
            }
        }
        area(processing)
        {
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("Human Resources Setup")
            {
                Caption = 'Human Resources Setup';
                RunObject = Page 5233;
                ToolTip = 'Set up number series for creating new employee cards and define if employment time is measured by days or hours.';
            }
        }
    }
}

