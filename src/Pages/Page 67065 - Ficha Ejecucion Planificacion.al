page 55532 "Ficha Ejecucion Planificacion"
{
    DataCaptionFields = "Nombre Colegio";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Samples';
    SourceTable = 55505;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = page_editable;
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Editable = false;
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                    Editable = false;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Local"; Rec."Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Local';
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                    Editable = false;
                }
            }
            group(Visit)
            {
                Caption = 'Visit';
                Editable = page_editable;
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                }
                field(Nivel; Rec.Nivel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';

                    trigger OnValidate()
                    begin
                        TipoCDS := FALSE;
                        TipoCDS_2 := TRUE;
                        IF Tipo = 1 THEN BEGIN
                            TipoCDS_2 := FALSE;
                            TipoCDS := TRUE;
                        END;
                    end;
                }
                field("Persona atendio"; Rec."Persona atendio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Persona atendio';
                    Editable = TipoCDS;
                }
                field("Nombre persona atendio"; Rec."Nombre persona atendio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre persona atendio';
                    Editable = TipoCDS_2;
                }
                field(Cargo; Rec.Cargo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cargo';
                }
                field("Descripcion Cargo"; Rec."Descripcion Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Cargo';
                    Editable = false;
                }
                field(Objetivo; Rec.Objetivo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Objetivo';
                }
                field("Descripcion Objetivo"; Rec."Descripcion Objetivo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Objetivo';
                    Editable = false;
                }
                field("Fecha Visita"; Rec."Fecha Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Visita';
                }
                field("Hora Inicial Visita"; Rec."Hora Inicial Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Inicial Visita';
                }
                field("Hora Final Visita"; Rec."Hora Final Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Final Visita';
                }
                field("Fecha Proxima Visita"; Rec."Fecha Proxima Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Proxima Visita';
                }
                field(Calificacion; Rec.Calificacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Calificacion';
                }
                field("Estado Colegio"; Rec."Estado Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado Colegio';
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
                    MultiLine = true;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Planning")
            {
                Caption = '&Planning';
                group("<Action1000000026>")
                {
                    Caption = '&Samples';
                    action(Delivery)
                    {
                        ApplicationArea = All;
                        Caption = 'Delivery';
                        ToolTip = 'Delivery';
                        Image = NewWarehouseShipment;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;

                        trigger OnAction()
                        begin
                            Muestras.SETRECORD(Rec);
                            Muestras.CargaEntregaMuestras;
                        end;
                    }
                    action(Return)
                    {
                        ApplicationArea = All;
                        Caption = 'Return';
                        ToolTip = 'Return';
                        Image = NewWarehouseReceipt;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;

                        trigger OnAction()
                        begin
                            Muestras.SETRECORD(Rec);
                            Muestras.CargaDevolucionMuestras;
                        end;
                    }
                }
                action("&Post")
                {
                    ApplicationArea = All;
                    Caption = '&Post';
                    ToolTip = '&Post';
                    Enabled = Page_Editable;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        Planif: Record 55505;
                        Planif2Record: Record 55505;
                        CabPlanifReg: Record 55521;
                        recWFprog: Record 55529;
                        Texto001: Label '¿Desea cerrar la visita sin programar?';
                        Error001: Label 'Proceso cancelado por el usuario.';
                    begin
                        TESTFIELD(Turno);
                        TESTFIELD(Nivel);
                        TESTFIELD(Turno);
                        IF Tipo = 0 THEN
                            ERROR(Err001);

                        TESTFIELD(Objetivo);

                        TESTFIELD("Hora Inicial Visita");
                        TESTFIELD("Hora Final Visita");
                        TESTFIELD("Fecha Proxima Visita");
                        TESTFIELD(Comentario);

                        recWFprog.SETRANGE("Cod. Promotor", "Cod. Promotor");
                        recWFprog.SETRANGE("Cod. Colegio", "Cod. Colegio");
                        recWFprog.SETRANGE(Programado, TRUE);
                        IF NOT recWFprog.FINDFIRST THEN
                            IF NOT CONFIRM(Texto001) THEN
                                ERROR(Error001);

                        //GRN, 15-003-2022, a peticion en Jira SANTINAV-3174
                        // ValidaObjetivos(Accion::Registrar);
                        // ValidaPasos(Accion::Registrar);

                        VALIDATE(Estado, Estado::Completado);
                        MODIFY;

                        CurrPage.CLOSE;
                        MESSAGE(Text001);
                    end;
                }
                action(Programmed)
                {
                    ApplicationArea = All;
                    Caption = 'Programmed';
                    ToolTip = 'Programmed';
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        WF: Record 55529;
                        Texto001: Label 'Ya está marcado como programado. ¿Desea quitar la marca?';
                        Texto002: Label '¿Desea marcar como programado?';
                        Error001: Label 'No se permite realizar esta accion. La visita está registrada.';
                        Texto003: Label 'La accion se ha realizado con éxito.';
                        Texto004: Label 'Ya está marcado como programado.';
                    begin
                        IF Estado = Estado::Completado THEN
                            ERROR(Error001);

                        WF.RESET;
                        WF.SETRANGE("Cod. Promotor", "Cod. Promotor");
                        WF.SETRANGE("Cod. Colegio", "Cod. Colegio");
                        WF.SETRANGE(Programado, TRUE);
                        IF WF.FINDFIRST THEN BEGIN
                            //IF CONFIRM(Texto001) THEN BEGIN
                            //  WF.DELETE;
                            //  MESSAGE(Texto003);
                            //END;
                            ERROR(Texto004);
                        END
                        ELSE BEGIN
                            WF.RESET;
                            IF CONFIRM(Texto002) THEN BEGIN
                                WF.INIT;
                                WF."Cod. Promotor" := "Cod. Promotor";
                                WF."Cod. Colegio" := "Cod. Colegio";
                                WF.Programado := TRUE;
                                WF.INSERT(TRUE);
                                MESSAGE(Texto003);
                            END;
                        END;
                    end;
                }
                action(Objectives)
                {
                    ApplicationArea = All;
                    Caption = 'Objectives';
                    ToolTip = 'Objectives';
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page 55595;
                    RunPageLink = "Cod. Promotor" = FIELD("Cod. Promotor"),
                                  "Cod. Colegio" = FIELD("Cod. Colegio"),
                                  "Area" = CONST(true);
                }
                action(Steps)
                {
                    ApplicationArea = All;
                    Caption = 'Steps';
                    ToolTip = 'Steps';
                    Image = ImplementPriceChange;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page 55596;
                    RunPageLink = "Cod. Promotor" = FIELD("Cod. Promotor"),
                                  "Cod. Colegio" = FIELD("Cod. Colegio"),
                                  "Paso" = CONST(true);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Page_Editable := Estado <> Estado::Completado;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        // ValidaObjetivos(Accion::Salir);
        // ValidaPasos(Accion::Salir);
    end;

    var
        Text001: Label 'The planning has been posted';
        Muestras: Page 55505;
        [InDataSet]

        TipoCDS: Boolean;
        [InDataSet]
        TipoCDS_2: Boolean;
        [InDataSet]
        Page_Editable: Boolean;
        Err001: Label 'Type must be CDS or Other';
        Accion: Option Registrar,Salir;

    procedure ValidaObjetivos(pAccion: Option Registrar,Salir)
    var
        recWFobj: Record 55529;
        Texto001: Label '¿Desea %1 sin marcar objetivos?';
        Error001: Label 'Accion cancelada por el usuario.';
        recWFprog: Record 55529;
    begin

        recWFprog.RESET;
        recWFprog.SETRANGE("Cod. Promotor", "Cod. Promotor");
        recWFprog.SETRANGE("Cod. Colegio", "Cod. Colegio");
        recWFprog.SETRANGE(Programado, TRUE);
        IF recWFprog.FINDFIRST THEN BEGIN
            recWFobj.RESET;
            recWFobj.SETRANGE("Cod. Promotor", "Cod. Promotor");
            recWFobj.SETRANGE("Cod. Colegio", "Cod. Colegio");
            recWFobj.SETRANGE(Area, TRUE);
            recWFobj.SETRANGE(Mantenimiento, TRUE);
            IF NOT recWFobj.FINDFIRST THEN BEGIN
                recWFobj.SETRANGE(Mantenimiento);
                recWFobj.SETRANGE(Conquista, TRUE);
                IF NOT recWFobj.FINDFIRST THEN
                    IF NOT CONFIRM(STRSUBSTNO(Texto001, pAccion)) THEN
                        ERROR(Error001);
            END;
        END;
    end;

    procedure ValidaPasos(pAccion: Option Registrar,Salir)
    var
        Texto001: Label '¿Desea %1 sin marcar pasos?';
        Error001: Label 'Accion cancelada por el usuario.';
        recWFobj: Record 55529;
        recWFpasos: Record 55529;
        Texto002: Label '¿Desea %1 sin marcar algún paso más?';
    begin

        recWFobj.RESET;
        recWFobj.SETRANGE("Cod. Promotor", "Cod. Promotor");
        recWFobj.SETRANGE("Cod. Colegio", "Cod. Colegio");
        recWFobj.SETRANGE(Area, TRUE);
        recWFobj.SETRANGE(Mantenimiento, TRUE);
        IF NOT recWFobj.FINDFIRST THEN BEGIN
            recWFobj.SETRANGE(Mantenimiento);
            recWFobj.SETRANGE(Conquista, TRUE);
        END;
        IF recWFobj.FINDFIRST THEN BEGIN
            recWFpasos.RESET;
            recWFpasos.SETRANGE("Cod. Promotor", "Cod. Promotor");
            recWFpasos.SETRANGE("Cod. Colegio", "Cod. Colegio");
            recWFpasos.SETRANGE(Paso, TRUE);
            recWFpasos.SETRANGE(Resultado, TRUE);
            IF NOT recWFpasos.FINDFIRST THEN
                IF NOT CONFIRM(STRSUBSTNO(Texto001, pAccion)) THEN
                    ERROR(Error001);
            recWFpasos.SETRANGE(Resultado, FALSE);
            IF recWFpasos.FINDFIRST THEN
                IF NOT CONFIRM(STRSUBSTNO(Texto002, pAccion)) THEN
                    ERROR(Error001);

        END;
    end;
}

