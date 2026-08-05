table 55780 Bancos
{
    LookupPageID = 55793;

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
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
            DataClassification = CustomerContent;
            Caption = 'Nombre banco';
        }
        field(3; "ID Banco"; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Banco';
            Numeric = true;
        }
        field(4; "Cuenta Banco"; Code[22])
        {
            DataClassification = CustomerContent;
            Caption = 'Cuenta Banco';
        }
        field(5; Formato; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Formato';
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

