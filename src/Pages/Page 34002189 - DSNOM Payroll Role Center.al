page 34002189 "DSNOM Payroll Role Center"
{
    Caption = 'Home';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(PartPageA; 34002260)
            {
                ApplicationArea = Basic, Suite;
            }
            group(GeneralGroupA)
            {
                part(PartPageB; 34002237)
                {
                }
                part(PartPageC; 34002238)
                {
                }
            }
            group(GeneralGroupB)
            {
                part(PartPageE; 34002239)
                {
                }
                part(PartPageF; 34002240)
                {
                }
            }
            group(GeneralGroupC)
            {
                part(PartPageG; 34002253)
                {
                }
            }
            group(GeneralGroupD)
            {
                part(PartPage; 34002241)
                {
                }
            }
            group(GeneralGroupE)
            {
                chartpart("DSNOM-1001"; "DSNOM-1001")
                {
                }
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
            action(Empleados)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employees';
                Image = Item;
                RunObject = Page 5201;
                ToolTip = 'View or edit detailed information for the emplolyees.';
            }
            action(regAu)
            {
                Caption = 'Absence Registration';
                RunObject = Page 5212;
            }
            action(CxCEmp)
            {
                Caption = 'Create employee loan';
                RunObject = Page 34002139;
            }
            action(Elegibles)
            {
                Caption = 'List of eligible';
                RunObject = Page 34002191;
            }
            action(ListaAccPers)
            {
                Caption = 'Personnel activities list';
                RunObject = Page 34002111;
            }
        }
        area(processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                group(PayrolAl)
                {
                    Caption = 'Payroll';
                    Image = SuggestCustomerPayments;
                    action(DiaNom)
                    {
                        Caption = 'Payroll process';
                        Image = CalculateBalanceAccount;
                        RunObject = Page 34002144;
                    }
                    action(CtrolAsist)
                    {
                        Caption = 'Time and attendance';
                        Image = Timesheet;
                        RunObject = Page 34002122;
                    }
                    action("Post Payroll")
                    {
                        Caption = 'Post Payroll';
                        Image = Post;
                        //TODO: Ver RunObject = Report 34002124;
                    }
                    action("Send Payroll slip")
                    {
                        Caption = 'Send Payroll slip';
                        Image = SendTo;
                        //TODO: Ver RunObject = Report 34002114;
                    }
                    action("Generate Bank's file")
                    {
                        Caption = 'Generate Bank''s file';
                        Image = TransferFunds;
                        //TODO: Ver RunObject = Report 34002121;
                    }
                    action("Post Payroll to G/L")
                    {
                        Caption = 'Post Payroll to G/L';
                        Image = PostInventoryToGL;
                        //TODO: Ver RunObject = Report 34002106;
                    }
                }
                group(Trainings)
                {
                    Caption = 'Trainings';
                    Image = Planning;
                    action(Entrenam)
                    {
                        Caption = 'Training schedule list';
                        Image = CalculatePlan;
                        RunObject = Page 34002207;
                    }
                    action(InscEntrenam)
                    {
                        Caption = 'Registration for training';
                        Image = Planning;
                        RunObject = Page 34002228;
                    }
                }
                group(Cooperative)
                {
                    Caption = 'Cooperative';
                    Image = Bank;
                    action(CoopMemb)
                    {
                        Caption = 'Cooperative member list';
                        Image = SubcontractingWorksheet;
                        RunObject = Page 34002216;
                    }
                    action(Loans)
                    {
                        Caption = 'Cooperative loans list';
                        Image = Loaners;
                        RunObject = Page 34002219;
                    }
                }
                group(OtrasAcciones)
                {
                    Caption = 'Other actions';
                    Image = HumanResources;
                    action(SaldosISR)
                    {
                        Caption = 'Employee''s Tax Balance';
                        Image = TaxDetail;
                        RunObject = Page 34002148;
                    }
                    action(AsignarFormula)
                    {
                        Caption = 'Assign formula to wages';
                        Image = MapSetup;
                        //TODO: Ver RunObject = Report 34002181;
                    }
                    action(PromoSal)
                    {
                        Caption = 'General raises';
                        Image = PaymentForecast;
                        RunObject = Page 34002136;
                    }
                    action(Cheques)
                    {
                        Caption = 'Payroll check''s report';
                        Image = Payment;
                        //TODO: Ver RunObject = Report 34002116;
                    }
                    action(cierraprest)
                    {
                        Caption = 'Finish loans';
                        Image = Loaner;
                        //TODO: Ver RunObject = Report 34002142;
                    }
                    action("Envio IRM")
                    {
                        Image = "Report";
                        //TODO: Ver RunObject = Report 56200;
                    }
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group(Payroll)
                {
                    Caption = 'Payroll';
                    Image = HumanResources;
                    action(ListadoNom)
                    {
                        Caption = 'Payroll report';
                        Image = Print;
                        Promoted = true;
                        PromotedCategory = "Report";
                        //TODO: Ver RunObject = Report 34002102;
                    }
                    action(ListadoNomxDepto)
                    {
                        Caption = 'Payroll by department';
                        Image = Print;
                        Promoted = true;
                        PromotedCategory = "Report";
                        //TODO: Ver RunObject = Report 34002103;
                    }
                    action(ValidaNom)
                    {
                        Caption = 'Validate payroll by wage';
                        Image = Print;
                        //TODO: Ver RunObject = Report 34002167;
                    }
                    action(exporttoexcel)
                    {
                        Caption = 'Export Payroll To Excel';
                        Image = Excel;
                        //TODO: Ver RunObject = Report 34002168;
                    }
                    action(LlenaAutodet)
                    {
                        Caption = 'Fill SS template';
                        Image = Excel;
                        //TODO: Ver RunObject = Report 34002131;
                    }
                    action(LlenaDGT)
                    {
                        Caption = 'Fill DGT3-4 template';
                        Image = Excel;
                        //TODO: Ver RunObject = Report 34002160;
                    }
                    group(Yearly)
                    {
                        Caption = 'Yearly';
                        Image = History;
                        action(Regalia)
                        {
                            Caption = 'Christmas salary report';
                            Image = "Report";
                            //TODO: Ver RunObject = Report 34002119;
                        }
                        action(ListaBonif)
                        {
                            Caption = 'Bonus report';
                            Image = "Report";
                            //TODO: Ver RunObject = Report 34002126;
                        }
                    }
                }
                group("Human Resources")
                {
                    Caption = 'Human Resources';
                    Image = HumanResources;
                    action("Employee - Labels")
                    {
                        Caption = 'Employee - Labels';
                        //TODO: Ver RunObject = Report 5200;
                        ToolTip = 'View a list of employees'' mailing labels.';
                    }
                    action("Employee - List")
                    {
                        Caption = 'Employee - List';
                        //TODO: Ver RunObject = Report 5201;
                        ToolTip = 'View a list of all employees.';
                    }
                    action("Employee - Misc. Article Info.")
                    {
                        Caption = 'Employee - Misc. Article Info.';
                        //TODO: Ver RunObject = Report 5202;
                        ToolTip = 'View a list of employees'' miscellaneous articles.';
                    }
                    action("Employee - Confidential Info.")
                    {
                        Caption = 'Employee - Confidential Info.';
                        //TODO: Ver RunObject = Report 5203;
                        ToolTip = 'View a list of employees'' confidential information.';
                    }
                    action("Employee - Staff Absences")
                    {
                        Caption = 'Employee - Staff Absences';
                        //TODO: Ver RunObject = Report 5204;
                        ToolTip = 'View a list of employee absences by date. The list includes the cause of each employee absence.';
                    }
                    action("Employee - Absences by Causes")
                    {
                        Caption = 'Employee - Absences by Causes';
                        //TODO: Ver RunObject = Report 5205;
                        ToolTip = 'View a list of all employees'' absences categorized by absence code.';
                    }
                    action("Employee - Qualifications")
                    {
                        Caption = 'Employee - Qualifications';
                        //TODO: Ver RunObject = Report 5206;
                        ToolTip = 'View a list of employees'' qualifications.';
                    }
                    action("Employee - Addresses")
                    {
                        Caption = 'Employee - Addresses';
                        //TODO: Ver RunObject = Report 5207;
                        ToolTip = 'View a list of employees'' addresses.';
                    }
                    action("Employee - Relatives")
                    {
                        Caption = 'Employee - Relatives';
                        //TODO: Ver RunObject = Report 5208;
                        ToolTip = 'View a list of employees'' relatives.';
                    }
                    action("Employee - Birthdays")
                    {
                        Caption = 'Employee - Birthdays';
                        //TODO: Ver RunObject = Report 5209;
                        ToolTip = 'View a list of employees'' birthdays.';
                    }
                    action("Employee - Phone Nos.")
                    {
                        Caption = 'Employee - Phone Nos.';
                        //TODO: Ver RunObject = Report 5210;
                        ToolTip = 'View a list of employees'' phone numbers.';
                    }
                    action("Employee - Unions")
                    {
                        Caption = 'Employee - Unions';
                        //TODO: Ver RunObject = Report 5211;
                        ToolTip = 'View a list of employees'' union memberships.';
                    }
                    action("Employee - Contracts")
                    {
                        Caption = 'Employee - Contracts';
                        //TODO: Ver RunObject = Report 5212;
                        ToolTip = 'View all employee contracts.';
                    }
                    action("Employee - Alt. Addresses")
                    {
                        Caption = 'Employee - Alt. Addresses';
                        //TODO: Ver RunObject = Report 5213;
                        ToolTip = 'View a list of employees'' alternate addresses.';
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                action(ConfRH)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Human Resources Setup';
                    RunObject = Page 5233;
                }
                action(ConfNom)
                {
                    Caption = 'Payroll Setup';
                    RunObject = Page 34002151;
                }
                action(EmpCot)
                {
                    Caption = 'Company Setup';
                    RunObject = Page 34002100;
                }
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
                    ToolTip = 'View or edit causes of absence for your vendor resources. These codes can be used to indicate various reasons for employee absences: sickness, vacation, personal days, personal emergencies, and so on.';
                }
                action("Causes of Inactivity")
                {
                    Caption = 'Causes of Inactivity';
                    RunObject = Page 5214;
                    ToolTip = 'Register causes of inactivity codes for your employees. These codes can be used for various reasons causing employee inactiveness: maternity leave, long-term illness, sabbatical, and so on.';
                }
                action("Grounds for Termination")
                {
                    Caption = 'Grounds for Termination';
                    RunObject = Page 5215;
                    ToolTip = 'View or edit grounds for termination codes for your employees. These codes can be used for various reasons for employee termination: dismissal, retirement, resignation, and so on.';
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
                    ToolTip = 'View the benefits that your employees receive and other articles that are in your employees'' possession, such as keys, computers, company cars, and memberships in company clubs.';
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
                action("Dias Feriados")
                {
                }
                action(Departamento)
                {
                    Caption = 'Department';
                    RunObject = Page 34002168;
                }
                action(Puestos)
                {
                    Caption = 'Job Positions';
                    RunObject = Page 34002109;
                }
                action(TiposSangre)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Blood types';
                    RunObject = Page 34002226;
                }
                action(AccPers)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Reason personnel action';
                    RunObject = Page 34002103;
                }
                action(Shift)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Shifts';
                    RunObject = Page 34002177;
                }
                action(Beneficios)
                {
                    Caption = 'Benefits list';
                    RunObject = Page 34002159;
                }
                action(Vacaciones)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Vacation parameters';
                    RunObject = Page 34002205;
                }
                action(Cartas)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Letter designs';
                    RunObject = Page 34002185;
                }
                action(Seguridad)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'PAR User authorization';
                    RunObject = Page 34002161;
                }
                action(NivelesMT)
                {
                    ApplicationArea = BasicHR;
                    RunObject = Page 34002118;
                }
                action(Dispacidades)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Disabilities';
                    //TODO: Ver RunObject = Page 34002171;
                }
                action(AgrupaPuestos)
                {
                    Caption = 'Grouping area';
                    RunObject = Page 34002153;
                }
            }
            group("<Action100000016>")
            {
                Caption = 'Administration Training';
                Image = HumanResources;
                action("Tipos de entrenamientos")
                {
                    Caption = 'Training types';
                    Image = setup;
                    RunObject = Page 34002227;
                }
                action("Area curricular")
                {
                    Caption = 'Knowledge area';
                    Image = setup;
                    RunObject = Page 34002230;
                }
                action("Salones de entrenamientos")
                {
                    Caption = 'Classroom';
                    Image = setup;
                    RunObject = Page 34002231;
                }
            }
            group("<Action100000008>")
            {
                Caption = 'Payroll Administration';
                Image = HumanResources;
                action("Tipos de nominas")
                {
                    Caption = 'Payroll types';
                    Image = setup;
                    RunObject = Page 34002158;
                }
                action(Deptos)
                {
                    Caption = 'Department';
                    Image = setup;
                    RunObject = Page 34002168;
                }
                action("Puestos laborares")
                {
                    Caption = 'Job Positions';
                    Image = setup;
                    RunObject = Page 34002109;
                }
                action(GposCont)
                {
                    Caption = 'Employee Posting Group';
                    RunObject = Page 34002140;
                }
                action("Conceptos salariales")
                {
                    Caption = 'Wage''s Concepts';
                    Image = setup;
                    RunObject = Page 34002110;
                }
                action(ConfListados)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Reports Configuration';
                    //TODO: Ver RunObject = Page 34002120;
                }
                action(DimContab)
                {
                    Caption = 'Posting Dimensions';
                    RunObject = Page 34002167;
                }
                action(Iinicializa)
                {
                    Caption = 'Init wage concepts';
                    //TODO: Ver RunObject = Page 34002150;
                }
                action(ControlAsistencia)
                {
                    Caption = 'Time and attendance clock setup';
                    RunObject = Page 34002197;
                }
                action("Tabla retenc. ISR")
                {
                    Caption = 'ISR Tax';
                    Image = setup;
                    RunObject = Page 34002155;
                }
                action("Tipos de Cotizacion")
                {
                    Caption = 'Tipos de Cotizacion';
                    Image = setup;
                    RunObject = Page 34002154;
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action(PostedPAyroll)
                {
                    Caption = 'Posted Payroll';
                    RunObject = Page 34002123;
                    RunPageMode = View;
                }
                action(PostedSS)
                {
                    Caption = 'Posted Employer''s Taxes ';
                    RunObject = Page 34002129;
                }
                action(PostedLoans)
                {
                    Caption = 'History of Loans';
                    RunObject = Page 34002138;
                }
                action(PostedPA)
                {
                    Caption = 'Posted personnel actions';
                    RunObject = Page 34002170;
                }
                action(PostedCooperative)
                {
                    Caption = 'Posted Cooperative Loans List';
                    RunObject = Page 34002222;
                }
            }
        }
    }
}

