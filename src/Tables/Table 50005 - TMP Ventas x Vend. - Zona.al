table 55230 "TMP: Ventas x Vend. - Zona"
{

    fields
    {
        field(1; "Cod. Vendedor"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Vendedor';
        }
        field(2; "Cod. Zona"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Zona';
        }
        field(3; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(4; "Monto Original"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto Original';
        }
        field(5; "Monto Pendiente"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto Pendiente';
        }
    }

    keys
    {
        key(Key1; "Cod. Vendedor", "Cod. Zona", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

