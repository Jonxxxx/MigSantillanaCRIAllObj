table 67086 "Dis. Centros Costo"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
        }
        field(2; "C digo"; Code[20])
        {
        }
        field(3; "Descripci n"; Text[60])
        {
        }
        field(4; Porcentaje; Decimal)
        {
            Caption = '%';
            MaxValue = 100;
            MinValue = 0;
        }
        field(5; "Cod. Taller - Evento"; Code[20])
        {
            TableRelation = Eventos."No.";
        }
        field(6; "Tipo Evento"; Code[20])
        {
            TableRelation = "Tipos de Eventos";
        }
        field(8; Expositor; Code[20])
        {
        }
        field(9; Secuencia; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Taller - Evento", Expositor, Secuencia, "C digo")
        {
        }
    }

    fieldgroups
    {
    }
}

