table 55445 "Facuras RHM"
{

    fields
    {
        field(1; Documento; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Documento';
        }
        field(2; "Fecha registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha registro';
        }
        field(3; Cliente; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cliente';
        }
        field(4; Nombre; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(5; "Importe Original"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Original';
        }
        field(6; "Importe pendiente"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe pendiente';
        }
        field(7; "Importe RHM"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe RHM';
        }
    }

    keys
    {
        key(Key1; Documento)
        {
        }
    }

    fieldgroups
    {
    }
}

