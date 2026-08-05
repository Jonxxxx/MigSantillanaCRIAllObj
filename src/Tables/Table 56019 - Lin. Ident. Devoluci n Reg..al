table 55244 "Lin. Ident. Devoluci n Reg."
{

    fields
    {
        field(1; "No. Ident. Devolucion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Ident. Devolucion';
        }
        field(2; "No. Bulto"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Bulto';
        }
        field(3; Comentarios; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentarios';
        }
        field(4; Ubicacion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion';
        }
    }

    keys
    {
        key(Key1; "No. Ident. Devolucion", "No. Bulto")
        {
        }
    }

    fieldgroups
    {
    }
}

