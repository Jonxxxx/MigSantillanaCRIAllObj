table 34002136 "Sub-Departamentos"
{
    Caption = 'Sections';
    DataPerCompany = false;
    DrillDownPageID = 34002169;
    LookupPageID = 34002169;

    fields
    {
        field(1; "Cod. Departamento"; Code[20])
        {
            TableRelation = Departamentos;
        }
        field(2; Codigo; Code[20])
        {
        }
        field(3; Descripcion; Text[60])
        {
        }
        field(4; "Total Empleados"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Departamento = FIELD("Cod. Departamento"),
                                                "Sub-Departamento" = FIELD("Codigo")));
            Caption = 'Total Employee';
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

