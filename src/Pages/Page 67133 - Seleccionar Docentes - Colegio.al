page 55592 "Seleccionar Docentes - Colegio"
{
    PageType = List;
    SourceTable = 55510;
    SourceTableView = WHERE("Pertenece al CDS" = CONST(true));

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
                            AsistEvento.SETRANGE("Cod. Docente", "Cod. Docente");
                            IF NOT AsistEvento.FINDFIRST THEN
                                MARK(Seleccionar);
                        END;
                    end;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Cod. Docente"; Rec."Cod. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Docente';
                }
                field("Nombre docente"; Rec."Nombre docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre docente';
                }
                field("Cod. Cargo"; Rec."Cod. Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cargo';
                }
                field("Docente - Phone No."; Rec."Docente - Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docente - Phone No.';
                }
                field("Docente - Document ID"; Rec."Docente - Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docente - Document ID';
                }
                field("Docente - E-Mail"; Rec."Docente - E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docente - E-Mail';
                }
                field("Pertenece al CDS"; Rec."Pertenece al CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pertenece al CDS';
                    Editable = false;
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                }
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
        AsistEvento.SETRANGE("Cod. Docente", "Cod. Docente");
        IF AsistEvento.FINDFIRST THEN
            Seleccionar := TRUE;
    end;

    trigger OnOpenPage()
    var
        rGrupoCOL: Record 55651;
    begin
        IF gGrupo THEN BEGIN
            rGrupoCOL.GET(gCodGrupo);
            rGrupoCOL.CheckGrupo();
            SETFILTER("Cod. Colegio", rGrupoCOL.GetColegios());
        END
        ELSE BEGIN
            SETRANGE("Cod. Colegio", gCodCol);
            SETRANGE("Cod. Local", gCodLocal);
        END;
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
        gCodCol: Code[20];
        gCodLocal: Code[20];
        gGrupo: Boolean;
        gCodGrupo: Code[20];

    procedure RecibeParametros(CodEvento: Code[20]; CodExpositor: Code[20]; Secuencia: Integer; TipoEvento: Code[20]; CodCol: Code[20]; CodLocal: Code[20]; Grupo: Boolean; CodGrupo: Code[20])
    begin
        gCodEvento := CodEvento;
        Sec := Secuencia;
        gCodExpositor := CodExpositor;
        gTipoEvento := TipoEvento;
        gCodCol := CodCol;
        gCodLocal := CodLocal;
        gGrupo := Grupo;
        gCodGrupo := CodGrupo;
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
                    Asistentes.VALIDATE("Cod. Docente", "Cod. Docente");
                    Asistentes."No Linea Programac." := Programacion."No. Linea";
                    Asistentes."Fecha programacion" := Programacion."Fecha programacion";
                    Asistentes."No. Solicitud" := CabPlanifEvento."No. Solicitud";
                    Asistentes.INSERT(TRUE);
                UNTIL Programacion.NEXT = 0;
            UNTIL NEXT = 0;
    end;
}

