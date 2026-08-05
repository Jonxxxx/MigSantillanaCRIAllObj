table 55662 "Plantilla Queen Rel. Mat. BIC"
{

    fields
    {
        field(1; "Codigo Santillana"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Santillana';
        }
        field(2; "Codigo BIC"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo BIC';
        }
    }

    keys
    {
        key(Key1; "Codigo Santillana")
        {
        }
    }

    fieldgroups
    {
    }
}

