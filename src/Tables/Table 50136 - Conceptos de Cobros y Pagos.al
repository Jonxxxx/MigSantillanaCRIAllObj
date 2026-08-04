table 55135 "Conceptos de Cobros y Pagos"
{

    fields
    {
        field(1; "Codigo Concepto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Concepto';
        }
        field(2; Descripcion; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionMembers = Cobro,Pago;
        }
    }

    keys
    {
        key(Key1; "Codigo Concepto")
        {
        }
    }

    fieldgroups
    {
    }
}

