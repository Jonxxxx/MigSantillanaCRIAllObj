table 67079 "Seguimiento Solicitud TE"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
        field(2; "No. Cambio"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cambio';
        }
        field(3; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = ' ,Enviada por promotor,Aprobada,Programada,Cancelada,Rechazada,Realizada';
            OptionMembers = " ","Enviada por promotor",Aprobada,Programada,Cancelada,Rechazada,Realizada;
        }
        field(4; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(5; Usuario; Code[20])
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
        key(Key1; "No. Solicitud", "No. Cambio")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        SegSol: Record 67079;
    begin
        SegSol.SETRANGE("No. Solicitud", "No. Solicitud");
        IF SegSol.FINDLAST THEN
            "No. Cambio" := SegSol."No. Cambio" + 1
        ELSE
            "No. Cambio" := 1;
    end;

    procedure InsertarSeguimiento(parSolicitud: Record 67055)
    begin
        "No. Solicitud" := parSolicitud."No. Solicitud";
        Status := parSolicitud.Status;
        Fecha := WORKDATE;
        Hora := TIME;
        Usuario := USERID;
        INSERT(TRUE);
    end;
}

