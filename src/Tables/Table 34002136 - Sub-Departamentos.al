table 55777 "Sub-Departamentos"
{
    Caption = 'Sections';
    DataPerCompany = false;
    DrillDownPageID = 55810;
    LookupPageID = 55810;

    fields
    {
        field(1; "Cod. Departamento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Departamento';
            TableRelation = Departamentos;
        }
        field(2; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3; Descripcion; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "Total Empleados"; Integer)
        {
            Caption = 'Total Empleados';
            CalcFormula = Count(Employee WHERE(Departamento = FIELD("Cod. Departamento"),
                                                "Sub-Departamento" = FIELD("Codigo")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cod. Departamento", Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }
}

