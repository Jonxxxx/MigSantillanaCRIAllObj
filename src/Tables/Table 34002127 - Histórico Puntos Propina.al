table 34002127 "Historico Puntos Propina"
{

    fields
    {
        field(1; "No. Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Empleado';
        }
        field(2; "Fecha Aplicacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Aplicacion';
        }
        field(3; Punto; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Punto';
        }
    }

    keys
    {
        key(Key1; "No. Empleado")
        {
        }
    }

    fieldgroups
    {
    }
}

