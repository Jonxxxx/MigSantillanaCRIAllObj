page 67103 "Seleccionar Docentes"
{
    PageType = List;
    SourceTable = 67001;

    layout
    {
        area(content)
        {
            repeater(GeneralA)
            {
                field(Seleccionar; Seleccionar)
                {
                    Caption = 'Select';

                    trigger OnValidate()
                    var
                        AsistEvento: Record 67016;
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
                field("No."; "No.")
                {
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field("Full Name"; "Full Name")
                {
                }
                field("Tipo documento"; "Tipo documento")
                {
                }
                field("Document ID"; "Document ID")
                {
                }
                field("Pertenece al CDS"; "Pertenece al CDS")
                {
                }
                field("Cod. CDS"; "Cod. CDS")
                {
                }
                field("Ano inscripcion CDS"; "Ano inscripcion CDS")
                {
                }
                field(Status; Status)
                {
                }
            }
        }
        area(factboxes)
        {
            part(PagePart; 67107)
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
        AsistEvento: Record 67016;
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
        Asistentes: Record 67016;
        CabPlanifEvento: Record 67051;
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
        Programacion: Record 67015;
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

