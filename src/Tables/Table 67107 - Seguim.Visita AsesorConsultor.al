table 67107 "Seguim.Visita Asesor/Consultor"
{

    fields
    {
        field(1; "Visita Asesor/Consultor"; Code[20])
        {
        }
        field(2; "No. Cambio"; Integer)
        {
        }
        field(3; Estado; Option)
        {
            OptionMembers = Programada,Ejecutada;
        }
        field(4; Fecha; Date)
        {
        }
        field(5; Usuario; Code[50])
        {
        }
        field(6; Hora; Time)
        {
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

    procedure InsertarSeguimiento(parVisita Record: 67102")
    begin
        "Visita Asesor/Consultor" := parVisita."No. Visita Asesor/Consultor";
        Estado := parVisita.Estado;
        Fecha := WORKDATE;
        Hora := TIME;
        Usuario := USERID;
        INSERT(TRUE);
    end;
}

