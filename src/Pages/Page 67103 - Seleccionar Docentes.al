page 55562 "Seleccionar Docentes"
{
    PageType = List;
    SourceTable = 55468;

    layout
    {
        area(content)
        {
            repeater(GeneralA)
            {
                field(Seleccionar; Seleccionar)
                {
                    ApplicationArea = All;
                    Caption = 'Select';

                    trigger OnValidate()
                    var
                        AsistEvento: Record 55483;
                    begin

                        IF Seleccionar THEN BEGIN
                            AsistEvento.RESET;
                            AsistEvento.SETRANGE("Cod. Taller - Evento", gCodEvento);
                            AsistEvento.SETRANGE("Cod. Expositor", gCodExpositor);
                            AsistEvento.SETRANGE(Secuencia, Sec);
                            AsistEvento.SETRANGE("Tipo Evento", gTipoEvento);
                            AsistEvento.SETRANGE("Cod. Docente", "No.");
                            IF NOT AsistEvento.FINDFIRST THEN
                                MARK(Seleccionar);
                        END;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'First Name';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Middle Name';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Name';
                }
                field("Second Last Name"; Rec."Second Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Last Name';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full Name';
                }
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document ID';
                }
                field("Pertenece al CDS"; Rec."Pertenece al CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pertenece al CDS';
                }
                field("Cod. CDS"; Rec."Cod. CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. CDS';
                }
                field("Ano inscripcion CDS"; Rec."Ano inscripcion CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano inscripcion CDS';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
            }
        }
        area(factboxes)
        {
            part(PagePart; 55566)
            {
                SubPageLink = "Cod. Docente" = FIELD("No.");
            }
        }
    }

    actions
    {

    }

    trigger OnAfterGetRecord()
    var
        AsistEvento: Record 55483;
    begin
        Seleccionar := FALSE;
        AsistEvento.RESET;
        AsistEvento.SETRANGE("Cod. Taller - Evento", gCodEvento);
        AsistEvento.SETRANGE("Cod. Expositor", gCodExpositor);
        AsistEvento.SETRANGE(Secuencia, Sec);
        AsistEvento.SETRANGE("Tipo Evento", gTipoEvento);
        AsistEvento.SETRANGE("Cod. Docente", "No.");
        IF AsistEvento.FINDFIRST THEN
            Seleccionar := TRUE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            OKOnPush;
    end;

    var
        Asistentes: Record 55483;
        CabPlanifEvento: Record 55518;
        gCodEvento: Code[20];
        gCodExpositor: Code[20];
        gTipoEvento: Code[20];
        Sec: Integer;
        Seleccionar: Boolean;

    procedure RecibeParametros(CodEvento: Code[20]; CodExpositor: Code[20]; Secuencia: Integer; TipoEvento: Code[20])
    begin
        gCodEvento := CodEvento;
        Sec := Secuencia;
        gCodExpositor := CodExpositor;
        gTipoEvento := TipoEvento;
    end;

    local procedure OKOnPush()
    var
        Programacion: Record 55482;
    begin
        CabPlanifEvento.RESET;
        CabPlanifEvento.SETRANGE("Tipo Evento", gTipoEvento);
        CabPlanifEvento.SETRANGE("Cod. Taller - Evento", gCodEvento);
        CabPlanifEvento.SETRANGE(Expositor, gCodExpositor);
        CabPlanifEvento.SETRANGE(Secuencia, Sec);
        CabPlanifEvento.FINDFIRST;

        MARKEDONLY(TRUE);
        IF FINDSET THEN
            REPEAT
                Programacion.RESET;
                Programacion.SETRANGE("Cod. Taller - Evento", CabPlanifEvento."Cod. Taller - Evento");
                Programacion.SETRANGE("Tipo Evento", CabPlanifEvento."Tipo Evento");
                Programacion.SETRANGE(Expositor, CabPlanifEvento.Expositor);
                Programacion.SETRANGE(Secuencia, CabPlanifEvento.Secuencia);
                Programacion.FINDSET;
                REPEAT
                    Asistentes.INIT;
                    Asistentes.VALIDATE("Tipo Evento", gTipoEvento);
                    Asistentes.VALIDATE("Cod. Taller - Evento", CabPlanifEvento."Cod. Taller - Evento");
                    Asistentes.VALIDATE("Tipo de Expositor", Programacion."Tipo de Expositor");
                    Asistentes.VALIDATE("Cod. Expositor", gCodExpositor);
                    Asistentes.Secuencia := Sec;
                    Asistentes.VALIDATE("Cod. Docente", "No.");
                    Asistentes."No Linea Programac." := Programacion."No. Linea";
                    Asistentes."Fecha programacion" := Programacion."Fecha programacion";
                    Asistentes."No. Solicitud" := CabPlanifEvento."No. Solicitud";
                    Asistentes.INSERT(TRUE);
                UNTIL Programacion.NEXT = 0;
            UNTIL NEXT = 0;
    end;
}

