table 34002120 "Nivel Cargo"
{
    Caption = 'Job type levels';
    DataPerCompany = false;
    DrillDownPageID = 34002166;
    LookupPageID = 34002166;

    fields
    {
        field(2; "Cod. Nivel"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Descripcion; Text[30])
        {
        }
        field(4; "Importe minimo"; Decimal)
        {
            Caption = 'Minimum amount';
        }
        field(5; "Importe máximo"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Importe Medio"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Cod. Nivel")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Nivel", Descripcion, "Importe minimo", "Importe Medio", "Importe máximo")
        {
        }
    }
}

