page 67121 "Seguimiento Solicitud TE"
{
    // ,

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table67079;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Cambio"; "No. Cambio")
                {
                }
                field(Status; Status)
                {
                }
                field(Fecha; Fecha)
                {
                }
                field(Hora; Hora)
                {
                }
                field(Usuario; Usuario)
                {
                }
                field(wComentario; wComentario)
                {
                    Caption = 'Comentario';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        rSolicitud: Record 67055;
    begin

        CLEAR(wComentario);
        rSolicitud.GET("No. Solicitud");
        CASE Status OF
            Status::"Enviada por promotor":
                wComentario := rSolicitud.Observaciones;
            Status::Aprobada:
                wComentario := rSolicitud."Comentario Aprobado";
            Status::Programada:
                wComentario := rSolicitud."Comentario Programado";
            Status::Cancelada:
                wComentario := rSolicitud."Comentario Cancelado";
            Status::Rechazada:
                wComentario := rSolicitud."Comentario Rechazado";
        END;
    end;

    var
        wComentario: Text[150];
}

