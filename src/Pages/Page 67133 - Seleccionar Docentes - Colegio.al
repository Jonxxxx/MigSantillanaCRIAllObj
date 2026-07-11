page 67133 "Seleccionar Docentes - Colegio"
{
    PageType = List;
    SourceTable = Table67043;
    SourceTableView = WHERE("Pertenece al CDS" = CONST(true));

    layout
    {
        area(content)
        {
            repeater()
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
                            AsistEvento.SETRANGE("Cod. Docente", "Cod. Docente");
                            IF NOT AsistEvento.FINDFIRST THEN
                                MARK(Seleccionar);
                        END;
                    end;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Cod. Docente"; "Cod. Docente")
                {
                }
                field("Nombre docente"; "Nombre docente")
                {
                }
                field("Cod. Cargo"; "Cod. Cargo")
                {
                }
                field("Docente - Phone No."; "Docente - Phone No.")
                {
                }
                field("Docente - Document ID"; "Docente - Document ID")
                {
                }
                field("Docente - E-Mail"; "Docente - E-Mail")
                {
                }
                field("Pertenece al CDS"; "Pertenece al CDS")
                {
                    Editable = false;
                }
                field("Cod. Promotor"; "Cod. Promotor")
                {
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                }
            }
        }
    }

    actions
    {
        group()
        {
            action()
            {

                trigger OnAction()
                begin
                    /*
                    TH.GET(NoDocumento);
                    SETRANGE("Location Code",TH."Transfer-from Code");
                    SETRANGE("Bin Code",TH."Cod. Ubicacion Alm. Origen");
                    
                    MARKEDONLY(TRUE);
                    IF FINDSET THEN
                        REPEAT
                         NoLin += 1000;
                         TL.INIT;
                         TL."Document No." := TH."No.";
                         TL."Line No."     := NoLin;
                         TL.VALIDATE("Transfer-from Code",TH."Transfer-from Code");
                         TL.VALIDATE("Transfer-to Code",TH."Transfer-to Code");
                         TL.VALIDATE("Item No.","Item No.");
                    //     TL.VALIDATE(Quantity,1);
                         IF TH."Cod. Ubicacion Alm. Origen" <> '' THEN
                            TL.VALIDATE("Transfer-from Bin Code",TH."Cod. Ubicacion Alm. Origen");
                         IF TH."Cod. Ubicacion Alm. Destino" <> '' THEN
                            TL.VALIDATE("Transfer-To Bin Code",TH."Cod. Ubicacion Alm. Destino");
                         IF NOT TL.INSERT(TRUE) THEN
                            TL.MODIFY(TRUE);
                        UNTIL NEXT = 0;
                    */

                end;
            }
        }
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
        AsistEvento.SETRANGE("Cod. Docente", "Cod. Docente");
        IF AsistEvento.FINDFIRST THEN
            Seleccionar := TRUE;
    end;

    trigger OnOpenPage()
    var
        rGrupoCOL: Record 67089;
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
        Asistentes: Record 67016;
        CabPlanifEvento: Record 67051;
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
                    Asistentes.VALIDATE("Cod. Docente", "Cod. Docente");
                    Asistentes."No Linea Programac." := Programacion."No. Linea";
                    Asistentes."Fecha programacion" := Programacion."Fecha programacion";
                    Asistentes."No. Solicitud" := CabPlanifEvento."No. Solicitud";
                    Asistentes.INSERT(TRUE);
                UNTIL Programacion.NEXT = 0;
            UNTIL NEXT = 0;
    end;
}

