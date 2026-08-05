table 55904 "Clinetes TPV"
{
    Caption = 'Customers POS';
    LookupPageID = 55909;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; Nombre; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(3; Telefono; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Telefono';
        }
        field(4; Direccion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion';
        }
        field(5; ID; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

