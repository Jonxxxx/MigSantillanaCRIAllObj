table 34003023 "Lin. Dimensiones Req."
{
    Caption = 'Required fields Line';

    fields
    {
        field(1;"No. Tabla";Integer)
        {
            Caption = 'Table No.';
        }
        field(2;Nombre;Text[100])
        {
        }
        field(3;"Cod. Dimension";Code[20])
        {
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(5;"Registro valor";Option)
        {
            Caption = 'Value Posting';
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
    }

    keys
    {
        key(Key1;"No. Tabla","Cod. Dimension")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Fields": Record "2000000041";
        FieldForm: Page "34003022";
}

