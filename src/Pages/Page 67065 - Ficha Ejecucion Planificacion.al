page 67065 "Ficha Ejecucion Planificacion"
{
    DataCaptionFields = "Nombre Colegio";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Samples';
    SourceTable = Table67038;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = page_editable;
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Editable = false;
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Local"; "Local")
                {
                }
                field(Fecha; Fecha)
                {
                    Editable = false;
                }
            }
            group(Visit)
            {
                Caption = 'Visit';
                Editable = page_editable;
                field(Turno; Turno)
                {
                }
                field(Nivel; Nivel)
                {
                }
                field(Tipo; Tipo)
                {

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
                field("Persona atendio"; "Persona atendio")
                {
                    Editable = TipoCDS;
                }
                field("Nombre persona atendio"; "Nombre persona atendio")
                {
                    Editable = TipoCDS_2;
                }
                field(Cargo; Cargo)
                {
                }
                field("Descripcion Cargo"; "Descripcion Cargo")
                {
                    Editable = false;
                }
                field(Objetivo; Objetivo)
                {
                }
                field("Descripcion Objetivo"; "Descripcion Objetivo")
                {
                    Editable = false;
                }
                field("Fecha Visita"; "Fecha Visita")
                {
                }
                field("Hora Inicial Visita"; "Hora Inicial Visita")
                {
                }
                field("Hora Final Visita"; "Hora Final Visita")
                {
                }
                field("Fecha Proxima Visita"; "Fecha Proxima Visita")
                {
                }
                field(Calificacion; Calificacion)
                {
                }
                field("Estado Colegio"; "Estado Colegio")
                {
                }
                field(Comentario; Comentario)
                {
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
                        Caption = 'Delivery';
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
                        Caption = 'Return';
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
                    Caption = '&Post';
                    Enabled = Page_Editable;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        Planif Record: 67038;
                        Planif2Record 67038;
                        CabPlanifReg Record: 67054;
                        recWFprog Record: 67062;
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
                    Caption = 'Programmed';
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        WF Record: 67062;
                        Texto001: Label 'Ya está marcado como programado. ¿Desea quitar la marca?';
                        Texto002: Label '¿Desea marcar como programado?';
                        Error001: Label 'No se permite realizar esta acción. La visita está registrada.';
                        Texto003: Label 'La acción se ha realizado con éxito.';
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
                    Caption = 'Objectives';
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page 67136;
                    RunPageLink = Cod. Promotor=FIELD(Cod. Promotor),
                                  Cod. Colegio=FIELD(Cod. Colegio),
                                  Area=CONST(true);
                }
                action(Steps)
                {
                    Caption = 'Steps';
                    Image = ImplementPriceChange;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page 67137;
                                    RunPageLink = Cod. Promotor=FIELD(Cod. Promotor),
                                  Cod. Colegio=FIELD(Cod. Colegio),
                                  Paso=CONST(true);
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
        Muestras: Page67038;
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
        recWFobj Record: 67062;
        Texto001: Label '¿Desea %1 sin marcar objetivos?';
        Error001: Label 'Acción cancelada por el usuario.';
        recWFprog Record: 67062;
    begin

        recWFprog.RESET;
        recWFprog.SETRANGE("Cod. Promotor","Cod. Promotor");
        recWFprog.SETRANGE("Cod. Colegio", "Cod. Colegio");
        recWFprog.SETRANGE(Programado, TRUE);
        IF recWFprog.FINDFIRST THEN BEGIN
          recWFobj.RESET;
          recWFobj.SETRANGE("Cod. Promotor","Cod. Promotor");
          recWFobj.SETRANGE("Cod. Colegio", "Cod. Colegio");
          recWFobj.SETRANGE(Area, TRUE);
          recWFobj.SETRANGE(Mantenimiento,TRUE);
          IF NOT recWFobj.FINDFIRST THEN BEGIN
            recWFobj.SETRANGE(Mantenimiento);
            recWFobj.SETRANGE(Conquista,TRUE);
            IF NOT recWFobj.FINDFIRST THEN
              IF NOT CONFIRM(STRSUBSTNO(Texto001,pAccion)) THEN
                ERROR(Error001);
          END;
        END;
    end;

    procedure ValidaPasos(pAccion: Option Registrar,Salir)
    var
        Texto001: Label '¿Desea %1 sin marcar pasos?';
        Error001: Label 'Acción cancelada por el usuario.';
        recWFobj Record: 67062;
        recWFpasos Record: 67062;
        Texto002: Label '¿Desea %1 sin marcar algún paso más?';
    begin

        recWFobj.RESET;
        recWFobj.SETRANGE("Cod. Promotor","Cod. Promotor");
        recWFobj.SETRANGE("Cod. Colegio", "Cod. Colegio");
        recWFobj.SETRANGE(Area, TRUE);
        recWFobj.SETRANGE(Mantenimiento,TRUE);
        IF NOT recWFobj.FINDFIRST THEN BEGIN
          recWFobj.SETRANGE(Mantenimiento);
          recWFobj.SETRANGE(Conquista,TRUE);
        END;
        IF recWFobj.FINDFIRST THEN BEGIN
          recWFpasos.RESET;
          recWFpasos.SETRANGE("Cod. Promotor","Cod. Promotor");
          recWFpasos.SETRANGE("Cod. Colegio", "Cod. Colegio");
          recWFpasos.SETRANGE(Paso, TRUE);
          recWFpasos.SETRANGE(Resultado,TRUE);
          IF NOT recWFpasos.FINDFIRST THEN
            IF NOT CONFIRM(STRSUBSTNO(Texto001,pAccion)) THEN
              ERROR(Error001);
          recWFpasos.SETRANGE(Resultado,FALSE);
          IF recWFpasos.FINDFIRST THEN
            IF NOT CONFIRM(STRSUBSTNO(Texto002,pAccion)) THEN
              ERROR(Error001);

        END;
    end;
}

