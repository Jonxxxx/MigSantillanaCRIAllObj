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
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
        }
        field(3; Descripcion; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "Importe minimo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe minimo';
        }
        field(5; "Importe Maximo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Maximo';
        }
        field(6; "Importe Medio"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Medio';
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
        fieldgroup(DropDown; "Cod. Nivel", Descripcion, "Importe minimo", "Importe Medio", "Importe Maximo")
        {
        }
    }
}

