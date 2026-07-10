page 67172 "Ficha Visitas Asesor/Consultor"
{
    PageType = Card;
    SourceTable = Table67102;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = wMod;
                field("No. Visita Asesor/Consultor"; "No. Visita Asesor/Consultor")
                {
                    Caption = 'No. Visita';
                }
                field("Fecha Registro"; "Fecha Registro")
                {
                }
                field("Hora Registro"; "Hora Registro")
                {
                }
                field("Usuario Registro"; "Usuario Registro")
                {
                }
                field("Cod. Asesor/Consultor"; "Cod. Asesor/Consultor")
                {
                }
                field("Nombre Asesor/Consultor"; "Nombre Asesor/Consultor")
                {
                }
                field("Tipo Visita"; "Tipo Visita")
                {

                    trigger OnValidate()
                    begin
                        ControlesTipoVisita;
                    end;
                }
                field("No. Solicitud"; "No. Solicitud")
                {
                    Editable = wEditSolicitud;
                }
                field("Grupo Negocio"; "Grupo Negocio")
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Dirección Colegio"; "Dirección Colegio")
                {
                }
                field("Distrito Colegio"; "Distrito Colegio")
                {
                }
                field("Teléfono 1 Colegio"; "Teléfono 1 Colegio")
                {
                }
                field("Teléfono 2 Colegio"; "Teléfono 2 Colegio")
                {
                }
                field(Delegación; Delegación)
                {
                }
                field("Cod. promotor"; "Cod. promotor")
                {
                }
                field("Nombre promotor"; "Nombre promotor")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                }
                field("No. Asistentes Esperados"; "No. Asistentes Esperados")
                {
                }
                field("No. Asistentes Reales"; "No. Asistentes Reales")
                {
                }
                field(Estado; Estado)
                {
                }
                field("Fecha Próxima Visita"; "Fecha Próxima Visita")
                {
                }
                field("Cód. Objetivo Visita"; "Cód. Objetivo Visita")
                {
                }
                field("Desc. Objetivo Visita"; "Desc. Objetivo Visita")
                {
                }
                field("Comentarios Visita"; "Comentarios Visita")
                {
                }
            }
            group("Datos Contacto")
            {
                Caption = 'Datos Contacto';
                Editable = wMod;
                field("Tipo Persona Contacto"; "Tipo Persona Contacto")
                {

                    trigger OnValidate()
                    begin
                        ControlesCDS;
                    end;
                }
                field("Cod. Persona Contacto"; "Cod. Persona Contacto")
                {
                    Editable = wCDS;
                }
                field("Nombre Persona Contacto"; "Nombre Persona Contacto")
                {
                    Editable = NOT wCDS;
                }
                field("Cod. Cargo Persona Contacto"; "Cod. Cargo Persona Contacto")
                {
                    Editable = NOT wCDS;
                }
                field("Desc. Cargo Persona Contacto"; "Desc. Cargo Persona Contacto")
                {
                }
                field("Teléfono 1 Persona Contacto"; "Teléfono 1 Persona Contacto")
                {
                    Editable = NOT wCDS;
                }
                field("Teléfono 2 Persona Contacto"; "Teléfono 2 Persona Contacto")
                {
                    Editable = NOT wCDS;
                }
                field("E-mail Persona Contacto"; "E-mail Persona Contacto")
                {
                    Editable = NOT wCDS;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("<Action1000000038>")
            {
                Caption = 'Visita';
                action("Registrar fecha y horarios")
                {
                    Caption = 'Registrar fecha y horarios';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67173;
                    RunPageLink = No. Visita=FIELD(No. Visita Asesor/Consultor);
                }
                action("&Assistance")
                {
                    Caption = '&Assistance';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        pAsistentes: Page67177;
                                         rProg Record: 67103;
                                         Err001: Label 'Antes de inscribir docentes, tiene que registrar las fechas y horario de la visita.';
                    begin
                        TESTFIELD("No. Visita Asesor/Consultor");
                        TESTFIELD("Cod. Colegio");

                        rProg.RESET;
                        rProg.SETRANGE(rProg."No. Visita","No. Visita Asesor/Consultor");
                        IF NOT rProg.FINDFIRST THEN
                          ERROR(Err001);
                        pAsistentes.RecibeParametros("No. Visita Asesor/Consultor","Cod. Colegio",'');
                        pAsistentes.RUN;
                        CLEAR(pAsistentes);
                    end;
                }
                action("Distribution per Cost Centre")
                {
                    Caption = 'Distribution per Cost Centre';
                    Image = GLAccountBalance;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        GpoNegDistrib: Page67174;
                    begin
                        TESTFIELD("No. Visita Asesor/Consultor");
                        TESTFIELD("Cod. Colegio");
                        GpoNegDistrib.RecibeParametros("No. Visita Asesor/Consultor",Estado = Estado::Programada);
                        GpoNegDistrib.RUNMODAL;
                    end;
                }
                action("Nivel Asistente")
                {
                    Caption = 'Nivel Asistente';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67175;
                                    RunPageLink = No. Visita=FIELD(No. Visita Asesor/Consultor),
                                  Tipo=CONST(Nivel);
                }
                action("Grado Asistente")
                {
                    Caption = 'Grado Asistente';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67175;
                                    RunPageLink = No. Visita=FIELD(No. Visita Asesor/Consultor),
                                  Tipo=CONST(Grado);
                }
                action("Especialidad Asistente")
                {
                    Caption = 'Especialidad Asistente';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67175;
                                    RunPageLink = No. Visita=FIELD(No. Visita Asesor/Consultor),
                                  Tipo=CONST(Especialidad);
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
                action("Ejecutar Visita")
                {
                    Caption = 'Ejecutar Visita';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = wCambEstado;

                    trigger OnAction()
                    begin

                        TESTFIELD("Cod. Colegio");
                        TESTFIELD("Cod. promotor");
                        TESTFIELD("Cod. Asesor/Consultor");

                        ValidaDistrCC;

                        ValidaFechaHorarios;

                        Estado := Estado::Ejecutada;

                        ActControles;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        ActControles;
    end;

    var
        [InDataSet]
        wCambEstado: Boolean;
        [InDataSet]
        wMod: Boolean;
        [InDataSet]
        wCDS: Boolean;
        [InDataSet]
        wEditSolicitud: Boolean;

    procedure ActControles()
    begin

        wMod := TRUE;
        IF Estado = Estado::Ejecutada THEN
          wMod := FALSE;

        wCambEstado := FALSE;
        IF Estado = Estado::Programada THEN
          wCambEstado  := TRUE;

        ControlesCDS;

        ControlesTipoVisita;
    end;

    procedure ValidaDistrCC()
    var
        Distr Record: 67104;
        Err001: Label 'Debe realizar la distribución de los centros de costo';
        Err002: Label 'No se ha realizado la distribución de los centros de costo correctamente';
        Porc: Decimal;
    begin

        Distr.SETRANGE(Distr."No. Visita Consultor/Asesor", "No. Visita Asesor/Consultor");
        IF NOT Distr.FINDSET THEN
          ERROR(Err001);

        REPEAT
          Porc += Distr.Porcentaje;
        UNTIL Distr.NEXT=0;

        IF Porc <> 100 THEN
          ERROR(Err002);
    end;

    procedure ValidaFechaHorarios()
    var
        rProg Record: 67103;
        rProg2Record 67103;
        Err001: Label 'No se ha realizado el registro de fechas y horario de visitas.';
        Err002: Label 'Revise el registro de fechas y horario de visitas. No se permite solapamientos.';
        Err003: Label 'Revise el registro de fechas y horario de visitas. Es obligatorio ingresar la fecha, hora de inicio y hora fin.';
    begin

        rProg.SETRANGE(rProg."No. Visita", "No. Visita Asesor/Consultor");
        IF NOT rProg.FINDSET THEN
          ERROR(Err001);
        REPEAT

          IF (rProg."Fecha Programada" = 0D) OR (rProg."Hora Inicio Programada" = 0T) OR (rProg."Hora Fin Programada" = 0T) THEN
            ERROR(Err003);

          rProg2.RESET;
          rProg2.SETRANGE("No. Visita", rProg."No. Visita");
          rProg2.SETFILTER("No. Linea",'<>%1', rProg."No. Linea");
          rProg2.SETRANGE("Fecha Programada", rProg."Fecha Programada");
          rProg2.SETFILTER("Hora Inicio Programada",'<%1',rProg."Hora Fin Programada");
          rProg2.SETFILTER("Hora Fin Programada",'>%1',rProg."Hora Inicio Programada");
          IF rProg2.FINDSET THEN
            ERROR(Err002);

        UNTIL rProg.NEXT=0;
    end;

    procedure ControlesCDS()
    begin

        wCDS := FALSE;
        IF "Tipo Persona Contacto" = "Tipo Persona Contacto"::CDS THEN
          wCDS := TRUE;
    end;

    procedure ControlesTipoVisita()
    begin

        wEditSolicitud := FALSE;
        IF "Tipo Visita" = "Tipo Visita"::Solicitada THEN
          wEditSolicitud := TRUE;
    end;

    procedure Act_AsistentesReales()
    var
        rAsis Record: 67106;
        Asist: Integer;
    begin
        /*
        Asist := 0;
        IF "No. Visita Asesor/Consultor" <> '' THEN BEGIN
          rAsis.SETRANGE("No. Visita","No. Visita Asesor/Consultor");
         "No. Asistentes Reales" := rAsis.COUNT;
        END;
        */

    end;
}

