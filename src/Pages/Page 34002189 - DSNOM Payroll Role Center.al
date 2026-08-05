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
                //chartpart("DSNOM1001"; "DSNOM-1001")
                //{
                //}
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
                ApplicationArea = All;
                Caption = 'Employees';
                ToolTip = 'Employees';
                Image = Item;
                RunObject = Page 5201;
            }
            action(regAu)
            {
                ApplicationArea = All;
                Caption = 'Absence Registration';
                ToolTip = 'Absence Registration';
                RunObject = Page 5212;
            }
            action(CxCEmp)
            {
                ApplicationArea = All;
                Caption = 'Create employee loan';
                ToolTip = 'Create employee loan';
                RunObject = Page 55780;
            }
            action(Elegibles)
            {
                ApplicationArea = All;
                Caption = 'List of eligible';
                ToolTip = 'List of eligible';
                RunObject = Page 34002191;
            }
            action(ListaAccPers)
            {
                ApplicationArea = All;
                Caption = 'Personnel activities list';
                ToolTip = 'Personnel activities list';
                RunObject = Page 55752;
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
                        ApplicationArea = All;
                        Caption = 'Payroll process';
                        ToolTip = 'Payroll process';
                        Image = CalculateBalanceAccount;
                        RunObject = Page 55785;
                    }
                    action(CtrolAsist)
                    {
                        ApplicationArea = All;
                        Caption = 'Time and attendance';
                        ToolTip = 'Time and attendance';
                        Image = Timesheet;
                        RunObject = Page 55763;
                    }
                    action("Post Payroll")
                    {
                        ApplicationArea = All;
                        Caption = 'Post Payroll';
                        ToolTip = 'Post Payroll';
                        Image = Post;
                        // TODO: Manual review - Custom report 55765 is unavailable as the required object type.
                        // Original code: RunObject = Report 55765;
                    }
                    action("Send Payroll slip")
                    {
                        ApplicationArea = All;
                        Caption = 'Send Payroll slip';
                        ToolTip = 'Send Payroll slip';
                        Image = SendTo;
                        // TODO: Manual review - Custom report 55755 is unavailable as the required object type.
                        // Original code: RunObject = Report 55755;
                    }
                    action("Generate Bank's file")
                    {
                        ApplicationArea = All;
                        Caption = 'Generate Bank''s file';
                        ToolTip = 'Generate Bank''s file';
                        Image = TransferFunds;
                        // TODO: Manual review - Custom report 55762 is unavailable as the required object type.
                        // Original code: RunObject = Report 55762;
                    }
                    action("Post Payroll to G/L")
                    {
                        ApplicationArea = All;
                        Caption = 'Post Payroll to G/L';
                        ToolTip = 'Post Payroll to G/L';
                        Image = PostInventoryToGL;
                        // TODO: Manual review - Custom report 55747 is unavailable as the required object type.
                        // Original code: RunObject = Report 55747;
                    }
                }
                group(Trainings)
                {
                    Caption = 'Trainings';
                    Image = Planning;
                    action(Entrenam)
                    {
                        ApplicationArea = All;
                        Caption = 'Training schedule list';
                        ToolTip = 'Training schedule list';
                        Image = CalculatePlan;
                        RunObject = Page 34002207;
                    }
                    action(InscEntrenam)
                    {
                        ApplicationArea = All;
                        Caption = 'Registration for training';
                        ToolTip = 'Registration for training';
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
                        ApplicationArea = All;
                        Caption = 'Cooperative member list';
                        ToolTip = 'Cooperative member list';
                        Image = SubcontractingWorksheet;
                        RunObject = Page 34002216;
                    }
                    action(Loans)
                    {
                        ApplicationArea = All;
                        Caption = 'Cooperative loans list';
                        ToolTip = 'Cooperative loans list';
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
                        ApplicationArea = All;
                        Caption = 'Employee''s Tax Balance';
                        ToolTip = 'Employee''s Tax Balance';
                        Image = TaxDetail;
                        RunObject = Page 55789;
                    }
                    action(AsignarFormula)
                    {
                        ApplicationArea = All;
                        Caption = 'Assign formula to wages';
                        ToolTip = 'Assign formula to wages';
                        Image = MapSetup;
                        // TODO: Manual review - Custom report 34002181 is unavailable as the required object type.
                        // Original code: RunObject = Report 34002181;
                    }
                    action(PromoSal)
                    {
                        ApplicationArea = All;
                        Caption = 'General raises';
                        ToolTip = 'General raises';
                        Image = PaymentForecast;
                        RunObject = Page 55777;
                    }
                    action(Cheques)
                    {
                        ApplicationArea = All;
                        Caption = 'Payroll check''s report';
                        ToolTip = 'Payroll check''s report';
                        Image = Payment;
                        // TODO: Manual review - Custom report 55757 is unavailable as the required object type.
                        // Original code: RunObject = Report 55757;
                    }
                    action(cierraprest)
                    {
                        ApplicationArea = All;
                        Caption = 'Finish loans';
                        ToolTip = 'Finish loans';
                        Image = Loaner;
                        // TODO: Manual review - Custom report 55783 is unavailable as the required object type.
                        // Original code: RunObject = Report 55783;
                    }
                    action("Envio IRM")
                    {
                        ApplicationArea = All;
                        Caption = 'Envio IRM';
                        ToolTip = 'Envio IRM';
                        Image = "Report";
                        RunObject = Report 55353;
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
                        ApplicationArea = All;
                        Caption = 'Payroll report';
                        ToolTip = 'Payroll report';
                        Image = Print;
                        Promoted = true;
                        PromotedCategory = "Report";
                        // TODO: Manual review - Custom report 55743 is unavailable as the required object type.
                        // Original code: RunObject = Report 55743;
                    }
                    action(ListadoNomxDepto)
                    {
                        ApplicationArea = All;
                        Caption = 'Payroll by department';
                        ToolTip = 'Payroll by department';
                        Image = Print;
                        Promoted = true;
                        PromotedCategory = "Report";
                        // TODO: Manual review - Custom report 55744 is unavailable as the required object type.
                        // Original code: RunObject = Report 55744;
                    }
                    action(ValidaNom)
                    {
                        ApplicationArea = All;
                        Caption = 'Validate payroll by wage';
                        ToolTip = 'Validate payroll by wage';
                        Image = Print;
                        // TODO: Manual review - Custom report 34002167 is unavailable as the required object type.
                        // Original code: RunObject = Report 34002167;
                    }
                    action(exporttoexcel)
                    {
                        ApplicationArea = All;
                        Caption = 'Export Payroll To Excel';
                        ToolTip = 'Export Payroll To Excel';
                        Image = Excel;
                        // TODO: Manual review - Custom report 34002168 is unavailable as the required object type.
                        // Original code: RunObject = Report 34002168;
                    }
                    action(LlenaAutodet)
                    {
                        ApplicationArea = All;
                        Caption = 'Fill SS template';
                        ToolTip = 'Fill SS template';
                        Image = Excel;
                        // TODO: Manual review - Custom report 55772 is unavailable as the required object type.
                        // Original code: RunObject = Report 55772;
                    }
                    action(LlenaDGT)
                    {
                        ApplicationArea = All;
                        Caption = 'Fill DGT3-4 template';
                        ToolTip = 'Fill DGT3-4 template';
                        Image = Excel;
                        // TODO: Manual review - Custom report 34002160 is unavailable as the required object type.
                        // Original code: RunObject = Report 34002160;
                    }
                    group(Yearly)
                    {
                        Caption = 'Yearly';
                        Image = History;
                        action(Regalia)
                        {
                            ApplicationArea = All;
                            Caption = 'Christmas salary report';
                            ToolTip = 'Christmas salary report';
                            Image = "Report";
                            // TODO: Manual review - Custom report 55760 is unavailable as the required object type.
                            // Original code: RunObject = Report 55760;
                        }
                        action(ListaBonif)
                        {
                            ApplicationArea = All;
                            Caption = 'Bonus report';
                            ToolTip = 'Bonus report';
                            Image = "Report";
                            // TODO: Manual review - Custom report 55767 is unavailable as the required object type.
                            // Original code: RunObject = Report 55767;
                        }
                    }
                }
                group("Human Resources")
                {
                    Caption = 'Human Resources';
                    Image = HumanResources;
                    action("Employee - Labels")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Labels';
                        ToolTip = 'Employee - Labels';
                        RunObject = Report 5200;
                    }
                    action("Employee - List")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - List';
                        ToolTip = 'Employee - List';
                        RunObject = Report 5201;
                    }
                    action("Employee - Misc. Article Info.")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Misc. Article Info.';
                        ToolTip = 'Employee - Misc. Article Info.';
                        RunObject = Report 5202;
                    }
                    action("Employee - Confidential Info.")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Confidential Info.';
                        ToolTip = 'Employee - Confidential Info.';
                        RunObject = Report 5203;
                    }
                    action("Employee - Staff Absences")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Staff Absences';
                        ToolTip = 'Employee - Staff Absences';
                        RunObject = Report 5204;
                    }
                    action("Employee - Absences by Causes")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Absences by Causes';
                        ToolTip = 'Employee - Absences by Causes';
                        RunObject = Report 5205;
                    }
                    action("Employee - Qualifications")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Qualifications';
                        ToolTip = 'Employee - Qualifications';
                        RunObject = Report 5206;
                    }
                    action("Employee - Addresses")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Addresses';
                        ToolTip = 'Employee - Addresses';
                        RunObject = Report 5207;
                    }
                    action("Employee - Relatives")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Relatives';
                        ToolTip = 'Employee - Relatives';
                        RunObject = Report 5208;
                    }
                    action("Employee - Birthdays")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Birthdays';
                        ToolTip = 'Employee - Birthdays';
                        RunObject = Report 5209;
                    }
                    action("Employee - Phone Nos.")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Phone Nos.';
                        ToolTip = 'Employee - Phone Nos.';
                        RunObject = Report 5210;
                    }
                    action("Employee - Unions")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Unions';
                        ToolTip = 'Employee - Unions';
                        RunObject = Report 5211;
                    }
                    action("Employee - Contracts")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Contracts';
                        ToolTip = 'Employee - Contracts';
                        RunObject = Report 5212;
                    }
                    action("Employee - Alt. Addresses")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee - Alt. Addresses';
                        ToolTip = 'Employee - Alt. Addresses';
                        RunObject = Report 5213;
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                action(ConfRH)
                {
                    ApplicationArea = All;
                    Caption = 'Human Resources Setup';
                    ToolTip = 'Human Resources Setup';
                    RunObject = Page 5233;
                }
                action(ConfNom)
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Setup';
                    ToolTip = 'Payroll Setup';
                    RunObject = Page 55792;
                }
                action(EmpCot)
                {
                    ApplicationArea = All;
                    Caption = 'Company Setup';
                    ToolTip = 'Company Setup';
                    RunObject = Page 55741;
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
                action("Dias Feriados")
                {
                    ApplicationArea = All;
                    Caption = 'Dias Feriados';
                    ToolTip = 'Dias Feriados';
                }
                action(Departamento)
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    ToolTip = 'Department';
                    RunObject = Page 34002168;
                }
                action(Puestos)
                {
                    ApplicationArea = All;
                    Caption = 'Job Positions';
                    ToolTip = 'Job Positions';
                    RunObject = Page 55750;
                }
                action(TiposSangre)
                {
                    ApplicationArea = All;
                    Caption = 'Blood types';
                    ToolTip = 'Blood types';
                    RunObject = Page 34002226;
                }
                action(AccPers)
                {
                    ApplicationArea = All;
                    Caption = 'Reason personnel action';
                    ToolTip = 'Reason personnel action';
                    RunObject = Page 55744;
                }
                action(Shift)
                {
                    ApplicationArea = All;
                    Caption = 'Shifts';
                    ToolTip = 'Shifts';
                    RunObject = Page 34002177;
                }
                action(Beneficios)
                {
                    ApplicationArea = All;
                    Caption = 'Benefits list';
                    ToolTip = 'Benefits list';
                    RunObject = Page 55800;
                }
                action(Vacaciones)
                {
                    ApplicationArea = All;
                    Caption = 'Vacation parameters';
                    ToolTip = 'Vacation parameters';
                    RunObject = Page 34002205;
                }
                action(Cartas)
                {
                    ApplicationArea = All;
                    Caption = 'Letter designs';
                    ToolTip = 'Letter designs';
                    RunObject = Page 34002185;
                }
                action(Seguridad)
                {
                    ApplicationArea = All;
                    Caption = 'PAR User authorization';
                    ToolTip = 'PAR User authorization';
                    RunObject = Page 34002161;
                }
                action(NivelesMT)
                {
                    ApplicationArea = All;
                    Caption = 'NivelesMT';
                    ToolTip = 'NivelesMT';
                    RunObject = Page 55759;
                }
                action(Dispacidades)
                {
                    ApplicationArea = All;
                    Caption = 'Disabilities';
                    ToolTip = 'Disabilities';
                    // TODO: Manual review - Custom page 34002171 is unavailable as the required object type.
                    // Original code: RunObject = Page 34002171;
                }
                action(AgrupaPuestos)
                {
                    ApplicationArea = All;
                    Caption = 'Grouping area';
                    ToolTip = 'Grouping area';
                    RunObject = Page 55794;
                }
            }
            group("<Action100000016>")
            {
                Caption = 'Administration Training';
                Image = HumanResources;
                action("Tipos de entrenamientos")
                {
                    ApplicationArea = All;
                    Caption = 'Training types';
                    ToolTip = 'Training types';
                    Image = setup;
                    RunObject = Page 34002227;
                }
                action("Area curricular")
                {
                    ApplicationArea = All;
                    Caption = 'Knowledge area';
                    ToolTip = 'Knowledge area';
                    Image = setup;
                    RunObject = Page 34002230;
                }
                action("Salones de entrenamientos")
                {
                    ApplicationArea = All;
                    Caption = 'Classroom';
                    ToolTip = 'Classroom';
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
                    ApplicationArea = All;
                    Caption = 'Payroll types';
                    ToolTip = 'Payroll types';
                    Image = setup;
                    RunObject = Page 55799;
                }
                action(Deptos)
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    ToolTip = 'Department';
                    Image = setup;
                    RunObject = Page 34002168;
                }
                action("Puestos laborares")
                {
                    ApplicationArea = All;
                    Caption = 'Job Positions';
                    ToolTip = 'Job Positions';
                    Image = setup;
                    RunObject = Page 55750;
                }
                action(GposCont)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Posting Group';
                    ToolTip = 'Employee Posting Group';
                    RunObject = Page 55781;
                }
                action("Conceptos salariales")
                {
                    ApplicationArea = All;
                    Caption = 'Wage''s Concepts';
                    ToolTip = 'Wage''s Concepts';
                    Image = setup;
                    RunObject = Page 55751;
                }
                action(ConfListados)
                {
                    ApplicationArea = All;
                    Caption = 'Reports Configuration';
                    ToolTip = 'Reports Configuration';
                    // TODO: Manual review - Custom page 55761 is unavailable as the required object type.
                    // Original code: RunObject = Page 55761;
                }
                action(DimContab)
                {
                    ApplicationArea = All;
                    Caption = 'Posting Dimensions';
                    ToolTip = 'Posting Dimensions';
                    RunObject = Page 34002167;
                }
                action(Iinicializa)
                {
                    ApplicationArea = All;
                    Caption = 'Init wage concepts';
                    ToolTip = 'Init wage concepts';
                    // TODO: Manual review - Custom page 55791 is unavailable as the required object type.
                    // Original code: RunObject = Page 55791;
                }
                action(ControlAsistencia)
                {
                    ApplicationArea = All;
                    Caption = 'Time and attendance clock setup';
                    ToolTip = 'Time and attendance clock setup';
                    RunObject = Page 34002197;
                }
                action("Tabla retenc. ISR")
                {
                    ApplicationArea = All;
                    Caption = 'ISR Tax';
                    ToolTip = 'ISR Tax';
                    Image = setup;
                    RunObject = Page 55796;
                }
                action("Tipos de Cotizacion")
                {
                    ApplicationArea = All;
                    Caption = 'Tipos de Cotizacion';
                    ToolTip = 'Tipos de Cotizacion';
                    Image = setup;
                    RunObject = Page 55795;
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action(PostedPAyroll)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Payroll';
                    ToolTip = 'Posted Payroll';
                    RunObject = Page 55764;
                    RunPageMode = View;
                }
                action(PostedSS)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Employer''s Taxes ';
                    ToolTip = 'Posted Employer''s Taxes ';
                    RunObject = Page 55770;
                }
                action(PostedLoans)
                {
                    ApplicationArea = All;
                    Caption = 'History of Loans';
                    ToolTip = 'History of Loans';
                    RunObject = Page 55779;
                }
                action(PostedPA)
                {
                    ApplicationArea = All;
                    Caption = 'Posted personnel actions';
                    ToolTip = 'Posted personnel actions';
                    RunObject = Page 34002170;
                }
                action(PostedCooperative)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Cooperative Loans List';
                    ToolTip = 'Posted Cooperative Loans List';
                    RunObject = Page 34002222;
                }
            }
        }
    }
}

