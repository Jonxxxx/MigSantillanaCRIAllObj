page 34002235 "DSNOM Activities - RH"
{
    Caption = 'Payroll Activities';
    PageType = CardPart;
    SourceTable = 34002169;

    layout
    {
        area(content)
        {
            cuegroup("Human Resource")
            {
                Caption = 'Human Resource';
                field("Active Employees"; Rec."Active Employees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Active Employees';
                }
                field("Inactives Employees"; Rec."Inactives Employees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Inactives Employees';
                }
                field(FuncionesNomAniversarioEmpleados;
                FuncionesNom.AniversarioEmpleados)
                {
                    ApplicationArea = All;
                    Caption = 'Empl. anniversary';
                    DecimalPlaces = 0 : 2;
                    Image = Time;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        FuncionesNom.MuestraAniversarioEmpl;
                    end;
                }
                field("New hires"; Rec."New hires")
                {
                    ApplicationArea = All;
                    ToolTip = 'New hires';
                }
                field("Employee departures"; Rec."Employee departures")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee departures';
                }
                field("Contract to expire"; Rec."Contract to expire")
                {
                    ApplicationArea = All;
                    ToolTip = 'Contract to expire';
                }
            }
            cuegroup(Employees)
            {
                Caption = 'Employees';
                field(Cumple; Rec."Birthday of the month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Birthday of the month';
                    Caption = 'Current month birthdays';
                }
                field("Male Employees"; Rec."Male Employees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Male Employees';
                }
                field("Female Employees"; Rec."Female Employees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Female Employees';
                }
            }
            cuegroup(Vacation)
            {
                Caption = 'Vacation';
                field(FuncionesNomVacacionesporVencer;
                FuncionesNom.VacacionesporVencer)
                {
                    ApplicationArea = All;
                    Caption = 'vacation to expire';
                    DecimalPlaces = 0 : 2;
                    Image = Calendar;

                    trigger OnDrillDown()
                    begin
                        FuncionesNom.MuestraVacporVencer;
                    end;
                }
                field("Vacation to start"; Rec."Vacation to start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vacation to start';
                    Image = Calendar;
                }
                field("Vacation to finish"; Rec."Vacation to finish")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vacation to finish';
                    Image = Calendar;
                }
            }
            cuegroup(Payroll)
            {
                Caption = 'Payroll';
                field("Employees with wire transfer"; Rec."Employees with wire transfer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employees with wire transfer';
                }
                field("Employees with check"; Rec."Employees with check")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employees with check';
                }
                field(Loans; Rec.Loans)
                {
                    ApplicationArea = All;
                    ToolTip = 'Loans';
                }
            }
            cuegroup(Cooperative)
            {
                Caption = 'Cooperative';
                field("Afiliados cooperativa"; Rec."Afiliados cooperativa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Afiliados cooperativa';
                }
                field("Miembros activos"; Rec."Miembros activos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Miembros activos';
                }
                field("Miembros inactivos"; Rec."Miembros inactivos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Miembros inactivos';
                }
                field("Prestamos activos"; Rec."Prestamos activos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Prestamos activos';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;

        Fecha.RESET;
        Fecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3)));
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.FINDFIRST;
        SETRANGE("Date Filter", Fecha."Period Start", Fecha."Period End");

        SETRANGE("Birth Month filter", DATE2DMY(WORKDATE, 2));
    end;

    var
        FuncionesNom: Codeunit 34002104;
        Fecha: Record 2000000007;
}

