page 67121 "Seguimiento Solicitud TE"
{
    // ,

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55546;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Cambio"; Rec."No. Cambio")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cambio';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field(Hora; Rec.Hora)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora';
                }
                field(Usuario; Rec.Usuario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario';
                }
                field(wComentario; wComentario)
                {
                    ApplicationArea = All;
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
        rSolicitud: Record 55522;
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

