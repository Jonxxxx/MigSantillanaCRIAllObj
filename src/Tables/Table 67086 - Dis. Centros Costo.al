table 67086 "Dis. Centros Costo"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
        field(2; "Codigo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3; "Descripcion"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; Porcentaje; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Porcentaje';
            MaxValue = 100;
            MinValue = 0;
        }
        field(5; "Cod. Taller - Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Taller - Evento';
            TableRelation = Eventos."No.";
        }
        field(6; "Tipo Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Evento';
            TableRelation = "Tipos de Eventos";
        }
        field(8; Expositor; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Expositor';
        }
        field(9; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Taller - Evento", Expositor, Secuencia, "Codigo")
        {
        }
    }

    fieldgroups
    {
    }
}

