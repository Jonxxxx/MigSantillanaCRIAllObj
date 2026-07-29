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
                    ApplicationArea = All;
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

