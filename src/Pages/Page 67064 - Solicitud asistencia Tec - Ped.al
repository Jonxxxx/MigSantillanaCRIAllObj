page 67064 "Solicitud asistencia Tec - Ped"
{
    // ,Enviada por promotor
    // ,Aprobada
    // ,Programada
    // ,Cancelada
    // ,Rechazada
    // ,Realizada.

    Caption = 'Solicitud de Asistencia Técnico - Pedagógica';
    PageType = Card;
    PromotedActionCategories = 'Nuevo,Proceso,Reporte,Asistentes';
    SourceTable = Table67055;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No. Solicitud"; "No. Solicitud")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Cod. promotor"; "Cod. promotor")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        rVendedor: Record 13;
                        fVendedor: Page14;
                    begin

                        IF userPromotor THEN BEGIN
                            rVendedor.FILTERGROUP(2);
                            rVendedor.SETRANGE(rVendedor.Code, UserSetup."Salespers./Purch. Code");
                            rVendedor.FILTERGROUP(0);
                        END;
                        fVendedor.SETTABLEVIEW(rVendedor);
                        fVendedor.LOOKUPMODE(TRUE);
                        IF fVendedor.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            fVendedor.GETRECORD(rVendedor);
                            "Cod. promotor" := rVendedor.Code;
                            VALIDATE("Cod. promotor");
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        IF userPromotor THEN
                            TESTFIELD("Cod. promotor", UserSetup."Salespers./Purch. Code");
                    end;
                }
                field("Nombre promotor"; "Nombre promotor")
                {
                    Editable = false;
                }
                field(Delegacion; Delegacion)
                {
                }
                field("Grupo de Negocio"; "Grupo de Negocio")
                {
                }
                field("Tipo de Evento"; "Tipo de Evento")
                {
                }
                field("Existe evento"; "Existe evento")
                {
                    Editable = wEditExisteEvento;

                    trigger OnValidate()
                    begin
                        ExisteEvento;
                    end;
                }
                field("Cod. evento"; "Cod. evento")
                {
                    Editable = wExisteEv;

                    trigger OnValidate()
                    begin
                        IF "Cod. evento" <> '' THEN BEGIN
                            //    EditaDesc := FALSE;
                            "Desc. del Evento no existe" := '';
                        END
                        ELSE BEGIN
                            //    EditaDesc := TRUE;
                            "Descripcion evento" := '';
                        END;
                    end;
                }
                field("Descripcion evento"; "Descripcion evento")
                {
                    Editable = NOT wExisteEv;
                }
                field("Evento dictado por (tipo)"; "Evento dictado por (tipo)")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Evento dictado por (codigo)"; "Evento dictado por (codigo)")
                {
                    Editable = false;
                }
                field("Evento dictado por (nombre)"; "Evento dictado por (nombre)")
                {
                    Editable = false;
                }
                field("Fecha Solicitud"; "Fecha Solicitud")
                {
                }
                field("Cod. evento programado"; "Cod. evento programado")
                {
                    Enabled = (NOT userPromotor) AND wEvProg;
                }
                field("Descripción evento programado"; "Descripción evento programado")
                {
                    Enabled = NOT userPromotor;
                }
                field("Avisado al expositor"; "Avisado al expositor")
                {
                    Editable = wEvProg;
                    Enabled = NOT userPromotor;
                }
                field("Tipo de Expositor"; "Tipo de Expositor")
                {
                    Editable = false;
                    Enabled = NOT userPromotor;
                    Visible = false;
                }
                field("Cod. Expositor"; "Cod. Expositor")
                {
                    Editable = false;
                    Enabled = NOT userPromotor;
                }
                field("Nombre expositor"; "Nombre expositor")
                {
                    Editable = false;
                    Enabled = NOT userPromotor;
                }
                field("Selección Editorial"; "Selección Editorial")
                {

                    trigger OnValidate()
                    begin
                        Editorial;
                    end;
                }
                field("Desc.  Competencia"; "Desc.  Competencia")
                {
                    Editable = wCompetencia;
                }
                field("Grupo de Colegios"; "Grupo de Colegios")
                {

                    trigger OnValidate()
                    begin
                        GrupoColegios;
                    end;
                }
                field("Asociacion/Grupo"; "Asociacion/Grupo")
                {
                    Enabled = wAsocGrupo;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Enabled = NOT wAsocGrupo;
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Editable = false;
                }
                field("Direccion Colegio"; "Direccion Colegio")
                {
                    Editable = false;
                }
                field("Codigo Distrito Colegio"; "Codigo Distrito Colegio")
                {
                    Editable = false;
                }
                field("Nombre Distrito Colegio"; "Nombre Distrito Colegio")
                {
                    Editable = false;
                }
                field("Telefono 1 Colegio"; "Telefono 1 Colegio")
                {
                    Editable = false;
                }
                field("Telefono 2 Colegio"; "Telefono 2 Colegio")
                {
                    Editable = false;
                }
                field("Cod. Local"; "Cod. Local")
                {
                    Importance = Additional;
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Cod. Turno"; "Cod. Turno")
                {
                }
                field("Comentario Aprobado"; "Comentario Aprobado")
                {
                    Visible = wApro;
                }
                field("Comentario Programado"; "Comentario Programado")
                {
                    Visible = wProg;
                }
                field("Comentario Rechazado"; "Comentario Rechazado")
                {
                    Visible = wRech;
                }
                field("Comentario Cancelado"; "Comentario Cancelado")
                {
                    Visible = wCanc;
                }
                field(Referencia; Referencia)
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Usuario creación"; "Usuario creación")
                {
                }
            }
            group("Aditional Information")
            {
                Caption = 'Aditional Information';
                field("Tipo Responsable"; "Tipo Responsable")
                {
                    Caption = 'Type of contact';
                    OptionCaption = 'CDS,Other';

                    trigger OnValidate()
                    begin
                        NoPertenecealCDS := FALSE;
                        EditaDocente := TRUE;

                        IF "Tipo Responsable" = 1 THEN BEGIN
                            NoPertenecealCDS := TRUE;
                            EditaDocente := FALSE;
                            "Cod. Docente responsable" := '';
                        END;
                    end;
                }
                field("Cod. Docente responsable"; "Cod. Docente responsable")
                {
                    Editable = EditaDocente;
                }
                field("Nombre responsable"; "Nombre responsable")
                {
                    Editable = NoPertenecealCDS;
                }
                field("Cod. Cargo Responsable"; "Cod. Cargo Responsable")
                {
                    Editable = NoPertenecealCDS;
                }
                field("Descripción Cargo Responsable"; "Descripción Cargo Responsable")
                {
                    Editable = NoPertenecealCDS;
                }
                field("Telefono Responsable"; "Telefono Responsable")
                {
                }
                field("No. celular responsable"; "No. celular responsable")
                {
                }
                field("E-Mail Docente Responsable"; "E-Mail Docente Responsable")
                {
                }
                field("Col. tiene equipo MM"; "Col. tiene equipo MM")
                {
                    Caption = 'Colegio tiene equipo Multimedia';
                }
                field(Refrigerio; Refrigerio)
                {
                    Caption = 'Se requiere Refrigerio';
                    Editable = wSeReq;
                }
                field(Material; Material)
                {
                    Caption = 'Se requiere Material';
                    Editable = wSeReq;
                }
                field(Merchandising; Merchandising)
                {
                    Caption = 'Se requiere Merchandising';
                    Editable = wSeReq;
                }
                field("Cod. objetivo promotor"; "Cod. objetivo promotor")
                {
                }
                field("Objetivo promotor"; "Objetivo promotor")
                {
                    Editable = false;
                }
                field(Observaciones; Observaciones)
                {
                    Caption = 'Observaciones promotor';
                }
            }
            group(Asistentes)
            {
                Caption = 'Asistentes';
                field("Asistencia promotor"; "Asistencia promotor")
                {
                }
                field("Material para revisión"; "Material para revisión")
                {
                }
                field("Asistentes Esperados"; "Asistentes Esperados")
                {
                }
                field("Asistentes Reales"; "Asistentes Reales")
                {
                    Editable = wEditAsisReal;
                }
                field("Nivel Asistente"; "Nivel Asistente")
                {
                    Editable = false;
                }
                field("Grado Asistente"; "Grado Asistente")
                {
                    Editable = false;
                }
                field("Especialidad Asistente"; "Especialidad Asistente")
                {
                    Editable = false;
                }
                group(CDS)
                {
                    Caption = 'CDS';
                    field(INI; INI)
                    {
                        Editable = false;
                    }
                    field(PRI; PRI)
                    {
                        Editable = false;
                    }
                    field(SEC; SEC)
                    {
                        Editable = false;
                    }
                    field(ING; ING)
                    {
                        Editable = false;
                    }
                    field(PLA; PLA)
                    {
                        Editable = false;
                    }
                    field(ESI; ESI)
                    {
                        Editable = false;
                    }
                    field(GEN; GEN)
                    {
                        Editable = false;
                    }
                    field(IPR; IPR)
                    {
                        Editable = false;
                    }
                    field(IPS; IPS)
                    {
                        Editable = false;
                    }
                    field(PSE; PSE)
                    {
                        Editable = false;
                    }
                    field(TOTAL_CDS; INI + PRI + SEC + ING + PLA + ESI + GEN + IPR + IPS + PSE)
                    {
                        Caption = 'TOTAL CDS';
                        Editable = false;
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                }
            }
            group("Textos uitilizan")
            {
                Caption = 'Textos uitilizan';
                Visible = false;
                group("Grupo Santillana")
                {
                    Caption = 'Grupo Santillana';
                    Visible = false;
                    field("Artículo Grupo Santillana"; "Artículo Grupo Santillana")
                    {
                        Editable = wGS;
                        Visible = false;
                    }
                    field("Desc. Artículo Grupo Santillan"; "Desc. Artículo Grupo Santillan")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Horas por semana"; "Horas por semana")
                    {
                        Editable = wGS;
                    }
                    field("Año Adopción"; "Año Adopción")
                    {
                        Editable = false;
                        Visible = false;
                    }
                }
                group(Competencia)
                {
                    Caption = 'Competencia';
                    Visible = false;
                }
                field("Editorial Competencia"; "Editorial Competencia")
                {
                    Editable = wCompetencia;
                    Visible = false;
                }
                field("Nombre Editorial Competencia"; "Nombre Editorial Competencia")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Artículo Competencia"; "Artículo Competencia")
                {
                    Editable = wCompetencia;
                    Visible = false;
                }
                field(DC; "Desc.  Competencia")
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Event")
            {
                Caption = '&Event';
                separator()
                {
                }
                action("<Action1000000104>")
                {
                    Caption = '&Proponer fechas';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        pPropFechas: Page67132;
                        rPropFechas Record: 67088;
                    begin
                        TESTFIELD("No. Solicitud");

                        rPropFechas.FILTERGROUP(2);
                        rPropFechas.SETRANGE("No. Solicitud", "No. Solicitud");
                        rPropFechas.FILTERGROUP(0);
                        pPropFechas.SETTABLEVIEW(rPropFechas);
                        pPropFechas.Parametros(Status <= 2);
                        pPropFechas.RUN;
                    end;
                }
                action("&Equipments")
                {
                    Caption = '&Equipments';
                    Image = FileContract;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67089;
                    RunPageLink = No. Solicitud=FIELD(No. Solicitud);
                    Visible = wEquipos;
                }
                action("&Schedule")
                {
                    Caption = '&Schedule';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = wProgram;

                    trigger OnAction()
                    var
                        CabPlanEvent Record: 67051;
                        CabPlanEvent2Record 67051;
                        SolicPlan: Page67112;
                                       pCabPlan: Page67139;
                    begin

                        TESTFIELD("No. Solicitud");
                                       TESTFIELD("Tipo de Evento");
                                       TESTFIELD("Cod. Expositor");
                                       TESTFIELD("Cod. evento programado");


                                       IF NOT Tiene_Planificacion THEN
                          Crear_Planificacion;

                                       CabPlanEvent.SETRANGE("No. Solicitud","No. Solicitud");
                                       pCabPlan.SETTABLEVIEW(CabPlanEvent);
                                       pCabPlan.RUN;
                                       CLEAR(pCabPlan);
                                       Act_AsistentesReales;
                    end;
                }
                action("&Assistance")
                {
                    Caption = '&Assistance';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = wAsistentes;

                    trigger OnAction()
                    var
                        pAsistentes: Page67133;
                                         CabPlanEvent Record: 67051;
                    begin
                        TESTFIELD("No. Solicitud");
                                         TESTFIELD("Tipo de Evento");
                                         TESTFIELD("Cod. evento programado");
                                         TESTFIELD("Cod. Expositor");
                                         TESTFIELD("Cod. Colegio");
                                         IF "Grupo de Colegios" THEN
                          TESTFIELD("Asociacion/Grupo")
                        ELSE
                          TESTFIELD("Cod. Colegio");
                                         //TESTFIELD("Cod. Local");

                                         IF NOT Tiene_Planificacion THEN
                          Crear_Planificacion;


                                         CabPlanEvent.RESET;
                                         CabPlanEvent.SETRANGE("No. Solicitud","No. Solicitud");
                                         CabPlanEvent.FINDFIRST;
                                         pAsistentes.RecibeParametros("Cod. evento programado","Cod. Expositor",CabPlanEvent.Secuencia,"Tipo de Evento","Cod. Colegio",
                        "Cod. Local","Grupo de Colegios","Asociacion/Grupo");
                                         pAsistentes.RUN;
                                         CLEAR(pAsistentes);
                    end;
                }
                action("&Seguimiento")
                {
                    Caption = '&Seguimiento';
                    Image = Trace;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67121;
                                    RunPageLink = No. Solicitud=FIELD(No. Solicitud);
                }
                action("&Libros a Presentar")
                {
                    Caption = '&Libros a Presentar';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67130;
                                    RunPageLink = Núm. Solicitud=FIELD(No. Solicitud);
                }
                action("&Competencia")
                {
                    Caption = '&Competencia';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67131;
                                    RunPageLink = No. Solicitud=FIELD(No. Solicitud);
                }
                separator()
                {
                }
                action("Distribution per Cost Centre")
                {
                    Caption = 'Distribution per Cost Centre';
                    Image = GLAccountBalance;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = wCentros;

                    trigger OnAction()
                    var
                        GpoNegDistrib: Page67094;
                                           modif: Boolean;
                    begin
                        TESTFIELD("No. Solicitud");
                        TESTFIELD("Cod. Colegio");

                        IF (userPromotor) AND (Status > 0) THEN
                          modif := FALSE
                        ELSE
                          modif := TRUE;

                        IF Status <= 1 THEN
                          GpoNegDistrib.RecibeParametros("Cod. Colegio","No. Solicitud",'','','',0,FALSE,modif,"Asociacion/Grupo")
                        ELSE
                          GpoNegDistrib.RecibeParametros("Cod. Colegio","No. Solicitud",'','','',0,"Grupo de Colegios",modif,"Asociacion/Grupo");
                        GpoNegDistrib.RUNMODAL;
                    end;
                }
                action(Ranking)
                {
                    Caption = 'Ranking';
                    Image = ResourcePrice;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        pgRanking: Page67145;
                    begin
                        TESTFIELD("Cod. Colegio");
                        pgRanking.CalcularRanking("Cod. Colegio");
                        pgRanking.RUN;
                        CLEAR(pgRanking);
                    end;
                }
                separator()
                {
                }
                action("<Action1000000035>")
                {
                    Caption = 'Nivel Asistente';
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page 67122;
                                    RunPageLink = No. Solicitud=FIELD(No. Solicitud);
                }
                action("<Action1000000036>")
                {
                    Caption = 'Grado Asistente';
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page 67123;
                                    RunPageLink = No. Solicitud=FIELD(No. Solicitud);
                }
                action("<Action1000000037>")
                {
                    Caption = 'Especialidad Asistente';
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page 67124;
                                    RunPageLink = No. Solicitud=FIELD(No. Solicitud);
                }
                action("&Textos que utilizan")
                {
                    Caption = '&Textos que utilizan';
                    Image = Edit;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunPageMode = View;

                    trigger OnAction()
                    var
                        pTextos: Page67141;
                                     rAdop Record: 67035;
                                     rGrupoCOL Record: 67089;
                    begin
                        TESTFIELD("No. Solicitud");
                                     TESTFIELD("Cod. Colegio");
                                     IF ("Grupo de Colegios") AND (Status > 1 ) THEN BEGIN
                          rGrupoCOL.GET("Asociacion/Grupo");
                                     rGrupoCOL.CheckGrupo();
                                     rAdop.SETFILTER("Cod. Colegio",rGrupoCOL.GetColegios());
                        END
                        ELSE
                          rAdop.SETRANGE("Cod. Colegio", "Cod. Colegio");
                        pTextos.SETTABLEVIEW(rAdop);
                        pTextos.RUN;
                    end;
                }
            }
            group("&Post")
            {
                Caption = '&Post';
                action("&Post")
                {
                    Caption = '&Post';
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = wReg;

                    trigger OnAction()
                    var
                        Selection: Integer;
                        SegSol Record: 67079;
                    begin
                        IF (userPromotor) AND (Status > 0) THEN
                          EXIT;

                        CASE Status OF
                         0:
                          BEGIN
                          Valida_Enviado;
                           Status := 1;
                          END;
                         1:
                          BEGIN
                           Selection := STRMENU(Text000,1,Text003);
                           IF Selection = 2 THEN BEGIN
                              Valida_Aprobado;
                              Status := 2;
                           END
                           ELSE
                           IF Selection = 3 THEN BEGIN
                              Valida_Rechazado();
                              Status := 5;
                           END;
                          END;
                         2:
                          BEGIN
                           Selection := STRMENU(Text001,1,Text003);
                           IF Selection = 2 THEN BEGIN
                              Valida_Programado;
                              Status := 3;
                           END
                           ELSE
                           IF Selection = 3 THEN BEGIN
                              Valida_Cancelado();
                              Status := 4;
                           END;
                          END;
                         3:
                          BEGIN
                           Selection := STRMENU(Text002,1,Text003);
                           IF Selection = 2 THEN BEGIN
                              Valida_Realizado();
                              Status := 6
                           END
                           ELSE
                           IF Selection = 3 THEN BEGIN
                              Valida_Cancelado();
                              Status := 4;
                           END;

                          END;
                        END;

                        IF xRec.Status <> Status THEN
                          SegSol.InsertarSeguimiento(Rec);

                        MODIFY(TRUE);

                        Estado;
                        GrupoColegios;

                        //CurrPage.CLOSE;
                    end;
                }
            }
        }
        area(processing)
        {
            action("<Action1000000024>")
            {
                Caption = 'Generar Solicitud de Asistencia Técnica Pedagógica (Word)';

                trigger OnAction()
                var
                    cduWord: Codeunit 67001;
                begin
                    cduWord.GeneraWordSolicitudAsistencia("No. Solicitud");
                end;
            }
            action("<Action1000000045>")
            {
                Caption = 'Generar Ficha de PP.FF. (Word)';

                trigger OnAction()
                var
                    cduWord: Codeunit 67001;
                begin
                    cduWord.GeneraWordPPFF("No. Solicitud");
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Status := 0;
    end;

    trigger OnOpenPage()
    begin

        CLEAR(userPromotor);
        CurrPage.EDITABLE := TRUE;

        UserSetup.GET(USERID);

        IF (UserSetup."Salespers./Purch. Code" <> '') AND ("Cod. promotor" <> '')  THEN
           BEGIN
            userPromotor := TRUE;
            //SETRANGE("Cod. promotor",UserSetup."Salespers./Purch. Code");
            IF (Status <> 0)  OR ("Cod. promotor" <> UserSetup."Salespers./Purch. Code") THEN
              CurrPage.EDITABLE := FALSE;

           END;

        Estado;
        Editorial;
        ExisteEvento;
        GrupoColegios;


        //IF "Cod. evento" = '' THEN
        //   EditaDesc := TRUE;

        NoPertenecealCDS := FALSE;
        EditaDocente     := TRUE;

        IF "Tipo Responsable" = 1 THEN
           BEGIN
             NoPertenecealCDS := TRUE;
             EditaDocente     := FALSE;
           END;
    end;

    var
        UserSetup Record: 91;
        SalesPerson: Record 13;
        CodPromotor: Code[20];
        Text000: Label ',&Approve,&Reject';
        Text001: Label ',&Scheduled,&Rejected';
        Text002: Label ',&Realized,&Canceled';
        Text003: Label 'Change Status to';
        TipoResponsable: Option CDS,Otro;
        [InDataSet]
        NoPertenecealCDS: Boolean;
        [InDataSet]
        EditaDesc: Boolean;
        [InDataSet]
        EditaDocente: Boolean;
        [InDataSet]
        wApro: Boolean;
        [InDataSet]
        wRech: Boolean;
        [InDataSet]
        wProg: Boolean;
        [InDataSet]
        wCanc: Boolean;
        [InDataSet]
        wReal: Boolean;
        [InDataSet]
        wCentros: Boolean;
        [InDataSet]
        wEditAsisReal: Boolean;
        [InDataSet]
        wGS: Boolean;
        [InDataSet]
        wCompetencia: Boolean;
        [InDataSet]
        wProgram: Boolean;
        [InDataSet]
        wProp: Boolean;
        [InDataSet]
        wEquipos: Boolean;
        [InDataSet]
        wSeReq: Boolean;
        [InDataSet]
        wAsistentes: Boolean;
        [InDataSet]
        wExisteEv: Boolean;
        [InDataSet]
        wEvProg: Boolean;
        [InDataSet]
        userPromotor: Boolean;
        [InDataSet]
        wEditExisteEvento: Boolean;
        [InDataSet]
        wReg: Boolean;
        [InDataSet]
        wAsocGrupo: Boolean;
        [InDataSet]
        wElimProg: Boolean;

    procedure RecibeParam(CodProm: Code[20])
    begin
        CodPromotor := CodProm;
        //MESSAGE('%1',CodPromotor);
    end;

    procedure Estado()
    begin

        CLEAR(wApro);
        CLEAR(wRech);
        CLEAR(wProg);
        CLEAR(wCanc);
        CLEAR(wReal);
        CLEAR(wEditAsisReal);
        CLEAR(wProgram);
        CLEAR(wProp);
        CLEAR(wEquipos);
        CLEAR(wSeReq);
        CLEAR(wAsistentes);
        CLEAR(wEvProg);
        CLEAR(wEditExisteEvento);
        CLEAR(wElimProg);
        wReg := TRUE;
        IF (userPromotor) AND (Status > 0) THEN
          wReg := FALSE;


        CASE Status OF
          Status::" " :
           BEGIN
             wProp    := TRUE;
             wEditExisteEvento := TRUE;
           END;
          Status::"Enviada por promotor" :
           BEGIN
             wApro := TRUE;
             wRech := TRUE;
             wCentros := TRUE;
             wProp    := TRUE;
             wSeReq   := TRUE;
           END;
          Status::Aprobada :
           BEGIN
             wProg := TRUE;
             wCanc := TRUE;
             wCentros := TRUE;
             wAsistentes := TRUE;
             wProgram := TRUE;
             wProp    := TRUE;
             wEquipos := TRUE;
             wSeReq   := TRUE;
             wEvProg  := TRUE;
           END;
          Status::Programada :
           BEGIN
             wReal := TRUE;
             wCanc := TRUE;
             wCentros := TRUE;
             wEditAsisReal := TRUE;
             wAsistentes := TRUE;
             wProgram := TRUE;
             wEquipos := TRUE;
             wSeReq   := TRUE;
             wEvProg  := TRUE;
           END;

          Status::Realizada :
           BEGIN
             wReal := TRUE;
             wCanc := TRUE;
             wCentros := TRUE;
             wEditAsisReal := TRUE;
             wAsistentes := TRUE;
             wProgram := TRUE;
             wEquipos := TRUE;
             wSeReq   := TRUE;
           END;

          Status::Cancelada,Status::Cancelada:
           BEGIN
           END;

        END;
    end;

    procedure Editorial()
    begin

        CLEAR(wGS);
        CLEAR(wCompetencia);

        CASE "Selección Editorial" OF
          "Selección Editorial"::Santillana    : wGS := TRUE;
          "Selección Editorial"::Competencia           : wCompetencia := TRUE;
        END;
    end;

    procedure ExisteEvento()
    begin
        wExisteEv := FALSE;
        IF "Existe evento" THEN
          wExisteEv := TRUE;
    end;

    procedure GrupoColegios()
    begin
        wAsocGrupo := FALSE;
        IF ("Grupo de Colegios") AND (Status > 1) THEN
         wAsocGrupo := TRUE;
    end;

    procedure Act_AsistentesReales()
    var
        CabPlanEvent Record: 67051;
        rProg Record: 67015;
        Asist: Integer;
    begin

        Asist := 0;
        IF "No. Solicitud" <> '' THEN BEGIN
          CabPlanEvent.SETRANGE("No. Solicitud","No. Solicitud");
          IF CabPlanEvent.FINDSET THEN BEGIN
            rProg.SETRANGE("Cod. Taller - Evento",CabPlanEvent."Cod. Taller - Evento");
            rProg.SETRANGE("Tipo Evento",CabPlanEvent."Tipo Evento");
            rProg.SETRANGE("Tipo de Expositor",CabPlanEvent."Tipo de Expositor");
            rProg.SETRANGE(rProg.Expositor,CabPlanEvent.Expositor);
            rProg.SETRANGE(Secuencia, CabPlanEvent.Secuencia);
            IF rProg.FINDFIRST THEN BEGIN
               REPEAT
                 Asist += rProg."Nro. De asistentes reales";
               UNTIL rProg.NEXT=0;
            END;
            "Asistentes Reales" :=  Asist;
          END;
        END;
    end;
}

