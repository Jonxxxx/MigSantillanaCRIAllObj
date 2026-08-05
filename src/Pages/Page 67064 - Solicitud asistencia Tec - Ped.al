page 67064 "Solicitud asistencia Tec - Ped"
{
    // ,Enviada por promotor
    // ,Aprobada
    // ,Programada
    // ,Cancelada
    // ,Rechazada
    // ,Realizada.

    Caption = 'Solicitud de Asistencia Técnico - Pedagogica';
    PageType = Card;
    PromotedActionCategories = 'Nuevo,Proceso,Reporte,Asistentes';
    SourceTable = 67055;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Cod. promotor"; Rec."Cod. promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. promotor';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        rVendedor: Record 13;
                        fVendedor: Page 14;
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
                field("Nombre promotor"; Rec."Nombre promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre promotor';
                    Editable = false;
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Grupo de Negocio"; Rec."Grupo de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Negocio';
                }
                field("Tipo de Evento"; Rec."Tipo de Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Evento';
                }
                field("Existe evento"; Rec."Existe evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Existe evento';
                    Editable = wEditExisteEvento;

                    trigger OnValidate()
                    begin
                        ExisteEvento;
                    end;
                }
                field("Cod. evento"; Rec."Cod. evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. evento';
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
                field("Descripcion evento"; Rec."Descripcion evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion evento';
                    Editable = NOT wExisteEv;
                }
                field("Evento dictado por (tipo)"; Rec."Evento dictado por (tipo)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Evento dictado por (tipo)';
                    Editable = false;
                    Visible = false;
                }
                field("Evento dictado por (codigo)"; Rec."Evento dictado por (codigo)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Evento dictado por (codigo)';
                    Editable = false;
                }
                field("Evento dictado por (nombre)"; Rec."Evento dictado por (nombre)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Evento dictado por (nombre)';
                    Editable = false;
                }
                field("Fecha Solicitud"; Rec."Fecha Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Solicitud';
                }
                field("Cod. evento programado"; Rec."Cod. evento programado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. evento programado';
                    Enabled = (NOT userPromotor) AND wEvProg;
                }
                field("Descripcion evento programado"; Rec."Descripcion evento programado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion evento programado';
                    Enabled = NOT userPromotor;
                }
                field("Avisado al expositor"; Rec."Avisado al expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Avisado al expositor';
                    Editable = wEvProg;
                    Enabled = NOT userPromotor;
                }
                field("Tipo de Expositor"; Rec."Tipo de Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Expositor';
                    Editable = false;
                    Enabled = NOT userPromotor;
                    Visible = false;
                }
                field("Cod. Expositor"; Rec."Cod. Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Expositor';
                    Editable = false;
                    Enabled = NOT userPromotor;
                }
                field("Nombre expositor"; Rec."Nombre expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre expositor';
                    Editable = false;
                    Enabled = NOT userPromotor;
                }
                field("Seleccion Editorial"; Rec."Seleccion Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Seleccion Editorial';

                    trigger OnValidate()
                    begin
                        Editorial;
                    end;
                }
                field("Desc.  Competencia"; Rec."Desc.  Competencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc.  Competencia';
                    Editable = wCompetencia;
                }
                field("Grupo de Colegios"; Rec."Grupo de Colegios")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Colegios';

                    trigger OnValidate()
                    begin
                        GrupoColegios;
                    end;
                }
                field("Asociacion/Grupo"; Rec."Asociacion/Grupo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asociacion/Grupo';
                    Enabled = wAsocGrupo;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                    Enabled = NOT wAsocGrupo;
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Editable = false;
                }
                field("Direccion Colegio"; Rec."Direccion Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Direccion Colegio';
                    Editable = false;
                }
                field("Codigo Distrito Colegio"; Rec."Codigo Distrito Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Distrito Colegio';
                    Editable = false;
                }
                field("Nombre Distrito Colegio"; Rec."Nombre Distrito Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Distrito Colegio';
                    Editable = false;
                }
                field("Telefono 1 Colegio"; Rec."Telefono 1 Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono 1 Colegio';
                    Editable = false;
                }
                field("Telefono 2 Colegio"; Rec."Telefono 2 Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono 2 Colegio';
                    Editable = false;
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                    Importance = Additional;
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                }
                field("Comentario Aprobado"; Rec."Comentario Aprobado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario Aprobado';
                    Visible = wApro;
                }
                field("Comentario Programado"; Rec."Comentario Programado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario Programado';
                    Visible = wProg;
                }
                field("Comentario Rechazado"; Rec."Comentario Rechazado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario Rechazado';
                    Visible = wRech;
                }
                field("Comentario Cancelado"; Rec."Comentario Cancelado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario Cancelado';
                    Visible = wCanc;
                }
                field(Referencia; Rec.Referencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Referencia';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                    Editable = false;
                }
                field("Usuario creacion"; Rec."Usuario creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario creacion';
                }
            }
            group("Aditional Information")
            {
                Caption = 'Aditional Information';
                field("Tipo Responsable"; Rec."Tipo Responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Responsable';
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
                field("Cod. Docente responsable"; Rec."Cod. Docente responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Docente responsable';
                    Editable = EditaDocente;
                }
                field("Nombre responsable"; Rec."Nombre responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre responsable';
                    Editable = NoPertenecealCDS;
                }
                field("Cod. Cargo Responsable"; Rec."Cod. Cargo Responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cargo Responsable';
                    Editable = NoPertenecealCDS;
                }
                field("Descripcion Cargo Responsable"; Rec."Descripcion Cargo Responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Cargo Responsable';
                    Editable = NoPertenecealCDS;
                }
                field("Telefono Responsable"; Rec."Telefono Responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono Responsable';
                }
                field("No. celular responsable"; Rec."No. celular responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. celular responsable';
                }
                field("E-Mail Docente Responsable"; Rec."E-Mail Docente Responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail Docente Responsable';
                }
                field("Col. tiene equipo MM"; Rec."Col. tiene equipo MM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Col. tiene equipo MM';
                    Caption = 'Colegio tiene equipo Multimedia';
                }
                field(Refrigerio; Rec.Refrigerio)
                {
                    ApplicationArea = All;
                    ToolTip = 'Refrigerio';
                    Caption = 'Se requiere Refrigerio';
                    Editable = wSeReq;
                }
                field(Material; Rec.Material)
                {
                    ApplicationArea = All;
                    ToolTip = 'Material';
                    Caption = 'Se requiere Material';
                    Editable = wSeReq;
                }
                field(Merchandising; Rec.Merchandising)
                {
                    ApplicationArea = All;
                    ToolTip = 'Merchandising';
                    Caption = 'Se requiere Merchandising';
                    Editable = wSeReq;
                }
                field("Cod. objetivo promotor"; Rec."Cod. objetivo promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. objetivo promotor';
                }
                field("Objetivo promotor"; Rec."Objetivo promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Objetivo promotor';
                    Editable = false;
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ApplicationArea = All;
                    ToolTip = 'Observaciones';
                    Caption = 'Observaciones promotor';
                }
            }
            group(Asistentes)
            {
                Caption = 'Asistentes';
                field("Asistencia promotor"; Rec."Asistencia promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistencia promotor';
                }
                field("Material para revision"; Rec."Material para revision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Material para revision';
                }
                field("Asistentes Esperados"; Rec."Asistentes Esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes Esperados';
                }
                field("Asistentes Reales"; Rec."Asistentes Reales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes Reales';
                    Editable = wEditAsisReal;
                }
                field("Nivel Asistente"; Rec."Nivel Asistente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel Asistente';
                    Editable = false;
                }
                field("Grado Asistente"; Rec."Grado Asistente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grado Asistente';
                    Editable = false;
                }
                field("Especialidad Asistente"; Rec."Especialidad Asistente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especialidad Asistente';
                    Editable = false;
                }
                group(CDS)
                {
                    Caption = 'CDS';
                    field(INI; Rec.INI)
                    {
                        ApplicationArea = All;
                        ToolTip = 'INI';
                        Editable = false;
                    }
                    field(PRI; Rec.PRI)
                    {
                        ApplicationArea = All;
                        ToolTip = 'PRI';
                        Editable = false;
                    }
                    field(SEC; Rec.SEC)
                    {
                        ApplicationArea = All;
                        ToolTip = 'SEC';
                        Editable = false;
                    }
                    field(ING; Rec.ING)
                    {
                        ApplicationArea = All;
                        ToolTip = 'ING';
                        Editable = false;
                    }
                    field(PLA; Rec.PLA)
                    {
                        ApplicationArea = All;
                        ToolTip = 'PLA';
                        Editable = false;
                    }
                    field(ESI; Rec.ESI)
                    {
                        ApplicationArea = All;
                        ToolTip = 'ESI';
                        Editable = false;
                    }
                    field(GEN; Rec.GEN)
                    {
                        ApplicationArea = All;
                        ToolTip = 'GEN';
                        Editable = false;
                    }
                    field(IPR; Rec.IPR)
                    {
                        ApplicationArea = All;
                        ToolTip = 'IPR';
                        Editable = false;
                    }
                    field(IPS; Rec.IPS)
                    {
                        ApplicationArea = All;
                        ToolTip = 'IPS';
                        Editable = false;
                    }
                    field(PSE; Rec.PSE)
                    {
                        ApplicationArea = All;
                        ToolTip = 'PSE';
                        Editable = false;
                    }
                    field(TOTAL_CDS; INI + PRI + SEC + ING + PLA + ESI + GEN + IPR + IPS + PSE)
                    {
                        ApplicationArea = All;
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
                    field("Articulo Grupo Santillana"; Rec."Articulo Grupo Santillana")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Articulo Grupo Santillana';
                        Editable = wGS;
                        Visible = false;
                    }
                    field("Desc. Articulo Grupo Santillan"; Rec."Desc. Articulo Grupo Santillan")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Desc. Articulo Grupo Santillan';
                        Editable = false;
                        Visible = false;
                    }
                    field("Horas por semana"; Rec."Horas por semana")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Horas por semana';
                        Editable = wGS;
                    }
                    field("Año Adopcion"; Rec."Ano Adopcion")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Ano Adopcion';
                        Editable = false;
                        Visible = false;
                    }
                }
                group(Competencia)
                {
                    Caption = 'Competencia';
                    Visible = false;
                }
                field("Editorial Competencia"; Rec."Editorial Competencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Editorial Competencia';
                    Editable = wCompetencia;
                    Visible = false;
                }
                field("Nombre Editorial Competencia"; Rec."Nombre Editorial Competencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Editorial Competencia';
                    Editable = false;
                    Visible = false;
                }
                field("Articulo Competencia"; Rec."Articulo Competencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Articulo Competencia';
                    Editable = wCompetencia;
                    Visible = false;
                }
                field(DC; Rec."Desc.  Competencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc.  Competencia';
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

                action("<Action1000000104>")
                {
                    ApplicationArea = All;
                    Caption = '&Proponer fechas';
                    ToolTip = '&Proponer fechas';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        pPropFechas: Page 67132;
                        rPropFechas: Record 67088;
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
                    ApplicationArea = All;
                    Caption = '&Equipments';
                    ToolTip = '&Equipments';
                    Image = FileContract;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67089;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                    Visible = wEquipos;
                }
                action("&Schedule")
                {
                    ApplicationArea = All;
                    Caption = '&Schedule';
                    ToolTip = '&Schedule';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = wProgram;

                    trigger OnAction()
                    var
                        CabPlanEvent: Record 67051;
                        CabPlanEvent2Record: Record 67051;
                        SolicPlan: Page 67112;
                        pCabPlan: Page 67139;
                    begin

                        TESTFIELD("No. Solicitud");
                        TESTFIELD("Tipo de Evento");
                        TESTFIELD("Cod. Expositor");
                        TESTFIELD("Cod. evento programado");


                        IF NOT Tiene_Planificacion THEN
                            Crear_Planificacion;

                        CabPlanEvent.SETRANGE("No. Solicitud", "No. Solicitud");
                        pCabPlan.SETTABLEVIEW(CabPlanEvent);
                        pCabPlan.RUN;
                        CLEAR(pCabPlan);
                        Act_AsistentesReales;
                    end;
                }
                action("&Assistance")
                {
                    ApplicationArea = All;
                    Caption = '&Assistance';
                    ToolTip = '&Assistance';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = wAsistentes;

                    trigger OnAction()
                    var
                        pAsistentes: Page 67133;
                        CabPlanEvent: Record 67051;
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
                        CabPlanEvent.SETRANGE("No. Solicitud", "No. Solicitud");
                        CabPlanEvent.FINDFIRST;
                        pAsistentes.RecibeParametros("Cod. evento programado", "Cod. Expositor", CabPlanEvent.Secuencia, "Tipo de Evento", "Cod. Colegio",
       "Cod. Local", "Grupo de Colegios", "Asociacion/Grupo");
                        pAsistentes.RUN;
                        CLEAR(pAsistentes);
                    end;
                }
                action("&Seguimiento")
                {
                    ApplicationArea = All;
                    Caption = '&Seguimiento';
                    ToolTip = '&Seguimiento';
                    Image = Trace;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67121;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                }
                action("&Libros a Presentar")
                {
                    ApplicationArea = All;
                    Caption = '&Libros a Presentar';
                    ToolTip = '&Libros a Presentar';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67130;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                }
                action("&Competencia")
                {
                    ApplicationArea = All;
                    Caption = '&Competencia';
                    ToolTip = '&Competencia';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67131;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                }

                action("Distribution per Cost Centre")
                {
                    ApplicationArea = All;
                    Caption = 'Distribution per Cost Centre';
                    ToolTip = 'Distribution per Cost Centre';
                    Image = GLAccountBalance;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = wCentros;

                    trigger OnAction()
                    var
                        GpoNegDistrib: Page 67094;
                        modif: Boolean;
                    begin
                        TESTFIELD("No. Solicitud");
                        TESTFIELD("Cod. Colegio");

                        IF (userPromotor) AND (Status > 0) THEN
                            modif := FALSE
                        ELSE
                            modif := TRUE;

                        IF Status <= 1 THEN
                            GpoNegDistrib.RecibeParametros("Cod. Colegio", "No. Solicitud", '', '', '', 0, FALSE, modif, "Asociacion/Grupo")
                        ELSE
                            GpoNegDistrib.RecibeParametros("Cod. Colegio", "No. Solicitud", '', '', '', 0, "Grupo de Colegios", modif, "Asociacion/Grupo");
                        GpoNegDistrib.RUNMODAL;
                    end;
                }
                action(Ranking)
                {
                    ApplicationArea = All;
                    Caption = 'Ranking';
                    ToolTip = 'Ranking';
                    Image = ResourcePrice;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        pgRanking: Page 67145;
                    begin
                        TESTFIELD("Cod. Colegio");
                        pgRanking.CalcularRanking(Rec."Cod. Colegio");
                        pgRanking.RUN;
                        CLEAR(pgRanking);
                    end;
                }

                action("<Action1000000035>")
                {
                    ApplicationArea = All;
                    Caption = 'Nivel Asistente';
                    ToolTip = 'Nivel Asistente';
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page 67122;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                }
                action("<Action1000000036>")
                {
                    ApplicationArea = All;
                    Caption = 'Grado Asistente';
                    ToolTip = 'Grado Asistente';
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page 67123;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                }
                action("<Action1000000037>")
                {
                    ApplicationArea = All;
                    Caption = 'Especialidad Asistente';
                    ToolTip = 'Especialidad Asistente';
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page 67124;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                }
                action("&Textos que utilizan")
                {
                    ApplicationArea = All;
                    Caption = '&Textos que utilizan';
                    ToolTip = '&Textos que utilizan';
                    Image = Edit;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunPageMode = View;

                    trigger OnAction()
                    var
                        pTextos: Page 67141;
                        rAdop: Record 67035;
                        rGrupoCOL: Record 67089;
                    begin
                        TESTFIELD("No. Solicitud");
                        TESTFIELD("Cod. Colegio");
                        IF ("Grupo de Colegios") AND (Status > 1) THEN BEGIN
                            rGrupoCOL.GET("Asociacion/Grupo");
                            rGrupoCOL.CheckGrupo();
                            rAdop.SETFILTER("Cod. Colegio", rGrupoCOL.GetColegios());
                        END
                        ELSE
                            rAdop.SETRANGE("Cod. Colegio", "Cod. Colegio");
                        pTextos.SETTABLEVIEW(rAdop);
                        pTextos.RUN;
                    end;
                }
            }
            group("EXCCRIPost")
            {
                Caption = '&Post';
                action("&Post")
                {
                    ApplicationArea = All;
                    Caption = '&Post';
                    ToolTip = '&Post';
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = wReg;

                    trigger OnAction()
                    var
                        Selection: Integer;
                        SegSol: Record 67079;
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
                                    Selection := STRMENU(Text000, 1, Text003);
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
                                    Selection := STRMENU(Text001, 1, Text003);
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
                                    Selection := STRMENU(Text002, 1, Text003);
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

                ApplicationArea = All;
                Caption = 'Generar Solicitud de Asistencia Técnica Pedagogica (Word)';
                ToolTip = 'Generar Solicitud de Asistencia Técnica Pedagogica (Word)';
                trigger OnAction()
                var
                // TODO: Manual review - Codeunit 55468 exists, but its Word Automation and server-file implementation is disabled and requires a SaaS document-generation redesign.
                // Original code: cduWord: Codeunit 55468;
                begin
                    // Original code: cduWord.GeneraWordSolicitudAsistencia("No. Solicitud");
                end;
            }
            action("<Action1000000045>")
            {

                ApplicationArea = All;
                Caption = 'Generar Ficha de PP.FF. (Word)';
                ToolTip = 'Generar Ficha de PP.FF. (Word)';
                trigger OnAction()
                var
                // TODO: Manual review - Codeunit 55468 exists, but its Word Automation and server-file implementation is disabled and requires a SaaS document-generation redesign.
                // Original code: cduWord: Codeunit 55468;
                begin
                    // Original code: cduWord.GeneraWordPPFF("No. Solicitud");
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

        IF (UserSetup."Salespers./Purch. Code" <> '') AND ("Cod. promotor" <> '') THEN BEGIN
            userPromotor := TRUE;
            //SETRANGE("Cod. promotor",UserSetup."Salespers./Purch. Code");
            IF (Status <> 0) OR ("Cod. promotor" <> UserSetup."Salespers./Purch. Code") THEN
                CurrPage.EDITABLE := FALSE;

        END;

        Estado;
        Editorial;
        ExisteEvento;
        GrupoColegios;


        //IF "Cod. evento" = '' THEN
        //   EditaDesc := TRUE;

        NoPertenecealCDS := FALSE;
        EditaDocente := TRUE;

        IF "Tipo Responsable" = 1 THEN BEGIN
            NoPertenecealCDS := TRUE;
            EditaDocente := FALSE;
        END;
    end;

    var
        UserSetup: Record 91;
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
            Status::" ":
                BEGIN
                    wProp := TRUE;
                    wEditExisteEvento := TRUE;
                END;
            Status::"Enviada por promotor":
                BEGIN
                    wApro := TRUE;
                    wRech := TRUE;
                    wCentros := TRUE;
                    wProp := TRUE;
                    wSeReq := TRUE;
                END;
            Status::Aprobada:
                BEGIN
                    wProg := TRUE;
                    wCanc := TRUE;
                    wCentros := TRUE;
                    wAsistentes := TRUE;
                    wProgram := TRUE;
                    wProp := TRUE;
                    wEquipos := TRUE;
                    wSeReq := TRUE;
                    wEvProg := TRUE;
                END;
            Status::Programada:
                BEGIN
                    wReal := TRUE;
                    wCanc := TRUE;
                    wCentros := TRUE;
                    wEditAsisReal := TRUE;
                    wAsistentes := TRUE;
                    wProgram := TRUE;
                    wEquipos := TRUE;
                    wSeReq := TRUE;
                    wEvProg := TRUE;
                END;

            Status::Realizada:
                BEGIN
                    wReal := TRUE;
                    wCanc := TRUE;
                    wCentros := TRUE;
                    wEditAsisReal := TRUE;
                    wAsistentes := TRUE;
                    wProgram := TRUE;
                    wEquipos := TRUE;
                    wSeReq := TRUE;
                END;

        // TODO: Manual review - The legacy CASE branch repeats Status::Cancelada and contains no behavior, so the intended missing status branch cannot be determined.
        // Original code preserved below.
        // Status::Cancelada, Status::Cancelada:
        //     BEGIN
        //     END;

        END;
    end;

    procedure Editorial()
    begin

        CLEAR(wGS);
        CLEAR(wCompetencia);

        CASE "Seleccion Editorial" OF
            "Seleccion Editorial"::Santillana:
                wGS := TRUE;
            "Seleccion Editorial"::Competencia:
                wCompetencia := TRUE;
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
        CabPlanEvent: Record 67051;
        rProg: Record 55482;
        Asist: Integer;
    begin

        Asist := 0;
        IF "No. Solicitud" <> '' THEN BEGIN
            CabPlanEvent.SETRANGE("No. Solicitud", "No. Solicitud");
            IF CabPlanEvent.FINDSET THEN BEGIN
                rProg.SETRANGE("Cod. Taller - Evento", CabPlanEvent."Cod. Taller - Evento");
                rProg.SETRANGE("Tipo Evento", CabPlanEvent."Tipo Evento");
                rProg.SETRANGE("Tipo de Expositor", CabPlanEvent."Tipo de Expositor");
                rProg.SETRANGE(rProg.Expositor, CabPlanEvent.Expositor);
                rProg.SETRANGE(Secuencia, CabPlanEvent.Secuencia);
                IF rProg.FINDFIRST THEN BEGIN
                    REPEAT
                        Asist += rProg."Nro. De asistentes reales";
                    UNTIL rProg.NEXT = 0;
                END;
                "Asistentes Reales" := Asist;
            END;
        END;
    end;
}

