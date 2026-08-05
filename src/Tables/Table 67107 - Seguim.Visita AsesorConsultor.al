table 55566 "Seguim.Visita Asesor/Consultor"
{

    fields
    {
        field(1; "Visita Asesor/Consultor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Visita Asesor/Consultor';
        }
        field(2; "No. Cambio"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cambio';
        }
        field(3; Estado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            OptionMembers = Programada,Ejecutada;
        }
        field(4; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(5; Usuario; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario';
        }
        field(6; Hora; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora';
        }
    }

    keys
    {
        key(Key1; "Visita Asesor/Consultor", "No. Cambio")
        {
        }
    }

    fieldgroups
    {
    }

    procedure InsertarSeguimiento(parVisita: Record 55561)
    begin
        "Visita Asesor/Consultor" := parVisita."No. Visita Asesor/Consultor";
        Estado := parVisita.Estado;
        Fecha := WORKDATE;
        Hora := TIME;
        Usuario := USERID;
        INSERT(TRUE);
    end;
}

