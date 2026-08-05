table 55322 "Log errores revision contratos"
{
    Caption = 'Log errores revision contratos';

    fields
    {
        field(1; "No. empleado"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
        }
        field(10; "Errores fecha inicio"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Errores fecha inicio';
            Description = 'Contrato sin fecha de inicio establecida';
        }
        field(11; "Errores continuidad"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Errores continuidad';
            Description = 'Error en la continuidad de los periodos de contrato';
        }
        field(12; "Errores por fecha final"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Errores por fecha final';
            Description = 'Si la fecha final sin valor (abierta) no es el  ltimo contrato entrado';
        }
        field(20; "Creado por proceso"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Creado por proceso';
        }
        field(21; Estado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            OptionMembers = ,Errores,Ok;
        }
        field(30; Contratos; Integer)
        {
            Caption = 'Contratos';
            CalcFormula = Count(Contratos WHERE("No. empleado" = FIELD("No. empleado")));
            FieldClass = FlowField;
            TableRelation = Contratos;
        }
        field(100; Observaciones; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Observaciones';
        }
    }

    keys
    {
        key(Key1; "No. empleado")
        {
        }
    }

    fieldgroups
    {
    }
}

