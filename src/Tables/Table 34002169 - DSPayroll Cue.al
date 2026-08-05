table 55810 "DSPayroll Cue"
{
    Caption = 'NOMDS Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; Loans; Integer)
        {
            Caption = 'Loans';
            CalcFormula = Count("Historico Cab. Prestamo" WHERE(Pendiente = CONST(True)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Active Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Status = CONST(Active)));
            Caption = 'Active Employees';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Active Contracts"; Integer)
        {
            Caption = 'Active Contracts';
            CalcFormula = Count(Contratos WHERE(Activo = CONST(True)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Inactives Employees"; Integer)
        {
            Caption = 'Inactives Employees';
            CalcFormula = Count(Employee WHERE(Status = FILTER(Inactive | Terminated)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Employees with wire transfer"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Forma de Cobro" = CONST("Transferencia Banc."),
                                                "Calcular Nomina" = CONST(True)));
            Caption = 'Employees with wire transfer';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Employees with check"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Forma de Cobro" = CONST(Cheque)));
            Caption = 'Employees with check';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Female Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Gender = CONST(Female),
                                                Status = CONST(Active)));
            Caption = 'Female Employees';
            FieldClass = FlowField;
        }
        field(9; "Male Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Gender = CONST(Male),
                                                Status = CONST(Active)));
            Caption = 'Male Employees';
            FieldClass = FlowField;
        }
        field(10; "New hires"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Employment Date" = FIELD("Date Filter"),
                                                Status = CONST(Active)));
            Caption = 'New hires';
            FieldClass = FlowField;
        }
        field(11; "Employee departures"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Termination Date" = FIELD("Date Filter"),
                                                Status = CONST(Inactive)));
            Caption = 'Employee departures';
            FieldClass = FlowField;
        }
        field(12; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;

            trigger OnValidate()
            begin
                SETRANGE("Birth Month filter", DATE2DMY(GETRANGEMAX("Date Filter"), 2));
            end;
        }
        field(13; "Birthday of the month"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Mes Nacimiento" = FIELD("Birth Month filter"),
                                               Status = CONST(Active)));
            Caption = 'Birthday of the month';
            FieldClass = FlowField;

            trigger OnLookup()
            var
                Emp: Record 5200;
            begin
            end;
        }
        field(14; "Birth Month filter"; Integer)
        {
            Caption = 'Birth Month filter';
            FieldClass = FlowFilter;
        }
        field(15; "Vacation to expire"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Vacation to expire';
        }
        field(16; "Contract to expire"; Integer)
        {
            CalcFormula = Count(Contratos WHERE("Fecha finalizacion" = FIELD(FILTER("Date Filter")),
                                                 Activo = CONST(True)));
            Caption = 'Contract to expire';
            FieldClass = FlowField;
        }
        field(17; "Vacation to start"; Integer)
        {
            Caption = 'Vacation to start';
            CalcFormula = Count("Planificacion de vacaciones" WHERE("Fecha inicio planificada" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(18; "Vacation to finish"; Integer)
        {
            Caption = 'Vacation to finish';
            CalcFormula = Count("Planificacion de vacaciones" WHERE("Fecha fin planificada" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(19; "Afiliados cooperativa"; Integer)
        {
            Caption = 'Afiliados cooperativa';
            CalcFormula = Count("Miembros cooperativa");
            FieldClass = FlowField;
        }
        field(20; "Miembros activos"; Integer)
        {
            Caption = 'Miembros activos';
            CalcFormula = Count("Miembros cooperativa" WHERE(Status = CONST(Activo)));
            FieldClass = FlowField;
        }
        field(21; "Miembros inactivos"; Integer)
        {
            Caption = 'Miembros inactivos';
            CalcFormula = Count("Miembros cooperativa" WHERE(Status = CONST(" ")));
            FieldClass = FlowField;
        }
        field(22; "Prestamos activos"; Integer)
        {
            Caption = 'Prestamos activos';
            CalcFormula = Count("Hist. Cab. Prest. cooperativa" WHERE(Status = FILTER(<> Completado)));
            FieldClass = FlowField;
        }
        field(23; "Entrenamientos activos"; Integer)
        {
            Caption = 'Entrenamientos activos';
            CalcFormula = Count("Cab. Entrenamiento" WHERE(Estado = CONST(Planificado)));
            FieldClass = FlowField;
        }
        field(24; "Entrenamientos del mes"; Integer)
        {
            Caption = 'Entrenamientos del mes';
            CalcFormula = Count("Cab. Entrenamiento" WHERE(Estado = CONST(Planificado),
                                                            "Fecha Inicio" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

