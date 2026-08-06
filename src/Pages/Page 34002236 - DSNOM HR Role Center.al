page 55876 "DSNOM HR Role Center"
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
                    ApplicationArea = All;
                }
                part(PartPage1; 55877)
                {
                }
                part(PartPage2; 55878)
                {
                }
                part(PartPage3; 55879)
                {
                }
            }
            group(GeneralGroup1)
            {
                systempart(Notes; MyNotes)
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Active employees';
                ToolTip = 'Active employees';
                Image = "Order";
                RunObject = Page 5201;
                RunPageView = WHERE(Status = CONST(Active));
            }
            action(EmpleadosInactivos)
            {
                ApplicationArea = All;
                Caption = 'Inactive Employees';
                ToolTip = 'Inactive Employees';
                RunObject = Page 5201;
                RunPageView = WHERE(Status = CONST(Inactive));
            }
            action(Empleados)
            {
                ApplicationArea = All;
                Caption = 'Employees';
                ToolTip = 'Employees';
                Image = Item;
                RunObject = Page 5201;
            }
        }
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
        area(sections)
        {
            group("Administration HR")
            {
                Caption = 'Administration HR';
                Image = HumanResources;
                action("Human Resources Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'Human Resources Unit of Measure';
                    ToolTip = 'Human Resources Unit of Measure';
                    RunObject = Page 5236;
                }
                action("Vend. Causes of Absence")
                {
                    ApplicationArea = All;
                    Caption = 'Vend. Causes of Absence';
                    ToolTip = 'Vend. Causes of Absence';
                    RunObject = Page 5210;
                }
                action("Causes of Inactivity")
                {
                    ApplicationArea = All;
                    Caption = 'Causes of Inactivity';
                    ToolTip = 'Causes of Inactivity';
                    RunObject = Page 5214;
                }
                action("Grounds for Termination")
                {
                    ApplicationArea = All;
                    Caption = 'Grounds for Termination';
                    ToolTip = 'Grounds for Termination';
                    RunObject = Page 5215;
                }
                action(Unions)
                {
                    ApplicationArea = All;
                    Caption = 'Unions';
                    ToolTip = 'Unions';
                    RunObject = Page 5213;
                }
                action("Employment Contracts")
                {
                    ApplicationArea = All;
                    Caption = 'Employment Contracts';
                    ToolTip = 'Employment Contracts';
                    RunObject = Page 5217;
                }
                action(Relatives)
                {
                    ApplicationArea = All;
                    Caption = 'Relatives';
                    ToolTip = 'Relatives';
                    Image = Relatives;
                    RunObject = Page 5208;
                }
                action("Misc. Articles")
                {
                    ApplicationArea = All;
                    Caption = 'Misc. Articles';
                    ToolTip = 'Misc. Articles';
                    RunObject = Page 5218;
                }
                action(Confidential)
                {
                    ApplicationArea = All;
                    Caption = 'Confidential';
                    ToolTip = 'Confidential';
                    RunObject = Page 5220;
                }
                action(Qualifications)
                {
                    ApplicationArea = All;
                    Caption = 'Qualifications';
                    ToolTip = 'Qualifications';
                    Image = Certificate;
                    RunObject = Page 5205;
                }
                action("Employee Statistics Groups")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Statistics Groups';
                    ToolTip = 'Employee Statistics Groups';
                    RunObject = Page 5216;
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
                ApplicationArea = All;
                Caption = 'Human Resources Setup';
                ToolTip = 'Human Resources Setup';
                RunObject = Page 5233;
            }
        }
    }
}

