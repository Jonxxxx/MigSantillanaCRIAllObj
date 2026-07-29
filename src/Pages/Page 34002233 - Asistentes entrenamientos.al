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
                field("No. entrenamiento"; Rec."No. entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. entrenamiento';
                    Visible = false;
                }
                field("Tipo entrenamiento"; Rec."Tipo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo entrenamiento';
                    Visible = false;
                }
                field("Fecha programacion"; Rec."Fecha programacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha programacion';
                    Editable = false;
                    Visible = false;
                }
                field("Titulo entrenamiento"; Rec."Titulo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Titulo entrenamiento';
                    Visible = false;
                }
                field("Tipo de Instructor"; Rec."Tipo de Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Instructor';
                    Visible = false;
                }
                field("Cod. Instructor"; Rec."Cod. Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Instructor';
                    Visible = false;
                }
                field("Nombre Instructor"; Rec."Nombre Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Instructor';
                    Editable = false;
                    Visible = false;
                }
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                }
                field("Nombre completo"; Rec."Nombre completo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre completo';
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document ID';
                    Editable = false;
                }
                field("Fecha inscripcion"; Rec."Fecha inscripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inscripcion';
                }
                field(Inscrito; Rec.Inscrito)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inscrito';
                }
                field(Notificado; Rec.Notificado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Notificado';
                }
                field(Confirmado; Rec.Confirmado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Confirmado';
                }
                field(Asistio; Rec.Asistio)
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistio';
                }
                field(Calificacion; Rec.Calificacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Calificacion';
                }
            }
            group(Assistants)
            {
                Caption = 'Assistants';
                field(TotalInscritos; TotalInscritos)
                {
                    ApplicationArea = All;
                    Caption = 'Total Enrolled';
                    Editable = false;
                }
                field(TotalAsistentes; TotalAsistentes)
                {
                    ApplicationArea = All;
                    Caption = 'Total Attendees';
                    Editable = false;
                }
                field(Capacidad; Capacidad)
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Notify';
                    ToolTip = 'Notify';
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // TODO: Manual review - Codeunit 34002145 exists but does not expose the legacy EnviarNotificacion procedure.
                        // Original code: FuncEnt.EnviarNotificacion(Rec);
                    end;
                }

                action("Mark confirmation")
                {
                    ApplicationArea = All;
                    Caption = 'Mark confirmation';
                    ToolTip = 'Mark confirmation';
                    Image = Confirm;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                }

                action("Mark attendance")
                {
                    ApplicationArea = All;
                    Caption = 'Mark attendance';
                    ToolTip = 'Mark attendance';
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
        // TODO: Manual review - The verified training codeunit lacks the required EnviarNotificacion procedure.
        // Original code: FuncEnt: Codeunit 34002145;
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

