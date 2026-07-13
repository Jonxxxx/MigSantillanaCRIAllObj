table 34002510 "Clinetes TPV"
{
    Caption = 'Customers POS';
    //TODO: Ver LookupPageID = 34002515;

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; Nombre; Text[250])
        {
            Caption = 'Name';
        }
        field(3; Telefono; Text[30])
        {
            Caption = 'Phone';
        }
        field(4; Direccion; Text[250])
        {
            Caption = 'Address';
        }
        field(5; ID; Integer)
        {
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

