page 67177 "Visitas A/C - Selec. Docentes"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 67043;
    SourceTableView = WHERE("Pertenece al CDS" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Seleccionar; Seleccionar)
                {
                    Caption = 'Select';

                    trigger OnValidate()
                    var
                        AsistEvento: Record 67106;
                        Err001: Label 'No se permite deseleccionar. Este Docente ya fue inscrito.';
                    begin

                        IF Seleccionar THEN BEGIN
                            AsistEvento.RESET;
                            AsistEvento.SETRANGE(AsistEvento."No. Visita", gCodVisita);
                            AsistEvento.SETRANGE("Cod. Docente", "Cod. Docente");
                            IF NOT AsistEvento.FINDFIRST THEN
                                MARK(Seleccionar);
                        END
                        ELSE BEGIN
                            AsistEvento.RESET;
                            AsistEvento.SETRANGE(AsistEvento."No. Visita", gCodVisita);
                            AsistEvento.SETRANGE("Cod. Docente", "Cod. Docente");
                            IF AsistEvento.FINDFIRST THEN
                                ERROR(Err001);
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

    }

    trigger OnAfterGetRecord()
    var
        AsistEvento: Record 67106;
    begin
        Seleccionar := FALSE;
        AsistEvento.RESET;
        AsistEvento.SETRANGE(AsistEvento."No. Visita", gCodVisita);
        AsistEvento.SETRANGE("Cod. Docente", "Cod. Docente");
        IF AsistEvento.FINDFIRST THEN
            Seleccionar := TRUE;
    end;

    trigger OnOpenPage()
    var
        rGrupoCOL: Record 67089;
    begin

        SETRANGE("Cod. Colegio", gCodCol);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            OKOnPush;
    end;

    var
        gCodVisita: Code[20];
        gCodCol: Code[20];
        gCodLocal: Code[20];
        Seleccionar: Boolean;

    procedure RecibeParametros(CodVisita: Code[20]; CodCol: Code[20]; CodLocal: Code[20])
    begin
        gCodVisita := CodVisita;
        gCodCol := CodCol;
    end;

    local procedure OKOnPush()
    var
        Programacion: Record 67103;
        Asistentes: Record 67106;
    begin

        MARKEDONLY(TRUE);
        IF FINDSET THEN
            REPEAT
                Programacion.RESET;
                Programacion.SETRANGE(Programacion."No. Visita", gCodVisita);
                Programacion.FINDSET;
                REPEAT
                    Asistentes.INIT;
                    Asistentes.VALIDATE(Asistentes."No. Visita", Programacion."No. Visita");
                    Asistentes.VALIDATE(Asistentes."No. Linea Progr.", Programacion."No. Linea");
                    Asistentes.VALIDATE("Cod. Docente", "Cod. Docente");
                    Asistentes.INSERT(TRUE);
                UNTIL Programacion.NEXT = 0;
            UNTIL NEXT = 0;
    end;
}

