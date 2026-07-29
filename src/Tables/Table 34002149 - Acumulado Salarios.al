table 34002149 "Acumulado Salarios"
{

    fields
    {
        field(1; "Empresa cotizacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa cotizacion';
            TableRelation = "Empresas Cotizacion";
        }
        field(2; "No. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
            TableRelation = Employee;
        }
        field(4; "Fecha Desde"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Desde';
        }
        field(5; "Fecha Hasta"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Hasta';
        }
        field(6; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
    }

    keys
    {
        key(Key1; "Empresa cotizacion", "No. empleado", "Fecha Desde")
        {
        }
    }

    fieldgroups
    {
    }
}

