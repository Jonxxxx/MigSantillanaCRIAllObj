table 34002139 Bancos
{
    LookupPageID = 34002152;

    fields
    {
        field(1; Codigo; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                IF Bco.GET(Codigo) THEN BEGIN
                    "Nombre banco" := Bco.Name;
                    "Cuenta Banco" := Bco."Bank Account No.";
                END;
            end;
        }
        field(2; "Nombre banco"; Text[60])
        {
        }
        field(3; "ID Banco"; Code[4])
        {
            Numeric = true;
        }
        field(4; "Cuenta Banco"; Code[22])
        {
        }
        field(5; Formato; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Bco: Record 270;
}

