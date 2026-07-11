table 56102 "Log errores revision contratos"
{
    Caption = 'Log errores revision contratos';

    fields
    {
        field(1; "No. empleado"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Errores fecha inicio"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Contrato sin fecha de inicio establecida';
        }
        field(11; "Errores continuidad"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Error en la continuidad de los periodos de contrato';
        }
        field(12; "Errores por fecha final"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Si la fecha final sin valor (abierta) no es el  ltimo contrato entrado';
        }
        field(20; "Creado por proceso"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Estado; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Errores,Ok;
        }
        field(30; Contratos; Integer)
        {
            CalcFormula = Count(Contratos WHERE("No. empleado" = FIELD("No. empleado")));
            FieldClass = FlowField;
            TableRelation = Contratos;
        }
        field(100; Observaciones; Text[100])
        {
            DataClassification = ToBeClassified;
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

