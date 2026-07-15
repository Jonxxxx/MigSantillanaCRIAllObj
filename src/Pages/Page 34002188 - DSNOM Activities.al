page 34002188 "DSNOM Activities"
{
    PageType = CardPart;
    SourceTable = 34002169;

    layout
    {
        area(content)
        {
            cuegroup("Human Resource")
            {
                Caption = 'Human Resource';
                field("Active Employees"; "Active Employees")
                {
                }
                field("Inactives Employees"; "Inactives Employees")
                {
                }
                field("New hires"; "New hires")
                {
                }
                field("Employee departures"; "Employee departures")
                {
                }
                field("Contract to expire"; "Contract to expire")
                {
                }
            }
            cuegroup(Employees)
            {
                Caption = 'Employees';
                field(Cumple; "Birthday of the month")
                {
                    Caption = 'Current month birthdays';
                }
                field("Male Employees"; "Male Employees")
                {
                }
                field("Female Employees"; "Female Employees")
                {
                }
            }
            cuegroup(Vacation)
            {
                Caption = 'Vacation';
                //TODO: Ver 
                /*
                field(FuncionesNomVacacionesporVencer;
                FuncionesNom.VacacionesporVencer)
                {
                    Caption = 'vacation to expire';
                    //TODO: Ver DecimalPlaces = 0 : 2;
                    Image = Calendar;

                    trigger OnDrillDown()
                    begin
                        FuncionesNom.MuestraVacporVencer;
                    end;
                }*/
                field("Vacation to start"; "Vacation to start")
                {
                    Image = Calendar;
                }
                field("Vacation to finish"; "Vacation to finish")
                {
                    Image = Calendar;
                }
            }
            cuegroup(Payroll)
            {
                Caption = 'Payroll';
                field("Employees with wire transfer"; "Employees with wire transfer")
                {
                }
                field("Employees with check"; "Employees with check")
                {
                }
                field(Loans; Loans)
                {
                }
            }
            cuegroup(Cooperative)
            {
                Caption = 'Cooperative';
                field("Afiliados cooperativa"; "Afiliados cooperativa")
                {
                }
                field("Miembros activos"; "Miembros activos")
                {
                }
                field("Miembros inactivos"; "Miembros inactivos")
                {
                }
                field("Prestamos activos"; "Prestamos activos")
                {
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
        //TODO: Ver //TODO: Ver FuncionesNom: Codeunit 34002104;
        Fecha: Record 2000000007;
}

