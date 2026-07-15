page 34002233 "Asistentes entrenamientos"
{
    Caption = 'Training assistants';
    DataCaptionExpression = "Titulo entrenamiento";
    PageType = List;
    SourceTable = 34002206;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. entrenamiento"; "No. entrenamiento")
                {
                    Visible = false;
                }
                field("Tipo entrenamiento"; "Tipo entrenamiento")
                {
                    Visible = false;
                }
                field("Fecha programacion"; "Fecha programacion")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Titulo entrenamiento"; "Titulo entrenamiento")
                {
                    Visible = false;
                }
                field("Tipo de Instructor"; "Tipo de Instructor")
                {
                    Visible = false;
                }
                field("Cod. Instructor"; "Cod. Instructor")
                {
                    Visible = false;
                }
                field("Nombre Instructor"; "Nombre Instructor")
                {
                    Editable = false;
                    Visible = false;
                }
                field("No. empleado"; "No. empleado")
                {
                }
                field("Nombre completo"; "Nombre completo")
                {
                }
                field("Document ID"; "Document ID")
                {
                    Editable = false;
                }
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                }
                field(Inscrito; Inscrito)
                {
                }
                field(Notificado; Notificado)
                {
                }
                field(Confirmado; Confirmado)
                {
                }
                field(Asistio; Asistio)
                {
                }
                field(Calificacion; Calificacion)
                {
                }
            }
            group(Assistants)
            {
                Caption = 'Assistants';
                field(TotalInscritos; TotalInscritos)
                {
                    Caption = 'Total Enrolled';
                    Editable = false;
                }
                field(TotalAsistentes; TotalAsistentes)
                {
                    Caption = 'Total Attendees';
                    Editable = false;
                }
                field(Capacidad; Capacidad)
                {
                    Caption = 'Maximum capacity';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Empleado")
            {
                Caption = '&Empleado';
                action(Notify)
                {
                    Caption = 'Notify';
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TODO: Ver FuncEnt.EnviarNotificacion(Rec);
                    end;
                }

                action("Mark confirmation")
                {
                    Caption = 'Mark confirmation';
                    Image = Confirm;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                }

                action("Mark attendance")
                {
                    Caption = 'Mark attendance';
                    Image = Approve;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        HaceCalculos
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        HaceCalculos
    end;

    trigger OnModifyRecord(): Boolean
    begin
        HaceCalculos
    end;

    trigger OnOpenPage()
    begin
        HaceCalculos
    end;

    var
        CabEntrenamiento: Record 34002204;
        Asistentesentrenamientos: Record 34002206;
        //TODO: Ver FuncEnt: Codeunit 34002145;
        TotalInscritos: Integer;
        TotalAsistentes: Integer;
        Capacidad: Integer;

    local procedure HaceCalculos()
    begin
        TotalInscritos := 0;
        TotalAsistentes := 0;
        Capacidad := 0;

        Asistentesentrenamientos.RESET;
        Asistentesentrenamientos.SETRANGE("No. entrenamiento", "No. entrenamiento");
        IF Asistentesentrenamientos.FINDSET THEN
            TotalInscritos := Asistentesentrenamientos.COUNT;

        Asistentesentrenamientos.RESET;
        Asistentesentrenamientos.SETRANGE("No. entrenamiento", "No. entrenamiento");
        Asistentesentrenamientos.SETRANGE(Asistio, TRUE);
        IF Asistentesentrenamientos.FINDSET THEN
            TotalAsistentes := Asistentesentrenamientos.COUNT;

        CabEntrenamiento.SETFILTER("No. entrenamiento", GETFILTER("No. entrenamiento"));
        CabEntrenamiento.FINDFIRST;
        Capacidad := CabEntrenamiento."Asistentes esperados";
    end;
}

