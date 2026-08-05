page 55631 "Ficha Visitas Asesor/Consultor"
{
    PageType = Card;
    SourceTable = 55561;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = wMod;
                field("No. Visita Asesor/Consultor"; Rec."No. Visita Asesor/Consultor")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Visita Asesor/Consultor';
                    Caption = 'No. Visita';
                }
                field("Fecha Registro"; Rec."Fecha Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro';
                }
                field("Hora Registro"; Rec."Hora Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Registro';
                }
                field("Usuario Registro"; Rec."Usuario Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario Registro';
                }
                field("Cod. Asesor/Consultor"; Rec."Cod. Asesor/Consultor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Asesor/Consultor';
                }
                field("Nombre Asesor/Consultor"; Rec."Nombre Asesor/Consultor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Asesor/Consultor';
                }
                field("Tipo Visita"; Rec."Tipo Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Visita';

                    trigger OnValidate()
                    begin
                        ControlesTipoVisita;
                    end;
                }
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                    Editable = wEditSolicitud;
                }
                field("Grupo Negocio"; Rec."Grupo Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo Negocio';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Direccion Colegio"; Rec."Direccion Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Direccion Colegio';
                }
                field("Distrito Colegio"; Rec."Distrito Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Distrito Colegio';
                }
                field("Telefono 1 Colegio"; Rec."Telefono 1 Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono 1 Colegio';
                }
                field("Telefono 2 Colegio"; Rec."Telefono 2 Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono 2 Colegio';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Cod. promotor"; Rec."Cod. promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. promotor';
                }
                field("Nombre promotor"; Rec."Nombre promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre promotor';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                }
                field("No. Asistentes Esperados"; Rec."No. Asistentes Esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Asistentes Esperados';
                }
                field("No. Asistentes Reales"; Rec."No. Asistentes Reales")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Asistentes Reales';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field("Fecha Proxima Visita"; Rec."Fecha Proxima Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Proxima Visita';
                }
                field("Cod. Objetivo Visita"; Rec."Cod. Objetivo Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Objetivo Visita';
                }
                field("Desc. Objetivo Visita"; Rec."Desc. Objetivo Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc. Objetivo Visita';
                }
                field("Comentarios Visita"; Rec."Comentarios Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentarios Visita';
                }
            }
            group("Datos Contacto")
            {
                Caption = 'Datos Contacto';
                Editable = wMod;
                field("Tipo Persona Contacto"; Rec."Tipo Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Persona Contacto';

                    trigger OnValidate()
                    begin
                        ControlesCDS;
                    end;
                }
                field("Cod. Persona Contacto"; Rec."Cod. Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Persona Contacto';
                    Editable = wCDS;
                }
                field("Nombre Persona Contacto"; Rec."Nombre Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Persona Contacto';
                    Editable = NOT wCDS;
                }
                field("Cod. Cargo Persona Contacto"; Rec."Cod. Cargo Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cargo Persona Contacto';
                    Editable = NOT wCDS;
                }
                field("Desc. Cargo Persona Contacto"; Rec."Desc. Cargo Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc. Cargo Persona Contacto';
                }
                field("Telefono 1 Persona Contacto"; Rec."Telefono 1 Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono 1 Persona Contacto';
                    Editable = NOT wCDS;
                }
                field("Telefono 2 Persona Contacto"; Rec."Telefono 2 Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono 2 Persona Contacto';
                    Editable = NOT wCDS;
                }
                field("E-mail Persona Contacto"; Rec."E-mail Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-mail Persona Contacto';
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
                    ApplicationArea = All;
                    Caption = 'Registrar fecha y horarios';
                    ToolTip = 'Registrar fecha y horarios';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55632;
                    RunPageLink = "No. Visita" = FIELD("No. Visita Asesor/Consultor");
                }
                action("&Assistance")
                {
                    ApplicationArea = All;
                    Caption = '&Assistance';
                    ToolTip = '&Assistance';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        pAsistentes: Page 55636;
                        rProg: Record 55562;
                        Err001: Label 'Antes de inscribir docentes, tiene que registrar las fechas y horario de la visita.';
                    begin
                        TESTFIELD("No. Visita Asesor/Consultor");
                        TESTFIELD("Cod. Colegio");

                        rProg.RESET;
                        rProg.SETRANGE(rProg."No. Visita", "No. Visita Asesor/Consultor");
                        IF NOT rProg.FINDFIRST THEN
                            ERROR(Err001);
                        pAsistentes.RecibeParametros("No. Visita Asesor/Consultor", "Cod. Colegio", '');
                        pAsistentes.RUN;
                        CLEAR(pAsistentes);
                    end;
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

                    trigger OnAction()
                    var
                        GpoNegDistrib: Page 55633;
                    begin
                        TESTFIELD("No. Visita Asesor/Consultor");
                        TESTFIELD("Cod. Colegio");
                        GpoNegDistrib.RecibeParametros("No. Visita Asesor/Consultor", Estado = Estado::Programada);
                        GpoNegDistrib.RUNMODAL;
                    end;
                }
                action("Nivel Asistente")
                {
                    ApplicationArea = All;
                    Caption = 'Nivel Asistente';
                    ToolTip = 'Nivel Asistente';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55634;
                    RunPageLink = "No. Visita" = FIELD("No. Visita Asesor/Consultor"),
                                  "Tipo" = CONST(Nivel);
                }
                action("Grado Asistente")
                {
                    ApplicationArea = All;
                    Caption = 'Grado Asistente';
                    ToolTip = 'Grado Asistente';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55634;
                    RunPageLink = "No. Visita" = FIELD("No. Visita Asesor/Consultor"),
                                  "Tipo" = CONST(Grado);
                }
                action("Especialidad Asistente")
                {
                    ApplicationArea = All;
                    Caption = 'Especialidad Asistente';
                    ToolTip = 'Especialidad Asistente';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55634;
                    RunPageLink = "No. Visita" = FIELD("No. Visita Asesor/Consultor"),
                                  "Tipo" = CONST(Especialidad);
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
                        pgRanking: Page 55604;
                    begin
                        TESTFIELD("Cod. Colegio");
                        pgRanking.CalcularRanking("Cod. Colegio");
                        pgRanking.RUN;
                        CLEAR(pgRanking);
                    end;
                }
                action("Ejecutar Visita")
                {
                    ApplicationArea = All;
                    Caption = 'Ejecutar Visita';
                    ToolTip = 'Ejecutar Visita';
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
            wCambEstado := TRUE;

        ControlesCDS;

        ControlesTipoVisita;
    end;

    procedure ValidaDistrCC()
    var
        Distr: Record 55563;
        Err001: Label 'Debe realizar la distribucion de los centros de costo';
        Err002: Label 'No se ha realizado la distribucion de los centros de costo correctamente';
        Porc: Decimal;
    begin

        Distr.SETRANGE(Distr."No. Visita Consultor/Asesor", "No. Visita Asesor/Consultor");
        IF NOT Distr.FINDSET THEN
            ERROR(Err001);

        REPEAT
            Porc += Distr.Porcentaje;
        UNTIL Distr.NEXT = 0;

        IF Porc <> 100 THEN
            ERROR(Err002);
    end;

    procedure ValidaFechaHorarios()
    var
        rProg: Record 55562;
        rProg2: Record 55562;
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
            rProg2.SETFILTER("No. Linea", '<>%1', rProg."No. Linea");
            rProg2.SETRANGE("Fecha Programada", rProg."Fecha Programada");
            rProg2.SETFILTER("Hora Inicio Programada", '<%1', rProg."Hora Fin Programada");
            rProg2.SETFILTER("Hora Fin Programada", '>%1', rProg."Hora Inicio Programada");
            IF rProg2.FINDSET THEN
                ERROR(Err002);

        UNTIL rProg.NEXT = 0;
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
        rAsis: Record 55565;
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

