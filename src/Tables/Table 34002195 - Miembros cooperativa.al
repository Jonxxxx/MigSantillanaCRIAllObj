table 34002195 "Miembros cooperativa"
{
    DrillDownPageID = 34002216;
    LookupPageID = 34002216;

    fields
    {
        field(1; "Tipo de miembro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de miembro';
            OptionCaption = 'Member, Partner';
            OptionMembers = Miembro,Socio;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Emp.GET("Employee No.") THEN
                    "Full name" := Emp."Full Name";
            end;
        }
        field(10; "1ra Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1ra Quincena';
        }
        field(11; "2da Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '2da Quincena';
        }
        field(12; "Fecha inactivacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inactivacion';
        }
        field(23; "Full name"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Full name';
        }
        field(24; "Fecha inscripcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inscripcion';
        }
        field(25; "Tipo de aporte"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de aporte';
            OptionCaption = 'Fix,Percentage';
            OptionMembers = Fijo,Porcentual;
        }
        field(26; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
        field(27; "Ahorro acumulado"; Decimal)
        {
            Caption = 'Ahorro acumulado';
            CalcFormula = Sum("Mov. cooperativa".Importe WHERE("Employee No." = FIELD("Employee No."),
                                                                "Tipo transaccion" = CONST(Aporte)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Prestamos pendientes"; Integer)
        {
            Caption = 'Prestamos pendientes';
            CalcFormula = Count("Mov. cooperativa" WHERE("Employee No." = FIELD("Employee No."),
                                                          "Tipo transaccion" = CONST(Prestamo)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Importe pendiente"; Decimal)
        {
            Caption = 'Importe pendiente';
            CalcFormula = Sum("Mov. cooperativa".Importe WHERE("Employee No." = FIELD("Employee No."),
                                                                "Tipo transaccion" = CONST(Prestamo)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = ' ,Active,Inactive,Retired,Reinstated';
            OptionMembers = " ",Activo,Inactivo,Retirado;
        }
        field(31; "Fecha reingreso"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha reingreso';
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
        key(Key2; "Full name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Employee No.", "Full name", "Tipo de miembro")
        {
        }
        fieldgroup(Brick; "Employee No.", "Full name", "Tipo de miembro")
        {
        }
    }

    var
        Emp: Record 5200;
}

