table 34002502 "Usuarios TPV"
{
    Caption = 'POS Users';
    LookupPageID = 34002507;

    fields
    {
        field(1; ID; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            NotBlank = true;
        }
        field(2; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Grupo Cajero"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo Cajero';
            TableRelation = "Configuracion TPV";
        }
        field(4; "Contraseña"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Contraseña';
        }
        field(5; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            TableRelation = "Bancos tienda";
        }
        field(6; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionCaption = 'Cashier, Supervisor';
            OptionMembers = Cajero,Supervisor;
        }
    }

    keys
    {
        key(Key1; ID, Tipo)
        {
        }
    }

    fieldgroups
    {
    }
}

