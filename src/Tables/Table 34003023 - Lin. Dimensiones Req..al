table 55975 "Lin. Dimensiones Req."
{
    Caption = 'Required fields Line';

    fields
    {
        field(1; "No. Tabla"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Tabla';
        }
        field(2; Nombre; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(3; "Cod. Dimension"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimension';
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(5; "Registro valor"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Registro valor';
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
    }

    keys
    {
        key(Key1; "No. Tabla", "Cod. Dimension")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Fields": Record 2000000041;
        FieldForm: Page 55974;
}

