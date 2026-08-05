table 55261 "Puestos de Pcking"
{
    Caption = 'Packing Position';
    LookupPageID = 55267;

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "Control Peso"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Control Peso';
        }
        field(3; "Usuario Asignado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario Asignado';
            TableRelation = User;
        }
        field(4; Descripcion; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
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
}

